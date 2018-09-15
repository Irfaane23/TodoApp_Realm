//
//  Category.swift
//  TodoApp_Realm
//
//  Created by Irfaane Ousseny on 15/09/2018.
//  Copyright © 2018 Irfaane. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let itemsList = List<Item>()
}
