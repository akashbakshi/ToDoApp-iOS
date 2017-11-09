//
//  ViewController.swift
//  ToDoApp
//
//  Created by Akash Bakshi on 2017-11-08.
//  Copyright © 2017 Akash Bakshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var tbReminders: UITableView!
    @IBOutlet weak var reminderInputField: UITextField!
    
    @IBOutlet weak var showCompletedBtn: UIButton!
    
    var showCompleted = false
    
    var reminderItems = [String]()
    var completeItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbReminders.dataSource = self
        tbReminders.delegate = self
        reminderItems.append("Congrats! You remembered everything! Add more stuff to remember")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showCompleted == false{
            
            return reminderItems.count
        }
        else{
            
            return completeItems.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        if showCompleted == false{
            cell.textLabel?.text = reminderItems[indexPath.row]
        }
        else{
            cell.textLabel?.text = completeItems[indexPath.row]
        }
       
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath)->[UITableViewRowAction]? {
        
        let complete = UITableViewRowAction(style: .normal, title: "Complete") { action, index in
            let tmpCell = tableView.cellForRow(at: indexPath)
            self.completeItems.append((tmpCell?.textLabel?.text)!)
            self.reminderItems.remove(at: indexPath.row)
            self.tbReminders.reloadData()
        }
        complete.backgroundColor = UIColor(red: 50.0/255.0, green: 215.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            self.reminderItems.remove(at: indexPath.row)
            self.tbReminders.reloadData()
        }
        delete.backgroundColor = UIColor.red
        return [complete,delete]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }
    //WORK HERE ON CLEARING THE LIST WHEN TEXT EQUALS DEFAULT
    @IBAction func addReminder(_ sender: UIButton) {
        if reminderInputField.text?.isEmpty == false{
            if reminderItems[0] == "Congrats! You remembered everything! Add more stuff to remember"{
                reminderItems.remove(at: 0)
                reminderItems.append(reminderInputField.text!)
                reminderInputField.text = ""
                tbReminders.reloadData()
            }else{
                reminderItems.append(reminderInputField.text!)
                reminderInputField.text = ""
                tbReminders.reloadData()
            }
        }
    }
    
    @IBAction func ShowCompletedItems(_ sender: UIButton) {
        if showCompleted == true{
            showCompleted = false
            tbReminders.reloadData()
            showCompletedBtn.setTitle("Show Completed", for: .normal)
            
        }
            
        else if showCompleted == false{
            showCompleted = true
            tbReminders.reloadData()
            showCompletedBtn.setTitle("Show Reminders", for: .normal)
        }
        print("\(showCompleted)")
    }
}

