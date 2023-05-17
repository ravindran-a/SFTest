//
//  AddTodoItemView.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import Foundation
import SwiftUI

struct AddTodoItemView: View {
    
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    @State var description: String = ""
    @State var showValidationMessage: Bool = false
    @StateObject var viewModel: ToDoListViewModel = ToDoListViewModel(todoService: TodoItemService())
    
    private var descriptionValidated: Bool {
        !description.isEmpty
    }
    
    var createView: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 20) {
            
            Text("Create Todo List Item")
            Spacer()
            TextField("Item descrption", text: $description)
                .frame(maxWidth: 500.0)
                .textInputAutocapitalization(.never)
                .onChange(of: description) { _ in
                    showValidationMessage = false
                }
                .padding(.horizontal)
                .padding(.vertical, 15)
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(showValidationMessage ? Color.red : Color.gray,
                            lineWidth: 1))
            if showValidationMessage {
                if !descriptionValidated {
                    Text("field cannot be empty")
                        .foregroundColor(.accentColor)
                }
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                    .padding()
            } else {
                submitButtonView
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Add")
        .navigationBarItems(trailing: closeButton)
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK"), action: {
                viewModel.showAlert = false
                viewModel.alertMessage = ""
            }))
        }
    }
    
    var submitButtonView: some View {
        VStack {
            Button {
                Task {
                    await viewModel.createTodoItem(item: self.description)
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text("Submit")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.white)
            .background(Color.accentColor)
            .cornerRadius(5)
            .padding(.horizontal, 15)
            .padding(.top, 30)
        }
    }
    
    var closeButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Cancel")
        }
    }
    
    var body: some View {
        NavigationView {
            createView
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
