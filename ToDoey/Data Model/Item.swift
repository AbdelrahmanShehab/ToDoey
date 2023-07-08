//
//  Item.swift
//  ToDoey
//
//  Created by Abdelrahman Shehab on 08/07/2023.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
