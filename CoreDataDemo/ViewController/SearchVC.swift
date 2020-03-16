//
//  SearchVC.swift
//  CoreDataDemo
//
//  Created by nikunj on 16/03/20.
//  Copyright © 2020 Nikul. All rights reserved.
//

import UIKit
import CoreData
class SearchVC: UIViewController {

    @IBOutlet var searchField : UITextField!
    @IBOutlet var searchLabel : UILabel!
    @IBOutlet var searchView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.setViewShadow( clr: .red)

        // Do any additional setup after loading the view.
    }
    // Search RECORD
    @IBAction func onClickSearchRecord()
    {
        searchLabel.text = ""
        searchRecord(searchText: searchField.text!)
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
                return
            }
            for obj in (data as? [NSManagedObject])!
            {
                let firstName = obj.value(forKey: "firstname") as! String
                let lastName = obj.value(forKey: "lastname") as! String
                searchLabel.text = firstName + " " + lastName
            }
        }
        
    }
    // DELETE RECORD
       @IBAction func onClickDeleteRecord()
       {
           deleteDataByName(searchText: searchField.text!)
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


}
