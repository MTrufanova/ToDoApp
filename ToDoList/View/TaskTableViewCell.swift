//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by msc on 28.12.2020.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {
    
    var buttonTap: () -> ()  = { }
    
    // MARK: - UI
    
    public let taskLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
        
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
   public let checkButton: UIButton = {
       let button = UIButton()
        return button
    }()
    
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(taskLabel)
        addSubview(dateLabel)
        contentView.addSubview(checkButton)
        checkButton.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
        setupLayout()
    }
    
    
    // MARK: - Methods
    
    @objc func didTapCheckButton() {
       buttonTap()
    }
    
    private func setupLayout() {
        
        taskLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview() .offset(8)
            make.leading.equalTo(checkButton.snp.trailing) .offset(16)
            make.height.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(taskLabel.snp.bottom) .offset(4)
            make.height.equalTo(20)
            make.leading.equalTo(checkButton.snp.trailing) .offset(16)
        }
        
        checkButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview() .offset(16) .labeled("CheckButtonLeading")
            make.centerY.equalToSuperview() .labeled("CheckButtonCenterY")
        }
        
    }
    
    public func refresh(_ model: TaskModel) {
        taskLabel.text = model.taskHeader
        dateLabel.text = model.date
        let largeConfig = UIImage.SymbolConfiguration(textStyle: .title2)
        switch model.isComleted {
        case true:
          
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: largeConfig), for: .normal)
            taskLabel.textColor = .gray
            
        case false:
         
            checkButton.setImage(UIImage(systemName: "circle", withConfiguration: largeConfig), for: .normal)
            taskLabel.textColor = .black
        }
    }
    
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

