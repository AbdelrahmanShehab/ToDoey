//
//  Category.swift
//  ToDoey
//
//  Created by Abdelrahman Shehab on 08/07/2023.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
