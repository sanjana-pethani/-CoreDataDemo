//
//  ViewController.swift
//  CoreDatabase
//
//  Created by Sanjana pethani on 11/02/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

   @IBOutlet weak var nameTextField: UITextField!
   @IBOutlet weak var addressTextField: UITextField!
   @IBOutlet weak var salaryTextField: UITextField!
   @IBOutlet weak var saveButton: UIButton!
   @IBOutlet weak var searchButton: UIButton!
   @IBOutlet weak var updateButton: UIButton!
   @IBOutlet weak var deleteButton: UIButton!
   @IBOutlet weak var messageLabel: UILabel!
    var arrStudents: [StudentDetails] = []

   override func viewDidLoad() {
       super.viewDidLoad()
       
   }

   
   private func insertUser() {
       
       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
       
       let viewContext = appDelegate.persistentContainer.viewContext
       
       let studentEntity = NSEntityDescription.entity(forEntityName: "Student", in: viewContext)!
       
       let studentManageObject = NSManagedObject(entity: studentEntity, insertInto: viewContext)
       
       studentManageObject.setValue(nameTextField.text ?? "", forKey: "name")
       studentManageObject.setValue(addressTextField.text ?? "", forKey: "address")
       studentManageObject.setValue(Double(salaryTextField.text ?? ""), forKey: "salary")
       do {
           
           try viewContext.save()
           print("Data saved succesfully")
           messageLabel.text = "Data saved succesfully"
           nameTextField.text = ""
           addressTextField.text = ""
           salaryTextField.text = ""
           getStudents()
       } catch let error as NSError {
           print(error.localizedDescription)
           messageLabel.text = error.localizedDescription
       }
   }
   
   private func getStudents() {
       
       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
       
       let viewContext = appDelegate.persistentContainer.viewContext
       
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Student")
       
       do {
           
           let students = try viewContext.fetch(fetchRequest)
           arrStudents = []
           for student in students  as! [NSManagedObject] {
               let name = student.value(forKey: "name") ?? ""
               let address = student.value(forKey: "address") ?? ""
               let salary = student.value(forKey: "salary") ?? 0.0
               let studentObject = StudentDetails(name: name as! String, address: address as! String, salary: salary as! Double)
               arrStudents.append(studentObject)
//                print("Student Name is \(name)")
//                print("Student address is \(address)")
//                print("Student salary is \(salary)")
           }
           print(arrStudents)
           
           if arrStudents.count > 0 {
               
           } else {
               print("No data found")

           }
       } catch let error as NSError {
           
       }
   }
   
   private func updateUsers() {
       
   }
   
   private func deleteUsers() {
       
   }
   
   
   @IBAction func saveButtonClicked(_ sender: UIButton) {
       
       if nameTextField.text?.count == 0 || addressTextField.text?.count == 0 || salaryTextField.text?.count == 0 {
           print("Please enter the details")
           return
       }
       
       insertUser()
   }
   
   @IBAction func searchButtonClicked(_ sender: UIButton) {
       getStudents()
   }
   
   @IBAction func updateButtonClicked(_ sender: UIButton) {
       
       if nameTextField.text?.count == 0 || addressTextField.text?.count == 0 || salaryTextField.text?.count == 0 {
           print("Please enter the details")
           return
       }
   }
   
   @IBAction func deleteButtonClicked(_ sender: UIButton) {
   }
   
}

struct StudentDetails {
   
   var name: String
   var address: String
   var salary: Double
   
}


