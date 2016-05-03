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
        
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        let managedObjectContext = appDelegate.managedObjectContext
        
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext)

        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        task.task = taskTextField.text
        task.subtask = subtaskTextField.text
        task.date = dueDatePicker.date
        task.completed = false
        
        appDelegate.saveContext()
        
        let request = NSFetchRequest(entityName: "TaskModel")
        let error:NSError? = nil
        
        do {
            let results: NSArray = try managedObjectContext.executeFetchRequest(request)
            for res in results {
                print(res)
            }
        } catch _ {
            print(error)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
