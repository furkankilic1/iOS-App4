//
//  AddRecordVC.swift
//  FurkanKilic_HW4
//
//  Created by CTIS Student on 23.12.2021.
//  Copyright © 2021 KILIC. All rights reserved.
//

import UIKit

protocol AddVCDelegate {
    func resultData(data: (Student))
}

class AddRecordVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var midtermTF: UITextField!
    @IBOutlet weak var finalTF: UITextField!

    var delegate: AddVCDelegate?
    
    @IBAction func insertAction(_ sender: Any) {
        
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
            
            let newStudentItem = Student.createInManagedObjectContext(context,
                                                                      name: nameTF.text!, surname: surnameTF.text!, midterm: NumberFormatter().number(from: midtermTF.text!)!, final: NumberFormatter().number(from: finalTF.text!)!)
            
            
            self.navigationController?.popViewController(animated: true)
            delegate?.resultData(data: (newStudentItem))
            
        }
        
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
}
