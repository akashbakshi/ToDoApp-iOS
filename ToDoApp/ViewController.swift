//
//  ViewController.swift
//  ToDoApp
//
//  Created by Akash Bakshi on 2017-11-08.
//  Copyright © 2017 Akash Bakshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
   
    @IBOutlet weak var tbReminders: UITableView!
    @IBOutlet weak var reminderInputField: UITextField!
    
    @IBOutlet weak var showCompletedBtn: UIButton!
    
    var showCompleted = false
    
    var reminderItems = [String]()
    var completeItems = [String]()
    
    let textWriting = UIColor(red: 254.0/255.0, green: 235.0/255.0, blue: 16.0/255.0, alpha: 1.0)
    let defaultTint = UIColor(red: 102.0/255.0, green: 108.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbReminders.dataSource = self
        tbReminders.delegate = self
        reminderInputField.delegate=self
        reminderItems.append("Congrats! You remembered everything! Add more stuff to remember")
        tbReminders.separatorColor = defaultTint
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == ""{
            print("test 1")
            self.view.endEditing(true)
        }else{
            if reminderItems[0] == "Congrats! You remembered everything! Add more stuff to remember"{
                reminderItems.remove(at: 0)
                appendDataToList()
            }else{
                appendDataToList()
            }
            self.view.endEditing(true)
        }
        return false
    }
    //tableview
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
            cell.textLabel?.textColor = textWriting
            cell.textLabel?.text = reminderItems[indexPath.row]
        }
        else{
            cell.textLabel?.textColor = defaultTint
            cell.textLabel?.text = completeItems[indexPath.row]
        }
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath)->[UITableViewRowAction]? {
        let incomplete = UITableViewRowAction(style: .normal, title: "Incomplete"){action, index in
            self.reminderItems.append(self.completeItems[indexPath.row])
            self.completeItems.remove(at: indexPath.row)
            self.tbReminders.reloadData()
        }
        incomplete.backgroundColor = textWriting
        
        let complete = UITableViewRowAction(style: .normal, title: "Complete") { action, index in
            if self.showCompleted == false{
                let tmpCell = tableView.cellForRow(at: indexPath)
                self.completeItems.append((tmpCell?.textLabel?.text)!)
                self.reminderItems.remove(at: indexPath.row)
                self.tbReminders.reloadData()
            }
        }
        complete.backgroundColor = defaultTint
        
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            if self.showCompleted == false{
                self.reminderItems.remove(at: indexPath.row)
                self.tbReminders.reloadData()
            }else{
                self.completeItems.remove(at: indexPath.row)
                self.tbReminders.reloadData()
            }
        }
        delete.backgroundColor = UIColor.red
        if showCompleted == false{
            return [complete,delete]
        }else{
            return [delete,incomplete]
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }
    func appendDataToList(){
        reminderItems.append(reminderInputField.text!)
        reminderInputField.text = ""
        tbReminders.reloadData()
    }
    
    //WORK HERE ON CLEARING THE LIST WHEN TEXT EQUALS DEFAULT
    @IBAction func addReminder(_ sender: UIButton) {
        if reminderInputField.text?.isEmpty == false{
            if reminderItems.count>0{
                if reminderItems[0] == "Congrats! You remembered everything! Add more stuff to remember"{
                    reminderItems.remove(at: 0)
                    appendDataToList()
                }else{
                    
                    appendDataToList()
                }
            }else{
              
                appendDataToList()
            }
        }
    }
    
    @IBAction func ShowCompletedItems(_ sender: UIButton) {
        if showCompleted == true{
            showCompleted = false
            tbReminders.reloadData()
            showCompletedBtn.setTitle("Show Completed", for: .normal)
            showCompletedBtn.backgroundColor = defaultTint
            showCompletedBtn.setTitleColor(textWriting, for: .normal)
            
            reminderInputField.isUserInteractionEnabled = true
            reminderInputField.placeholder = "Enter a reminder here"
        }
            
        else if showCompleted == false{
            showCompleted = true
            tbReminders.reloadData()
            showCompletedBtn.setTitle("Show Reminders", for: .normal)
            showCompletedBtn.backgroundColor = textWriting
            showCompletedBtn.setTitleColor(defaultTint, for: .normal)
            reminderInputField.isUserInteractionEnabled = false
            reminderInputField.text = ""
            reminderInputField.placeholder = "Go back to reminders page to add a reminder"
        }
        print("\(showCompleted)")
    }
}

