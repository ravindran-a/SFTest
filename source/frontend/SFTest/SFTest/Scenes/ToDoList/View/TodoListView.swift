//
//  TodoListView.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import SwiftUI

struct TodoListView: View {
    
    var oneColumnGrid: [GridItem] = [GridItem(.flexible())]
    @State var showAddTodoItemView: Bool = false
    @StateObject var viewModel: ToDoListViewModel = ToDoListViewModel(todoService: TodoItemService())
    
    var addTodoButton: some View {
        Button {
            showAddTodoItemView = true
        } label: {
            HStack {
                Image(systemName: "plus")
            }
        }
    }
    
    var todoListView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: oneColumnGrid, spacing: 20) {
                ForEach(0..<viewModel.data.count, id: \.self) { index in
                    let todo: TodoItemModel = viewModel.data[index]
                    VStack(alignment: .leading) {
                        HStack {
                            Text(todo.description ?? "").foregroundColor(Color.accentColor).font(Font.system(size: 14.0))
                            Spacer()
                        }.padding(EdgeInsets(top: 12.0, leading: 16.0, bottom: 12.0, trailing: 16.0))
                        
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 30.0)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            todoListView
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(.stack)
                .navigationBarTitle("Todo")
                .navigationBarItems(trailing: addTodoButton)
                .onAppear {
                    Task {
                        await viewModel.getTodoItemList()
                    }
                }
        }
        .fullScreenCover(isPresented: $showAddTodoItemView) {
            AddTodoItemView()
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
