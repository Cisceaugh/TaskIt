//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Francisco Ragland Jr on 4/10/16.
//  Copyright © 2016 Francisco Ragland. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    var mainVC: ViewController!

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
        let task = TaskModel(task: taskTextField.text!, subtask: subtaskTextField.text!, date: dueDatePicker.date, completed: false)
        mainVC.baseArray[0].append(task)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
