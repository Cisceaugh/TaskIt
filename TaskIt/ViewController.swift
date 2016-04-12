//
//  ViewController.swift
//  TaskIt
//
//  Created by Francisco Ragland Jr on 4/6/16.
//  Copyright © 2016 Francisco Ragland. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Properties
        //Array of TaskModel arrays
    var baseArray:[[TaskModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hard coded dates
        let date1 = Date.from(year: 2016, month: 04, day: 08)
        let date2 = Date.from(year: 2016, month: 04, day: 09)
        let date3 = Date.from(year: 2016, month: 04, day: 10)
        
        //Hard coded tasks not completed
        let task1 = TaskModel(task: "Study Swift", subtask: "UITableView and making custom cells", date: date1, completed: false)
        
        let task2 = TaskModel(task: "Make Soylent", subtask: "User peppermint syrup", date: date2, completed: false)
        
        let tasks = [task1, task2, TaskModel(task: "Eat vegatables", subtask: "green ones", date: date3, completed: false)]
        
        //Hard coded tasks completed
        let completedTasks = [TaskModel(task: "Code", subtask: "Task Project", date: date2, completed: true)]
        
        //Put uncomplete and complete tasks in baseArray
        baseArray = [tasks, completedTasks]
        
        self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //When main ViewController appears sort baseArray and reload data of tableView
        baseArray[0] = baseArray[0].sort {
            (taskOne: TaskModel, taskTwo: TaskModel) -> Bool in
             taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTaskDetail" {
            
            let detailVC: TaskDetailViewController = segue.destinationViewController as! TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            
                // grab the task of the selected row by indexing into baseArray for the indexPath's section and row
            let thisTask = baseArray[indexPath!.section][indexPath!.row]
            
                // set the task model of the view controller being segued to equal to the task we got from the selected row
            detailVC.detailTaskModel = thisTask
            
                // set TaskDetailViewController's mainVC property to self
            detailVC.mainVC = self
            
        } else if segue.identifier == "showAddTask" {
            
                // get a reference of the view controller being segued to
            let addTaskVC:AddTaskViewController = segue.destinationViewController as! AddTaskViewController
            
                // set addTaskViewController's mainVC property to self
            addTaskVC.mainVC = self
        }
    }
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showAddTask", sender: self)
    }
    
    
    //TableView Datasource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return baseArray.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //return count for each section of baseArray ***///called for how many sections there are ///***
        return baseArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            //make a cell
        let cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! TaskCell
        
            //get the item from baseArray, section, row
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
            //set each cell's stuff with the stuff from thisTask
        cell.taskLabel.text = thisTask.task
        cell.subtaskLabel.text = thisTask.subtask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        
        return cell
    }
    
    //TableView Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        
            //do this when a row it touched
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            //Hard coded header height value
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            //Depending on section, set a title for header
        if section == 0 {
            return "To do"
        }
        else {
            return "Completed"
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //access the specific task that was swiped
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 {
            
            //make a new version of thisTask that is completed
            let newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, completed: true)
            
            //add the new task with the updated completion parameter to the baseArray second section
            baseArray[1].append(newTask)

        } else {
            //make a new version of thisTask that is not completed
            let newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, completed: false)
            
            //add it to the uncomplete section of baseArray
            baseArray[0].append(newTask)
        }
        
        //remove the item from the baseArray based off of which one was selected
        baseArray[indexPath.section].removeAtIndex(indexPath.row)
        
        tableView.reloadData()

        
    }
    
}

