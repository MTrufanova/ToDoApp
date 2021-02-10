//
//  ViewController.swift
//  ToDoList
//
//  Created by msc on 25.12.2020.
//

import UIKit

final class ViewController: UIViewController {
    
    var delegate: AddTaskDelegate?
    let localID = Locale.preferredLanguages.first
    
    var task: TaskModel?
    
    //MARK: - UI

    
    private let taskHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Task"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let taskHeaderTF: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 18)
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.becomeFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(updateSaveButton), for: .editingChanged)
        return textField
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 10
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 18)
        textView.textAlignment = .center
        textView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        textView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
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
        NSLayoutConstraint.activate([
            taskHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            taskHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            taskHeaderLabel.widthAnchor.constraint(equalToConstant: 150),
            taskHeaderTF.heightAnchor.constraint(equalToConstant: 40),
            
            taskHeaderTF.topAnchor.constraint(equalTo: taskHeaderLabel.bottomAnchor, constant: 16),
            taskHeaderTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskHeaderTF.widthAnchor.constraint(equalToConstant: view.bounds.width - 50),
            taskHeaderTF.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionLabel.topAnchor.constraint(equalTo: taskHeaderTF.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 100),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            descriptionView.widthAnchor.constraint(equalToConstant: view.bounds.width - 50),
            descriptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionView.heightAnchor.constraint(equalToConstant: 150 ),
            
            timeLabel.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 16),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            timeLabel.widthAnchor.constraint(equalToConstant: 100),
            timeLabel.heightAnchor.constraint(equalToConstant: 40),
            
            datePicker.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.widthAnchor.constraint(equalToConstant: view.bounds.width - 50),
            datePicker.heightAnchor.constraint(equalToConstant: 40)
            
        ])
      
    }
    
}


