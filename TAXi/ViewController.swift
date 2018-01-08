//
//  ViewController.swift
//  TAXi
//
//  Created by Langtian Qin on 12/16/17.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var TipLabel: UILabel!
    @IBOutlet weak var AmountControl: UISegmentedControl!
    @IBOutlet weak var BillField: UITextField!
    @IBOutlet weak var TotalLabel: UILabel!
    @IBOutlet weak var Custom1: UILabel!
    
    @IBOutlet weak var SettingsButton: UIBarButtonItem!
    @IBOutlet weak var Custom2: UILabel!
    @IBOutlet weak var CustomField: UITextField!
    @IBOutlet weak var BillLabel: UILabel!
    @IBOutlet weak var TotalNameLabel: UILabel!
    
    @IBOutlet weak var TipNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let defaults = UserDefaults.standard
        colorChange()
        let end = Date()
        //Restore previous session if the time elapsed is less than 600 seconds
        if end.timeIntervalSince(GlobalTipSelection.tipSelection.start)<=600{
        BillField.text =  String(format:"%.2f",defaults.double(forKey: "lastBill"))
        }
        BillField.becomeFirstResponder()
        let defaultControl = defaults.integer(forKey: "defaultControl")
        let defaultCustom = defaults.double(forKey: "defaultCustom")
        AmountControl.selectedSegmentIndex = defaultControl
        CustomField.text = String(format:"%.2f",defaultCustom)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // Do any additional setup after loading the view, typically from a nib.
        colorChange()
        BillField.becomeFirstResponder()
        let defaults = UserDefaults.standard
        let defaultControl = defaults.integer(forKey: "defaultControl")
        let defaultCustom = defaults.double(forKey: "defaultCustom")
        AmountControl.selectedSegmentIndex = defaultControl
        CustomTrigger(self)
        if defaultControl == 4{
            CustomField.text = String(format:"%.2f",defaultCustom)
            CustomRatioChanged(self)
        }
        UserEdit(self)
    }
    
    class GlobalTipSelection {
        static let tipSelection = GlobalTipSelection()
        //Array consisting of default ratios and custom
        var tipRatios = [0.15,0.18,0.20,0.25,0]
        //Measure the starting timer
        var start = Date()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CustomTrigger(_ sender: Any) {
        //If user on custom tab, show input fields
        if AmountControl.selectedSegmentIndex == 4 {
            UIView.animate(withDuration: 1.5, animations: {
                self.Custom1.alpha = 1.0
                self.CustomField.alpha = 1.0
                self.Custom2.alpha = 1.0
            })
        }//If not, hide it
        else {
            UIView.animate(withDuration: 1.5, animations: {
                self.Custom1.alpha = 0.0
                self.CustomField.alpha = 0.0
                self.Custom2.alpha = 0.0
            })
        }
    }
    @IBAction func CustomRatioChanged(_ sender: Any) {
        let customRatio = Double(CustomField.text!) ?? 0
        GlobalTipSelection.tipSelection.tipRatios[4] = customRatio * 0.01
    }
    
    @IBAction func UserEdit(_ sender: Any) {
        let defaults = UserDefaults.standard
        let billNum = Double(BillField.text!) ?? 0
        defaults.set(billNum, forKey: "lastBill")
        GlobalTipSelection.tipSelection.start = Date()
        let tipRatios = GlobalTipSelection.tipSelection.tipRatios
        let tipRatio = tipRatios[AmountControl.selectedSegmentIndex]
        let tipNum = billNum * tipRatio
        let totalNum = billNum + tipNum
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol!
        TipLabel.text = currencySymbol+String(format:"%.2f",tipNum)
        TotalLabel.text = currencySymbol+String(format:"%.2f",totalNum)
    }

    
    @IBAction func OnTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    //Helper methods
    func hexToUIColor(hex: Int) -> UIColor {
        return UIColor(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,blue: CGFloat(hex & 0x0000FF) / 255.0,alpha: CGFloat(1.0)
        )
    }
    
    func colorChange(){
        let defaults = UserDefaults.standard
        let backgroundColor = hexToUIColor(hex:defaults.integer(forKey: "backgroundColor"))
        let textColor = hexToUIColor(hex:defaults.integer(forKey: "textColor"))
        let boxColor = hexToUIColor(hex:defaults.integer(forKey: "boxColor"))
        let specColor = hexToUIColor(hex:defaults.integer(forKey: "specColor"))
        self.view.backgroundColor=backgroundColor
        BillLabel.textColor=textColor
        TipNameLabel.textColor=textColor
        TotalNameLabel.textColor=textColor
        BillField.backgroundColor=boxColor
        BillField.textColor=textColor
        TipLabel.backgroundColor=boxColor
        TipLabel.textColor=textColor
        TotalLabel.backgroundColor=boxColor
        TotalLabel.textColor=textColor
        AmountControl.tintColor=specColor
        AmountControl.backgroundColor=boxColor
        Custom1.textColor=textColor
        Custom2.textColor=textColor
        CustomField.textColor=textColor
        CustomField.backgroundColor=boxColor
    }
}

