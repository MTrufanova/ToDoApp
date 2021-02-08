//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by msc on 28.12.2020.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {
    
    var buttonTap: () -> ()  = { }
    
    public let taskLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
  
    
   public let checkButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    @objc func didTapCheckButton() {
       buttonTap()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(taskLabel)
        addSubview(dateLabel)
        contentView.addSubview(checkButton)
        checkButton.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
        setupLayout()
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            taskLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            taskLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            taskLabel.heightAnchor.constraint(equalToConstant: 40),
            taskLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            dateLabel.heightAnchor.constraint(equalToConstant: 40),
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            
          
            checkButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
              checkButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
        
    }
    
    public func refresh(_ model: TaskModel) {
        taskLabel.text = model.taskHeader
        dateLabel.text = model.date
        let largeConfig = UIImage.SymbolConfiguration(textStyle: .title2)
        switch model.isComleted {
        case true:
           // checkButton.setImage(UIImage.init(systemName: "checkmark.circle.fill"), for: .normal)
            
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: largeConfig), for: .normal)
            taskLabel.textColor = .gray
            
        case false:
          //  checkButton.setImage(UIImage.init(systemName: "circle"), for: .normal)
            checkButton.setImage(UIImage(systemName: "circle", withConfiguration: largeConfig), for: .normal)
            taskLabel.textColor = .black
            
        } 
      
    }
    
  
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

