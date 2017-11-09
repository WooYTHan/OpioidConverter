//
//  taperingViewController.swift
//  OpioidConverterTest
//
//  Created by 1234 on 10/1/17.
//  Copyright © 2017 DiPi. All rights reserved.
//

import UIKit

class taperingViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let section = ["Function: Impact on daily activities", "Behavior: Impact on actions", "Symptoms: Impact on physical state","Feeling: Impact on emotional state"]
    
    let items = [["Are you able to do what you need to do each day?","Are you still able to do your job, your chores, or other daily tasks?"],["Are you sticking to the tapering plan that you and your care team decided on?","Are you taking your medicines as directed?","Has tapering negatively impacted your relationships with your friends and family?"],["Is your pain level manageable?","Are your withdrawal symptoms manageable?"],["Overall, do you feel like your tapering plan is a good fit for you?","Do you feel like you’re moving in the right direction?","Do you feel like you have some control over any anxiety and/or depression?"]]
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Tapering Guidance"
        
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = 45.0
        self.tableView.sectionHeaderHeight = 38
        self.tableView.allowsMultipleSelection = true
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.section[section]
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.section.count
        
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name:"Avenir-Medium", size:16)
        
        header.textLabel?.textColor = UIColor.white
        
        header.backgroundView?.backgroundColor = UIColor(red: 1.0/255, green: 175.0/255, blue: 204.0/255, alpha: 1.0)    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items[section].count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        cell.textLabel?.font = UIFont(name:"Avenir", size:14)
        cell.textLabel?.textColor = UIColor.gray
        
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        
        cell.selectionStyle = .none
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    


}
