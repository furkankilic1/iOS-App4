//
//  Student+CoreDataProperties.swift
//  FurkanKilic_HW4
//
//  Created by CTIS Student on 23.12.2021.
//  Copyright © 2021 KILIC. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var surname: String?
    @NSManaged public var name: String?
    @NSManaged public var midterm: Double
    @NSManaged public var final: Double

}
