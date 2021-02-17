//
//  TasksTableViewController.swift
//  ToDoList
//
//  Created by msc on 25.12.2020.
//

import UIKit
import SnapKit


 class TasksTableViewController: UITableViewController {
    
    
    let key = "Save"
    let cellID = "cell"
    let defaults = UserDefaults.standard
    
    
    
    private let enterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "human")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    private let firstEnterLabel: UILabel = {
        let label = UILabel()
        label.text = "No tasks"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let secondEnterLabel: UILabel = {
        let label = UILabel()
        label.text = "Click on the button to add a new task"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add task", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
        return button
    }()
   
    
    
    // MARK: - Save Data
    private var tasksArray: [TaskModel] {
        
        get {
            guard let encodedData = defaults.array(forKey: key) as? [Data] else {
                return []
            }
            
            return encodedData.map { try! JSONDecoder().decode(TaskModel.self, from: $0)}.sorted(by: {$0.date! < $1.date!})
            
        }
        
        set {
            let data = newValue.map { try? JSONEncoder().encode($0) }
            defaults.set(data, forKey: key)
        }
        
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        // скрытие лишних ячеек
        tableView.tableFooterView = UIView()
        
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: cellID)
        
          self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        
      
        setNavigationBar()
        setupEnterModule()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }
    
    
    
    // MARK: - Methods
    private func setNavigationBar() {
     
     navigationItem.title = "All tasks"
    
         navigationController?.navigationBar.tintColor = .black
     }
    
    private func setupEnterModule() {
        tableView.addSubview(enterImage)
        tableView.addSubview(firstEnterLabel)
        tableView.addSubview(secondEnterLabel)
        tableView.addSubview(enterButton)
        
        enterImage.snp.makeConstraints { (make) in
         
            make.width.height.equalToSuperview().multipliedBy(0.5)
            make.centerX.equalToSuperview()
        }
        
        firstEnterLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.top.equalTo(enterImage.snp.bottom)
        }
        
        secondEnterLabel.snp.makeConstraints { (make) in
            make.top.equalTo(firstEnterLabel.snp.bottom) .offset(16)
            make.centerX.equalToSuperview()
        }
        
        enterButton.snp.makeConstraints { (make) in
            make.top.equalTo(secondEnterLabel.snp.bottom) .offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    
    }
    
    @objc private func addNewTask() {
        let addVC = ViewController()
        addVC.title = "New task"
        navigationItem.backButtonTitle = ""
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: true)
        
    }
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        enterImage.isHidden = tasksArray.count != 0
        firstEnterLabel.isHidden = tasksArray.count != 0
        secondEnterLabel.isHidden = tasksArray.count != 0
        enterButton.isHidden = tasksArray.count != 0
        if tasksArray.count == 0 {
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = .clear
        navigationItem.title = ""
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = .black
            navigationItem.title = "All tasks"
        }
        return tasksArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TaskTableViewCell {
            
           
            
            var task = tasksArray[indexPath.row]
            cell.refresh(task)
            
            cell.buttonTap = {
                task.isComleted = !task.isComleted
                self.tasksArray[indexPath.row] = task
                
                let largeConfig = UIImage.SymbolConfiguration(textStyle: .title2)
                switch task.isComleted {
                case true:
                    cell.checkButton.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: largeConfig), for: .normal)
                    cell.taskLabel.textColor = .gray
                   
                case false:
                    cell.checkButton.setImage(UIImage(systemName: "circle", withConfiguration: largeConfig), for: .normal)
                    cell.taskLabel.textColor = .black
                    
                }
            }
            
            cell.selectionStyle = .none
            tableView.separatorStyle = .none
            
            
            return cell
        }
        
        return UITableViewCell()
        
    }
   
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let taskVC = ViewController()
        taskVC.navigationItem.title = "Edit task"
        navigationItem.backButtonTitle = ""
        let task = tasksArray[indexPath.row]
        taskVC.task = task
        taskVC.delegate = self
        navigationController?.pushViewController(taskVC, animated: true)
      
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasksArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


extension TasksTableViewController: AddTaskDelegate {
    
    func addTask(task: TaskModel)  {
        self.dismiss(animated: true) { [self] in
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tasksArray[selectedIndexPath.row] = task
                
            }else {
                tasksArray.append(task)
            }
        }
    }
}



