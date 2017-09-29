//
//  ThirdViewController.swift
//  OpioidConverterTest
//
//  Created by 1234 on 2/7/17.
//  Copyright © 2017 DiPi. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var textLabl: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var labelone: UILabel!
    @IBOutlet weak var oldLabel: UILabel!
    
    @IBOutlet weak var cntAnother: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var recivedDrug = [[Any]]()
    var D4 = [Double]()
    
    var recivedCvtAnal = String()
    var recivedCvtDose = String()
    
    
    var result = Double()
    var recivedNum = Double()
    var recivedAnal = String()
    var recivedDose = String()
    
    
    
    var history = [String]()
    var cvtAnaArr = ["Morphine", "Hydrocodone", "Oxycodone", "Oxymorphone", "Hydromorphone","Codeine","Meperidine",  "Fentanyl"]
    var cvtDoseArr = ["PO", "IV","Transdermal"]
    //an array contains all the ratios. Number represents position
    //Morphine = 0,Hydrocodone = 1,Oxycodone = 2,Oxymorphone = 3,Hydromorphone = 4
    //Codiene = 5,Meperidine = 6, Fentanyl = 7
    //-1 means NA
    
    //PO to PO
    var potopoRatio = [[1, 0.667, 0.667, 0.333, 0.133, 6.667, 10, -1],[1.5, 1, 1, 0.5, 0.2, 10, 15, -1],[1.5, 1, 1, 0.5, 0.2, 10, 15, -1],[3, 2, 2, 1, 0.4, 20, 30, -1],[7.5, 5, 5, 2.5, 1, 50, 75, -1],[0.15, 0.1, 0.1, 0.05, 0.02, 1, 1.5, -1],[0.1, 0.0667, 0.0667, 0.0333, 0.0133, 0.666, 1, -1],[-1,-1,-1,-1,-1,-1,-1,-1]]
    //PO to IV, IV to PO(1/ratio)
    var potoivRatio = [[0.333, -1, -1, 0.0333, 0.05, -1, 2.5, -1],[0.5, -1, -1, 0.05, 0.075, -1, 3.75, -1],[0.5, -1, -1, 0.05, 0.075, -1, 3.75, -1],[1, -1, -1, 0.1, 0.15, -1, 7.5, -1],[2.5, -1, -1, 0.25, 0.375, -1, 18.75, -1],[0.05, -1, -1, 0.005, 0.0075, -1, 0.375, -1],[0.0333, -1, -1, 0.0033, 0.005, -1, 0.25, -1],[-1,-1,-1,-1,-1,-1,-1,-1]]
    //PO to Transdermal,Transdermal to PO
    var pototranRatio = [[138.8, -1, -1, -1, 20.833, -1, 1041.66,-1],[208.33, -1, -1, 20.833, 31.25, -1, 1562.5,-1],[208.33, -1, -1, -1, -1, -1, 1562.5,-1],[416.6, -1, -1, 41.66, 62.5, -1, 3125,-1],[1041.66, -1, -1, 104.16, 156.25, -1, 7812.5, -1],[20.83, -1, -1, 2.083, 3.125, -1, 156.25,-1],[13.88, -1, -1, 1.388, 2.083, -1, 104.16,-1],[-1,-1,-1,-1,-1,-1,-1,-1]]
    //IV to Transdermal,Transdermal to IV
    var ivtotranRatio = [[416.6, -1, -1, 41.66, 62.5, -1, 3125,-1],[-1, 416.6, 416.6, -1, -1, 416.6, -1,-1],[-1, 416.6, 416.6, -1, -1, 416.6, -1,-1],[4166.6, -1, -1, 416.6, 625, -1, 31250,-1],[2777.7, -1, -1, 277.7, 416.6, -1, 20833.3,-1],[-1, 416.6, 416.6, -1, -1, 416.6, -1,-1],[55.56, -1, -1, 5.555, 8.333, -1, 416.66,-1],[-1,-1,-1,-1,-1,-1,-1,-1]]
    //IV to IV
    var ivtoivRatio = [[1, -1, -1, 0.1, 0.150, -1, 7.5,-1],[-1, 1, 1, -1, -1, 1, -1,-1],[-1, 1, 1, -1, -1, 1, -1,-1],[10, -1, -1, 1, 1.5, -1, 75,-1],[6.66, -1, -1, 0.666, 1, -1, 50,-1],[-1, 1, 1, -1, -1, 1, -1,-1],[0.133, -1, -1, 0.0133, 0.02, -1, 1,-1],[-1,-1,-1,-1,-1,-1,-1,-1]]
    // Fentanyl patch vaules 
    var fentanylPatchVals = [3, 2, 2, 1, 0.4, 20, 30, -1]
    // Fentanyl IV vaules
    var fentanylIvVals = [10, -1, -1, 1, 1.5, -1, 75, 0.025]
    // Fentanyl P) vaules
    var fentanylPoVals = [30, 20.0, 20, 10, 4, 200, 300, -1]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "RESULT"
        cntAnother.layer.cornerRadius = 10
        for i in 0..<recivedDrug[0].count{
            recivedNum = recivedDrug[2][i] as! Double
            recivedDose = recivedDrug[1][i] as! String
            recivedAnal = recivedDrug[0][i] as! String
            
            var resultNum = 0.0
            
            if(recivedAnal == "Methadone" || recivedCvtAnal == "Methadone"){
                resultNum = methadoneConverter(recivedAnal: recivedAnal, convertToDrug: recivedCvtAnal)
            } else if(recivedDose == "Transdermal" || recivedCvtDose == "Transdermal") {
                resultNum = fentanylConverter(recivedAnal: recivedAnal, convertToDrug: recivedCvtAnal)
            } else {
                resultNum = converter(recivedNum: recivedNum,recivedDose: recivedDose,recivedAnal: recivedAnal, convertToDrug: recivedCvtAnal)
            }
            
            D4.append(resultNum)
            
            
            if(resultNum > 0){
              result = result + resultNum
            }
            else{
              result = resultNum
              break
            }
            //print(result)
            
        }
        //converter(num,dose,anal)
        recivedDrug.append(D4)
        if(result > 0){
        
        numLabel.text = "\(round(Double(1000 * result))/1000)" + " mg/day"
        textLabl.text = "of " + recivedCvtAnal + " " + recivedCvtDose
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.tableView.rowHeight = 35.0
            self.tableView.tableFooterView = UIView()
            
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        }
        else{
        textLabl.numberOfLines = 0
    
        numLabel.text = "ERROR: "
        textLabl.text = "one or more inputs\ncould not be converted."
        
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.recivedDrug[3].count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.font = UIFont(name:"Avenir", size:12)
        cell.textLabel?.textColor = UIColor.gray
        
        let drugName = recivedDrug[0][indexPath.row] as? String
        let drugAnl = recivedDrug[1][indexPath.row] as? String
        let text = String(drugName! + " " + drugAnl!)
        let toDrugAmount = recivedDrug[3][indexPath.row] as! Double
        let fromDrugAmount = recivedDrug[2][indexPath.row] as! Double
        
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        cell.textLabel?.text = String(describing: Double(round(1000*toDrugAmount)/1000)) + " mg from " + String(describing: Double(round(1000*fromDrugAmount)/1000)) + " mg " + text!
        print(recivedDrug[0][0])
        print(recivedDrug[1][0])
        print(recivedDrug[2][0])
        
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func converter(recivedNum:Double,recivedDose:String,recivedAnal:String, convertToDrug: String) -> Double
    {
        var resultNum = Double()
        //PO to PO
        if(recivedDose == cvtDoseArr[0] && recivedDose == recivedCvtDose )
        {
            let a = cvtAnaArr.index(of: recivedAnal)
            let b = cvtAnaArr.index(of: convertToDrug)
            let cvtratio = potopoRatio[a!][b!] as? NSNumber
            resultNum = Double(recivedNum) * Double(cvtratio!)
            
        }//PO TO IV
        else if (recivedDose == cvtDoseArr[0] && recivedCvtDose == cvtDoseArr[1]){
            let a = cvtAnaArr.index(of: recivedAnal)
            let b = cvtAnaArr.index(of: convertToDrug)
            let cvtratio = potoivRatio[a!][b!] as? NSNumber
            resultNum = Double(recivedNum) * Double(cvtratio!)
            
        }//IV TO PO
        else if (recivedDose == cvtDoseArr[1] && recivedCvtDose == cvtDoseArr[0]){
            let a = cvtAnaArr.index(of: recivedAnal)
            let b = cvtAnaArr.index(of: convertToDrug)
            let cvtratio = potoivRatio[b!][a!] as? NSNumber
            let ratio = 1 / Double(cvtratio!)
            resultNum = Double(recivedNum) * ratio
            
        }//PO TO TRANS
        else if (recivedDose == cvtDoseArr[0] && recivedCvtDose == cvtDoseArr[2]){
            let a = cvtAnaArr.index(of: recivedAnal)
            let b = cvtAnaArr.index(of: convertToDrug)
            let cvtratio = pototranRatio[a!][b!] as? NSNumber
            resultNum = Double(recivedNum) * Double(cvtratio!)
        }//TRANS TO PO
        else if (recivedDose == cvtDoseArr[2] && recivedCvtDose == cvtDoseArr[0]){
            let a = cvtAnaArr.index(of: recivedAnal)
            let b = cvtAnaArr.index(of: convertToDrug)
            let cvtratio = pototranRatio[b!][a!] as? NSNumber
            let ratio = 1 / Double(cvtratio!)
            resultNum = Double(recivedNum) * ratio
        }//IV TO TRANS
        else if (recivedDose == cvtDoseArr[1] && recivedCvtDose == cvtDoseArr[2]){
            let a = cvtAnaArr.index(of: recivedAnal)
            let b = cvtAnaArr.index(of: convertToDrug)
            let cvtratio = ivtotranRatio[a!][b!] as? NSNumber
            resultNum = Double(recivedNum) * Double(cvtratio!)
        }//TRANS TO IV
        else if (recivedDose == cvtDoseArr[2] && recivedCvtDose == cvtDoseArr[1]){
            let a = cvtAnaArr.index(of: recivedAnal)
            let b = cvtAnaArr.index(of: convertToDrug)
            let cvtratio = ivtotranRatio[b!][a!] as? NSNumber
            let ratio = 1 / Double(cvtratio!)
            resultNum = Double(recivedNum) * ratio
        }//IV TO IV
        else if (recivedDose == cvtDoseArr[1] && recivedCvtDose == cvtDoseArr[1]){
            let a = cvtAnaArr.index(of: recivedAnal)
            let b = cvtAnaArr.index(of: convertToDrug)
            let cvtratio = ivtoivRatio[a!][b!] as? NSNumber
            resultNum = Double(recivedNum) * Double(cvtratio!)
        }
        
        return resultNum

    }
    
    func methadoneConverter(recivedAnal:String, convertToDrug: String) -> Double {
        var resultNum = Double()
        var convertTest = Double()
        print(recivedAnal)
        // Test to see if we are going from Methadone to another Drug
        // If we are then we must convert from Methadone to Morphine then to whatever the next drug is
        if(recivedAnal == "Methadone"){
            if(recivedCvtDose == "Transdermal"){
                convertTest = recivedNum * 1.666667
                convertTest = convertTest / 24
                resultNum = convertTest * 25
            } else if(recivedDose == "PO"){
                convertTest = recivedNum * 0.1666667 * 30
                resultNum = converter(recivedNum: convertTest, recivedDose: recivedDose, recivedAnal: "Morphine", convertToDrug: convertToDrug)
            } else {
                convertTest = recivedNum * 1.666667
                resultNum = converter(recivedNum: convertTest, recivedDose: recivedDose, recivedAnal: "Morphine", convertToDrug: convertToDrug)
            }
        } else if(convertToDrug == "Methadone"){
            if(recivedDose == "Transdermal"){
                convertTest = recivedNum / 25
                convertTest = convertTest * 72
                if(convertTest < 101){
                    resultNum = convertTest / 4
                } else if(convertTest > 100 && convertTest < 301){
                    resultNum = convertTest / 10
                } else {
                    resultNum = convertTest / 15
                }
            } else if(recivedDose == "PO"){
                convertTest = converter(recivedNum: recivedNum, recivedDose: recivedDose, recivedAnal: recivedAnal, convertToDrug: "Morphine")
                print(convertTest)
                if(convertTest < 101){
                    resultNum = convertTest / 4
                } else if(convertTest > 100 && convertTest < 301){
                    resultNum = convertTest / 10
                } else {
                    resultNum = convertTest / 15
                }
            } else {
                convertTest = converter(recivedNum: recivedNum, recivedDose: recivedDose, recivedAnal: recivedAnal, convertToDrug: "Morphine")
                print(convertTest)
                convertTest = convertTest * 3
                if(convertTest < 101){
                    resultNum = convertTest / 4
                } else if(convertTest > 100 && convertTest < 301){
                    resultNum = convertTest / 10
                } else {
                    resultNum = convertTest / 15
                }
                resultNum = resultNum * 0.8
            }
        }
        return resultNum
    }
    
    func fentanylConverter(recivedAnal:String, convertToDrug: String) -> Double {
        var resultNum = Double()
        if(recivedAnal == "Fentanyl"){
            if(recivedCvtDose == "PO"){
                resultNum = recivedNum / 1000
                resultNum = resultNum / 0.025
                resultNum = resultNum * 24
                let x = cvtAnaArr.index(of: convertToDrug)
                resultNum = resultNum * fentanylPatchVals[x!]
            } else if(recivedCvtDose == "IV") {
                resultNum = recivedNum / 1000
                resultNum = resultNum / 0.025
                resultNum = resultNum * 24
                if(convertToDrug == "Morphine"){
                    return resultNum
                } else {
                    resultNum = resultNum / 10
                    let x = cvtAnaArr.index(of: convertToDrug)
                    resultNum = resultNum * fentanylIvVals[x!]
                }
            } else {
                return resultNum
            }
            
        } else {
            if(recivedDose == "PO"){
                let x = cvtAnaArr.index(of: recivedAnal)
                resultNum = recivedNum / fentanylPoVals[x!]
                resultNum = resultNum * 30
                print(resultNum)
                print(recivedNum)
                resultNum = resultNum / 3
                resultNum = resultNum / 24
                resultNum = resultNum * 25
            } else if(recivedDose == "IV"){
                let x = cvtAnaArr.index(of: recivedAnal)
                resultNum = recivedNum / fentanylIvVals[x!]
                resultNum = resultNum * 10
                resultNum = resultNum / 24
                resultNum = resultNum * 25
            } else {
                return resultNum
            }
        }
        return resultNum
    }
    
    
}
