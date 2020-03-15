//
//  DisplayDataVC.swift
//  CoreDataDemo
//
//  Created by nikunj on 14/03/20.
//  Copyright © 2020 Nikul. All rights reserved.
//
struct UserModel  {
    var firstName : String!
    var lastName : String!
    init(_ fname : String,_ lname : String) {
        firstName = fname
        lastName = lname
    }
}

import UIKit
import CoreData

class DisplayDataVC: UIViewController {

    var fetchRecord  = [UserModel]()
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var centerView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        fetchData()
    }
    
    
    // Fetch Data From User Entity
    func fetchData()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObject = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSFetchRequestResult>.init(entityName: "User")
        
        do{
            let data = try! managedObject.fetch(fetchReq)
            for obj in (data as? [NSManagedObject])!
            {
                let firstName = obj.value(forKey: "firstname") as! String
                let lastName = obj.value(forKey: "lastname") as! String
                
                fetchRecord.append(UserModel.init(firstName , lastName))
            }
        }
        tableView.reloadData()
        
    }
    
}

// Table Delegate
extension DisplayDataVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchRecord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        cell.dataArray = fetchRecord[indexPath.row]
        cell.mainView.dropShadow(color: .gray, opacity: 0.5, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)

        return cell
    }
}
