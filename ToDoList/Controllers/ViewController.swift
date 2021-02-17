//
//  ViewController.swift
//  ToDoList
//
//  Created by msc on 25.12.2020.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    var delegate: AddTaskDelegate?
    let localID = Locale.preferredLanguages.first
    
    var task: TaskModel?
    
    //MARK: - UI

    
    private let taskHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Task"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private let taskHeaderTF: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 17)
        textField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.becomeFirstResponder()
        textField.addTarget(self, action: #selector(updateSaveButton), for: .editingChanged)
        return textField
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private let descriptionView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 10
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 17)
        textView.contentInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        textView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        return textView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
   private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.tintColor = UIColor.black
        picker.minimumDate = Date()
        return picker
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:.save , target: self, action: #selector(saveTask))
        view.backgroundColor = .white
        view.addSubview(taskHeaderLabel)
        view.addSubview(taskHeaderTF)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionView)
        view.addSubview(timeLabel)
        view.addSubview(datePicker)
        setupLayout()
        updateUI()
        updateSaveButton()
    }
    
   // MARK: - Methods
    
    private func updateUI() {
        
        taskHeaderTF.text = task?.taskHeader
        descriptionView.text = task?.description
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        guard let dateOfTask = task?.date else {return}
        if let taskDate = formatter.date(from: dateOfTask) {
            datePicker.date = taskDate
        }
        
    }
    
    @objc private func updateSaveButton() {
        let taskText = taskHeaderTF.text ?? ""
        navigationItem.rightBarButtonItem?.isEnabled = !taskText.isEmpty
    }
    
    @objc private func saveTask() {
        guard let newTask = taskHeaderTF.text, taskHeaderTF.hasText else {return}
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: localID!)
        let taskerDate = formatter.string(from: datePicker.date)
        let descriptionTask = descriptionView.text
        
        let task = TaskModel(taskHeader: newTask, date: taskerDate, description: descriptionTask, isComleted: false)
        
        delegate?.addTask(task: task)
        
        
        navigationController?.popViewController(animated: true)
        
    }
    
    private func setupLayout() {
        
        let offset = 24
        
        taskHeaderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide) .offset (offset)
            make.leading.equalTo(view.safeAreaLayoutGuide) .inset(16)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        taskHeaderTF.snp.makeConstraints { (make) in
            make.top.equalTo(taskHeaderLabel.snp.bottom) .offset(12)
            make.height.equalTo (40)
            make.leading.trailing.equalToSuperview() .inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(taskHeaderTF.snp.bottom) .offset (offset)
            make.leading.equalTo(view.safeAreaLayoutGuide) .inset(16)
            make.width.equalTo (100)
            make.height.equalTo (40)
        }
        
        descriptionView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom) .offset(12)
            make.height.equalTo(150)
            make.trailing.leading.equalToSuperview() .inset(16)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionView.snp.bottom) .offset(offset)
            make.leading.equalTo(view.safeAreaLayoutGuide) .inset(16)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        datePicker.snp.makeConstraints { (make) in
            make.top.equalTo(timeLabel.snp.bottom) .offset(12)
            make.height.equalTo(40)
            make.trailing.leading.equalToSuperview() .inset(16)
        }
      
    }
    
}


