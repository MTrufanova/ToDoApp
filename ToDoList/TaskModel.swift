//
//  TaskModel.swift
//  ToDoList
//
//  Created by msc on 28.12.2020.
//

import Foundation

struct TaskModel: Codable {
    let taskHeader: String
    let date: String?
    let description: String?
}




protocol AddTaskDelegate {
    func addTask(task: TaskModel) 
}
