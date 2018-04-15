//
//  Dao.swift
//  StuffToDo
//
//  Created by Matt Deuschle on 4/14/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation

struct Dao {

    let itemsDirectory: String

    init() {
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        itemsDirectory = "\(directories[0])/items)"
    }

    func archive(items: [Item]) {
        do {
            let data = try PropertyListEncoder().encode(items)
            NSKeyedArchiver.archiveRootObject(data, toFile: itemsDirectory)
        } catch {
            print("Archive Error: \(error)")
        }
    }

    func unArchiveItems() -> [Item]? {
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: itemsDirectory) as? Data else {
            return nil
        }
        do {
            let items = try PropertyListDecoder().decode([Item].self, from: data)
            return items
        } catch {
            return nil
        }
    }
}




