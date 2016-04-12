//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Francisco Ragland Jr on 4/8/16.
//  Copyright © 2016 Francisco Ragland. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    //source control test
    var detailTaskModel: TaskModel!
    
    var mainVC: ViewController!
    
    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var subtaskTextField: UITextField!
    
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.taskTextField.text = detailTaskModel.task
        self.subtaskTextField.text = detailTaskModel.subtask
        self.dueDatePicker.date = detailTaskModel.date

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
        //make a new task instance from fields and date
        let task = TaskModel(task: taskTextField.text!, subtask:subtaskTextField.text!, date: dueDatePicker.date, completed: false)
        
        //set the mainVC's baseArray for section 0 to
        mainVC.baseArray[0][mainVC.tableView.indexPathForSelectedRow!.row] = task
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
