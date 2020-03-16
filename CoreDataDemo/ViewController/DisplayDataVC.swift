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
    var imageData : Data!

    init(_ fname : String,_ lname : String, _ imgData : Data) {
        firstName = fname
        lastName = lname
        imageData = imgData
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
                var imageData = obj.value(forKey: "imagedata") as? Data
                if imageData == nil
                {
                    imageData = UIImage.init(named: "avatar")?.pngData()
                }
                fetchRecord.append(UserModel.init(firstName , lastName, imageData!))
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
        cell.mainView.setViewShadow( clr: .black)
        return cell
    }
}
