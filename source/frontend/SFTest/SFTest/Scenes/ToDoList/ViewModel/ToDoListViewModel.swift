//
//  ToDoListViewModel.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import Foundation

@MainActor
class ToDoListViewModel: ObservableObject {
    
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
    @Published var data: [TodoItemModel] = []
    var alertMessage: String = ""
    let todoService: TodoServiceProtocol
    
    init(todoService: TodoServiceProtocol) {
        self.todoService = todoService
    }
    
    func getTodoItemList() async {
        isLoading = true
        do {
            if let response: (Data, URLResponse) = try await todoService.getTodoItems() {
                let model: [TodoItemModel] = try JSONDecoder().decode([TodoItemModel].self, from: response.0)
                self.data = model
            }
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.alertMessage = "\(error.localizedDescription)"
        }
    }
    
    func createTodoItem(item: String) async {
        isLoading = true
        do {
            if let response: (Data, URLResponse) = try await todoService.createTodoItem(description: item) {
                
            }
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.alertMessage = "\(error.localizedDescription)"
        }
    }
}
