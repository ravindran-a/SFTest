//
//  TodoItemService.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import Foundation

class TodoItemService: TodoServiceProtocol {
    func createTodoItem(description: String) async throws -> (Data, URLResponse)? {
        let url: String = APIEndPoints.TodoList.todo.url
        return try await APIManager.shared.request(serviceURL: url, httpMethod: .post, parameters: ["description": description], tokenEnabled: true)
    }
    
    func deleteTodoItem(id: Int) async throws -> (Data, URLResponse)? {
        let url: String = APIEndPoints.TodoList.todo.url
        return try await APIManager.shared.request(serviceURL: url, httpMethod: .delete, tokenEnabled: true)
    }
    
    func getTodoItems() async throws -> (Data, URLResponse)? {
        let url: String = APIEndPoints.TodoList.todo.url
        return try await APIManager.shared.request(serviceURL: url, httpMethod: .get, tokenEnabled: true)
    }
}
