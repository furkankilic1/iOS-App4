//
//  Student+CoreDataClass.swift
//  FurkanKilic_HW4
//
//  Created by CTIS Student on 23.12.2021.
//  Copyright © 2021 KILIC. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Student)
public class Student: NSManagedObject {
    
    class func createInManagedObjectContext(_ context: NSManagedObjectContext, name: String, surname: String, midterm: NSNumber, final: NSNumber) -> Student {
        let studentObject = NSEntityDescription.insertNewObject(forEntityName: "Student", into: context) as! Student
        studentObject.name = name
        studentObject.surname = surname
        studentObject.midterm = Double(truncating: midterm)
        studentObject.final = Double(truncating: final)
        
        return studentObject
    }
}
