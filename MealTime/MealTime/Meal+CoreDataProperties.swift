//
//  Meal+CoreDataProperties.swift
//  MealTime
//
//  Created by Ivan Akulov on 12/11/2016.
//  Copyright © 2016 Ivan Akulov. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var person: Person?

}
