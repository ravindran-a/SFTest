//
//  TodoServiceProtocol.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import Foundation

protocol TodoServiceProtocol {
    func createTodoItem(description: String) async throws -> (Data, URLResponse)?
    func getTodoItems() async throws -> (Data, URLResponse)?
    func deleteTodoItem(id: Int) async throws -> (Data, URLResponse)?
}
