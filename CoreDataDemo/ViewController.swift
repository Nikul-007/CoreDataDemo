//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by nikunj on 14/03/20.
//  Copyright © 2020 Nikul. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet var firstNameField : UITextField!
    @IBOutlet var lastnameField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Test")
    }
    
    @IBAction func onClickSaveUserData()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        
        let user =  NSManagedObject.init(entity: entity!, insertInto: managedContext)
        user.setValue(firstNameField.text, forKey: "firstname")
        user.setValue(lastnameField.text, forKey: "lastname")
        
        do{
            try! managedContext.save()
            print("Saved successfully")
        }
        catch let err {
            print(err)
        }
        
    }
    
    @IBAction func onClickShowUserData()
    {
        self.performSegue(withIdentifier: "DisplayDataVC", sender: nil)
    }


}

