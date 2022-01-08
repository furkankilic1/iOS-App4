//
//  UpdateRecordVC.swift
//  FurkanKilic_HW4
//
//  Created by CTIS Student on 23.12.2021.
//  Copyright © 2021 KILIC. All rights reserved.
//

import UIKit
import CoreData

protocol UpdateVCDelegate {
    func resultUpdateData(data: (Student))
}

class UpdateRecordVC: UIViewController {

    var student: Student?
    
    var mStudent = [Student]()
    
    var delegate: UpdateVCDelegate?
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var midtermTF: UITextField!
    @IBOutlet weak var finalTF: UITextField!
    
    
    @IBAction func updateAction(_ sender: Any) {
        
        if nameTF!.text!.isEmpty || surnameTF.text!.isEmpty || midtermTF.text!.isEmpty || finalTF.text!.isEmpty
        {
            let alert = UIAlertController(title: "Error", message:  "Empty Fields"  , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
            
            let search = student!.name
            let mPredicate = NSPredicate(format: "name contains[c] %@", search!)
            
            fetchRequest.predicate = mPredicate
            
            do {
                let fetchResults = try context.fetch(fetchRequest)
                mStudent = fetchResults as! [Student]
                mStudent[0].name = nameTF.text
                mStudent[0].surname = surnameTF.text
                mStudent[0].midterm = Double(midtermTF.text!)!
                mStudent[0].final = Double( finalTF.text!)!
                
                self.navigationController?.popViewController(animated: true)
                delegate?.resultUpdateData(data: (mStudent[0]))
                
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        }
        
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF.text = student?.name
        surnameTF.text = student?.surname
        midtermTF.text = String(student!.midterm)
        finalTF.text = String(student!.final)
        
    }
    


}
