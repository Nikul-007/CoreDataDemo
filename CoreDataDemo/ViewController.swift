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
    
    @IBOutlet var searchField : UITextField!
    @IBOutlet var searchLabel : UILabel!

    @IBOutlet var centerView : UIView!
    @IBOutlet var centerView2 : UIView!

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Test")
        
        setViewShadow(view_: centerView)
        setViewShadow(view_: centerView2)

    }
    
    // Save Record
    @IBAction func onClickSaveUserData()
    {
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        
        let user =  NSManagedObject.init(entity: entity!, insertInto: managedContext)
        user.setValue(firstNameField.text, forKey: "firstname")
        user.setValue(lastnameField.text, forKey: "lastname")
        
        do{
            try! managedContext.save()
            print("Saved successfully")
            
            firstNameField.text = ""
            lastnameField.text = ""

        }
        catch let err {
            print(err)
        }
    }
    
    // Search RECORD
    @IBAction func onClickSearchRecord()
    {
        searchLabel.text = ""
        searchRecord(searchText: searchField.text!)
    }
    
    // DELETE RECORD
    @IBAction func onClickDeleteRecord()
    {
        deleteDataByName(searchText: searchField.text!)
    }
    
    // Display All Record
    @IBAction func onClickShowUserData()
    {
        self.performSegue(withIdentifier: "DisplayDataVC", sender: nil)
    }
    func deleteDataByName(searchText : String)
    {
        let managedObject = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSFetchRequestResult>.init(entityName: "User")
        fetchReq.predicate = NSPredicate.init(format: "firstname = %@", searchText)
        do{
            let data = try! managedObject.fetch(fetchReq)
            if data.count > 0{
                managedObject.delete(data[0] as! NSManagedObject)
                try? managedObject.save()
                searchLabel.text = "Record Deleted"
                searchField.text = ""
            }
            else{
                searchLabel.text = "No Record Found"
            }
        }
        
    }
    
    func searchRecord(searchText : String)
    {
        let managedObject = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSFetchRequestResult>.init(entityName: "User")
        fetchReq.predicate = NSPredicate.init(format: "firstname = %@", searchText)
        do{
            let data = try! managedObject.fetch(fetchReq)
            if data.count == 0{
                searchLabel.text = "Not Found"
            }
            for obj in (data as? [NSManagedObject])!
            {
                let firstName = obj.value(forKey: "firstname") as! String
                let lastName = obj.value(forKey: "lastname") as! String
                searchLabel.text = firstName + " " + lastName
            }
        }
        
    }
    
    func setViewShadow(view_ : UIView)
    {
        view_.dropShadow(color: .gray, opacity: 0.3, offSet: CGSize(width: -0.5, height: 1), radius: 3, scale: true)
    }


}

