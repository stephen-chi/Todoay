//
//  Category.swift
//  Todoay
//
//  Created by Linus Zheng on 7/3/18.
//  Copyright © 2018 Linus Zheng. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
