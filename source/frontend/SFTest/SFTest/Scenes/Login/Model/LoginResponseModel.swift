//
//  LoginResponseModel.swift
//  SFTest
//
//  Created by Ravindran on 17/05/23.
//

import Foundation

struct LoginResponseModel: Codable {
    let token: String?

    enum CodingKeys: String, CodingKey {
        case token
    }
}
