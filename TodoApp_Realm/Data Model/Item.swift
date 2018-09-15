//
//  Item.swift
//  TodoApp_Realm
//
//  Created by Irfaane Ousseny on 15/09/2018.
//  Copyright © 2018 Irfaane. All rights reserved.
//

import Foundation
import RealmSwift

/**
 * The item model is also a realm object. It has 3 properties :
 * a title weather it's done or not and it have dateCreated property
 * We also specify the inverse relationship that links each items back to its parent category:
 * we specify the type of the destination of the link and the property name of the inverse
 * relationship that relates to this property
 */
class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
