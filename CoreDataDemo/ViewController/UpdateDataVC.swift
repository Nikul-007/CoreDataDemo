//
//  UpdateDataVC.swift
//  CoreDataDemo
//
//  Created by nikunj on 16/03/20.
//  Copyright © 2020 Nikul. All rights reserved.
//

import UIKit
import CoreData
class UpdateDataVC: UIViewController {

    @IBOutlet var nameToUpdateField : UITextField!
    @IBOutlet var firstNameToUpdate : UITextField!
    @IBOutlet var lastNameToUpdate : UITextField!
    @IBOutlet var updateView : UIView!

    @IBOutlet var statusLabel : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView.setViewShadow( clr: .red)

    }
    
    @IBAction func onClickUpdateRecord()
    {
        updateDataByName(searchText: nameToUpdateField.text!)
    }
    func updateDataByName(searchText : String)
       {
           let managedObject = appDelegate.persistentContainer.viewContext
           let fetchReq = NSFetchRequest<NSFetchRequestResult>.init(entityName: "User")
           fetchReq.predicate = NSPredicate.init(format: "firstname = %@", searchText)
           
           do{
               let data = try! managedObject.fetch(fetchReq)
               if data.count == 0{
                   print("Not found")
                self.statusLabel.text = "Not Found"
                   return
               }
               
               let obj = data[0] as! NSManagedObject
               obj.setValue(firstNameToUpdate.text, forKey: "firstname")
               obj.setValue(lastNameToUpdate.text, forKey: "lastname")
               
               try? managedObject.save()
               
               firstNameToUpdate.text = ""
               lastNameToUpdate.text = ""
               nameToUpdateField.text = ""
               self.statusLabel.text = "Record Updated"

           }
       }

}
