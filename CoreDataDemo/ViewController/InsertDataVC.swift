//
//  InsertDataVC.swift
//  CoreDataDemo
//
//  Created by nikunj on 16/03/20.
//  Copyright © 2020 Nikul. All rights reserved.
//

import UIKit
import CoreData
class InsertDataVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var firstNameField : UITextField!
    @IBOutlet var lastnameField : UITextField!
    @IBOutlet var avtarImgView : UIImageView!
    
    @IBOutlet var insertView : UIView!
    @IBOutlet var operationView : UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        insertView.setViewShadow( clr: .red)
        operationView.setViewShadow( clr: .red)

    }
    // SELECT AVTAR IMAGE
    @IBAction func onClickSelectAvtar()
    {
        cameraButtonPressed()
    }
    
    // Display All Record
    @IBAction func onClickShowUserData()
    {
        self.performSegue(withIdentifier: "DisplayDataVC", sender: nil)
    }
    
    // Update Record
    @IBAction func onClickUpdateUserData()
    {
        self.performSegue(withIdentifier: "UpdateDataVC", sender: nil)
    }
    
    // Delete/Search Record
    @IBAction func onClickSearchUserData()
    {
        self.performSegue(withIdentifier: "SearchVC", sender: nil)
    }
    // Save Record
    @IBAction func onClickSaveUserData()
    {
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
           
        let user =  NSManagedObject.init(entity: entity!, insertInto: managedContext)
        user.setValue(firstNameField.text, forKey: "firstname")
        user.setValue(lastnameField.text, forKey: "lastname")
        user.setValue(avtarImgView.image?.pngData(), forKey: "imagedata")
        
           do{
               try! managedContext.save()
               print("Saved successfully")
               
               firstNameField.text = ""
               lastnameField.text = ""
               avtarImgView.image = UIImage.init(named: "avatar")
           }
           catch let err {
               print(err)
           }
       }
    
       @objc func cameraButtonPressed() {
           let picker = UIImagePickerController()
           picker.delegate = self
           picker.allowsEditing = true
           picker.sourceType = .photoLibrary
           present(picker, animated: true)
       }
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           guard let userPickedImage = info[.editedImage] as? UIImage else { return }
           avtarImgView.image = userPickedImage.scale(toSize: CGSize.init(width: 150, height: 150))
           picker.dismiss(animated: true)
       }
 

}
