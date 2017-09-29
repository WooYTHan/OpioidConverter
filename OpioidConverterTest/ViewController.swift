//
//  ViewController.swift
//  OpioidConverterTest
//
//  Created by 1234 on 1/18/17.
//  Copyright © 2017 DiPi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDelegate, UITableViewDataSource{
    
    var Analgesic = "Morphine"
    var DoseName = "PO"
    var Drugs = [[Any]]()
    var D1 = [String]()
    var D2 = [String]()
    var D3 = [Double]()
    var Number = Double()
     var pickerDataSource = [["Morphine", "Hydrocodone", "Oxycodone", "Oxymorphone", "Hydromorphone","Codeine","Meperidine", "Methadone", "Fentanyl"],["PO", "IV","Transdermal"]]

    //var table1Data = [String]()
   
    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet weak var Name: UIPickerView!
    @IBOutlet weak var Dose: UITextField!
 
    @IBOutlet weak var nextStep: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addNew(_ sender: UIButton) {
        if let text = Dose.text, !text.isEmpty
        {
            Number = Double((Dose?.text!)!)!
        }
        else
        {
            Number = 0
        }
        
        func saveDrugs(){
            D1.append(Analgesic)
            D2.append(DoseName)
            D3.append(Number)

            DispatchQueue.main.async{
                self.tableView.reloadData()
            }

            Analgesic = "Morphine"
            DoseName = "PO"
               
            Name.selectRow(0, inComponent: 0, animated: true)
            Name.selectRow(0, inComponent: 1, animated: true)
            Dose.text = ""
            
            
        }
        if(Number <= 0){
            let alertController = UIAlertController(title: "Number is invalid", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
            let okAction = UIAlertAction(title: "Continue", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            saveDrugs()
        }
    }
   
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "STEP ONE"
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 1.0/255, green: 175.0/255, blue: 204.0/255, alpha: 1.0),NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 20)!]

        
        self.Name.dataSource = self
        self.Name.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = 28.0
        self.tableView.tableFooterView =  UIView()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        addButton.layer.cornerRadius = 10
        nextStep.layer.cornerRadius = 10
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return self.D1.count;
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
            cell.textLabel?.font = UIFont(name:"Avenir", size:14)
            cell.textLabel?.textColor = UIColor.gray
    
            let row = indexPath.row
            let drugAmount = D3[row] 
            let drugName = D1[row]
            let drugAnl = D2[row]
    
            cell.textLabel?.text = String(describing: Double(round(1000 * drugAmount)/1000)) + " mg " + drugName + " " + drugAnl
    
            return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { (action, indexPath) in
            
            self.D1.remove(at: indexPath.row)
            self.D2.remove(at: indexPath.row)
            self.D3.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            // delete item at indexPath
        }
        
        delete.backgroundColor = UIColor(red: 1.0/255, green: 175.0/255, blue: 204.0/255, alpha: 1.0)
       
        
        return [delete]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(component == 0)
        {
            return pickerDataSource[0].count
        }
        else
        {
            return pickerDataSource[1].count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if(component == 0)
        {
            return pickerDataSource[0][row]
        }
        else
        {
            return pickerDataSource[1][row]
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(component == 0)
        {
          Analgesic = pickerDataSource[0][row]
           
        }
        else
        {
           DoseName = pickerDataSource[1][row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        var data = String()
        if(component == 0)
        {
            data = pickerDataSource[0][row]
        }
        else
        {
            data = pickerDataSource[1][row]
        }
        let title = NSAttributedString(string: data, attributes: [NSForegroundColorAttributeName: UIColor(red: 1.0/255, green: 175.0/255, blue: 204.0/255, alpha: 1.0),NSFontAttributeName: UIFont(name: "Avenir", size: 20.0)!])
        label?.attributedText = title
        label?.textAlignment = .center
        return label!
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "secondSegue" {
                if (D1.isEmpty) {
            
                    let alertController = UIAlertController(title: "NO DRUG ADDED", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
                    // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                    let okAction = UIAlertAction(title: "Continue", style: UIAlertActionStyle.default) {
                        (result : UIAlertAction) -> Void in
                    }
            
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
            
                }
            }
        }
        return true
   
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "secondSegue") {
            if let text = Dose.text, !text.isEmpty
            {
                if(Double((Dose?.text!)!) == nil) {
                    Number = -1
                } else {
                    Number = Double((Dose?.text!)!)!
                }
            }
            else
            {
                Number = 0
            }
            
            if(Drugs.isEmpty){
                Drugs.append(D1)
                Drugs.append(D2)
                Drugs.append(D3)
            }
            else{
                Drugs.removeAll()
                Drugs.append(D1)
                Drugs.append(D2)
                Drugs.append(D3)
            }
            
            
            print(Drugs)
            let newVC: SecondViewController = segue.destination as! SecondViewController
            let passedNumber = Double(Number)
            newVC.recivedDrugs = Drugs
            newVC.recivedAnalgesic = Analgesic
            newVC.recivedDoseName = DoseName
            newVC.recivedNumber = passedNumber
        }
    
    }

}

