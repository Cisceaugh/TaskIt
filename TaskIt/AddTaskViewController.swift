//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Francisco Ragland Jr on 4/10/16.
//  Copyright © 2016 Francisco Ragland. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addTaskButtonPressed(sender: UIButton) {
        
            //get access to appDelegate
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
            //get access to managedObject from appDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
            //create description that describes entity from CoreData, returns entity description with specified name
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext)
            //create TaskModel instance, initialize with TaskModel entity name and put it into apps managedObjectContext
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        
        task.task = taskTextField.text
        task.subtask = subtaskTextField.text
        task.date = dueDatePicker.date
        task.completed = false
        
        appDelegate.saveContext()
        
            //request all instances of TaskModel
        let request = NSFetchRequest(entityName: "TaskModel")
            //make an error
        let error:NSError? = nil
        
        do {
            //do a fetch request for entities named TaskModel
            let results: NSArray = try managedObjectContext.executeFetchRequest(request)
            
            //success
            for res in results {
                print(res)
            }

        } catch _ {
            
            //failure
            print(error)
        }
        
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
