//
//  Item.swift
//  TodoApp_Realm
//
//  Created by Irfaane Ousseny on 15/09/2018.
//  Copyright © 2018 Irfaane. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "itemsList")
}
