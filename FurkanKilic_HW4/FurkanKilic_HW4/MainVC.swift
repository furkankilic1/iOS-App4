//
//  MainVC.swift
//  FurkanKilic_HW4
//
//  Created by CTIS Student on 23.12.2021.
//  Copyright © 2021 KILIC. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate, AddVCDelegate, UpdateVCDelegate {
    
    func resultUpdateData(data: (Student)) {
        self.fetchData()
        mTableView.reloadData();
        save()
    }
    
    
    func resultData(data: (Student)) {
        let (student) = data
        saveNewItem(name: student.name!, surname: student.surname!, midterm: String(student.midterm) , final: String(student.final))
    }
    
    
    
    
    var mStudent = [Student]()
    
    @IBOutlet weak var mTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mStudent.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        let student = mStudent[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.row)"
        cell.textLabel?.text = student.name! + " " + student.surname!
        cell.detailTextLabel?.text = "Midterm -> " + String(student.midterm) + ",  Final -> " + String(student.final)
        
        return cell
    }
    
    
    // Our function to fetch data from Core Data
    func fetchData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")

        do {
            let results = try context.fetch(fetchRequest)
            mStudent = results as! [Student]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    
    // Method to insert data into Table View and save in Core Data
    func saveNewItem( name : String, surname : String, midterm: String, final: String) {
    
        self.fetchData()
        mTableView.reloadData();
        save()
        
    }
    
    
    // Method to save the Data in Core Data
    func save() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addVcId" {
            if let VC = segue.destination as? AddRecordVC {
                VC.delegate = self
            }
        }
    
        else if segue.identifier == "updateVcId" {
                
                if let indexPath = getIndexPathForSelectedRow() {
                    
                    let student =  mStudent[indexPath.row]
                    
                    let updateVC = segue.destination as! UpdateRecordVC
                    
                    updateVC.student = student
                    
                    updateVC.delegate = self
                }
        
            }
    
    }
    
    
    func getIndexPathForSelectedRow() -> IndexPath? {
        var indexPath: IndexPath?
        
        if mTableView.indexPathsForSelectedRows!.count > 0 {
            indexPath = mTableView.indexPathsForSelectedRows![0] as IndexPath
        }
        
        return indexPath
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchData()
    }


}

