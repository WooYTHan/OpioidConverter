//
//  SecondViewController.swift
//  OpioidConverterTest
//
//  Created by 1234 on 1/18/17.
//  Copyright © 2017 DiPi. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    @IBOutlet weak var convert: UIPickerView!
    
    @IBOutlet weak var nextStep: UIButton!
    var recivedDrugs = [[Any]]()
    var recivedAnalgesic = String()
    var recivedDoseName = String()
    var recivedNumber = Double()
    
    var cvtAnalgesic = "Morphine"
    var cvtDoseName = "PO"
    var cvtPickerDataSource = [["Morphine", "Hydrocodone", "Oxycodone", "Oxymorphone", "Hydromorphone","Codeine","Meperidine", "Methadone", "Fentanyl"],["PO", "IV","Transdermal"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "STEP TWO"
        nextStep.layer.cornerRadius = 10

        self.convert.dataSource = self
        self.convert.delegate = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(component == 0)
        {
            return cvtPickerDataSource[0].count
        }
        else
        {
            return cvtPickerDataSource[1].count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if(component == 0)
        {
            return cvtPickerDataSource[0][row]
        }
        else
        {
            return cvtPickerDataSource[1][row]
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(component == 0)
        {
            cvtAnalgesic = cvtPickerDataSource[0][row]
        }
        else
        {
            cvtDoseName = cvtPickerDataSource[1][row]
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
            data = cvtPickerDataSource[0][row]
        }
        else
        {
            data = cvtPickerDataSource[1][row]
        }
        let title = NSAttributedString(string: data, attributes: [NSForegroundColorAttributeName: UIColor(red: 1.0/255, green: 175.0/255, blue: 204.0/255, alpha: 1.0),NSFontAttributeName: UIFont(name: "Avenir", size: 20.0)!])
        label?.attributedText = title
        label?.textAlignment = .center
        return label!
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVC: ThirdViewController = segue.destination as! ThirdViewController
        newVC.recivedDrug = recivedDrugs
        /*newVC.recivedNum = recivedNumber
        newVC.recivedDose = recivedDoseName
        newVC.recivedAnal = recivedAnalgesic*/
        newVC.recivedCvtAnal = cvtAnalgesic
        newVC.recivedCvtDose = cvtDoseName
    }


    


}
