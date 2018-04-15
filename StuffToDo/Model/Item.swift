//
//  Item.swift
//  StuffToDo
//
//  Created by Matt Deuschle on 4/11/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation

struct Item: Codable {

    let title: String
    let dateCreated = Date()

    init?(title: String?) {
        guard let title = title else {
            return nil
        }
        self.title = title
    }
}



