//
//  Category.swift
//  TodoApp_Realm
//
//  Created by Irfaane Ousseny on 15/09/2018.
//  Copyright © 2018 Irfaane. All rights reserved.
//

import Foundation
import RealmSwift

/**
  * The category model is the first object that we create and it's a realm object
  * By subclassing this class we're able to save our data using realm and specify for our class :
  * - the name property (i.e. the name of the category) which is a dynamic varaible so we can monitor
  * for changes the property while the app is running (i.e. during Runtime)
  * - items is a list of item objects 
 */
class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var color : String = ""
    let items = List<Item>()
}
