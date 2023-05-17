//
//  TodoItemModel.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import Foundation

struct TodoItemModel: Codable {
    let pk: Int?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case pk
        case description
    }
}
