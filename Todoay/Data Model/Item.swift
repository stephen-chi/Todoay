//
//  Item.swift
//  Todoay
//
//  Created by Linus Zheng on 7/3/18.
//  Copyright © 2018 Linus Zheng. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
