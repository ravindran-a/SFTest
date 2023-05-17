//
//  APIEndPoints.swift
//  LoremPicsum
//
//  Created by Ravindran on 17/05/23.
//

import Foundation

enum APIEndPoints {
    
    static let ApiBaseUrl: String = "http://127.0.0.1:8000/api/"
    
    enum Account {
        case login
        case signUp
        
        var url: String {
            switch self {
            case .login:
                return "login/"
            case .signUp:
                return "signup/"
            }
        }
    }

    enum TodoList {
        case todo
        
        var url: String {
            switch self {
            case .todo:
                return "todo-lists/"
            }
        }
    }
}
