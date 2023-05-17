//
//  String+Helper.swift
//  LoremPicsum
//
//  Created by Ravindran on 17/05/23.
//

import Foundation

extension String {
    var urlEncoded: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
