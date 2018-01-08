//
//  SettingsViewController.swift
//  TAXi
//
//  Created by Langtian Qin on 1/7/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var DefaultField: UILabel!
    @IBOutlet weak var ColorField: UILabel!
    @IBOutlet weak var ColorControl: UISegmentedControl!
    @IBOutlet weak var Custom2: UILabel!
    @IBOutlet weak var CustomField: UITextField!
    @IBOutlet weak var Custom1: UILabel!
    @IBOutlet weak var DefaultControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        colorChange()
        let defaults = UserDefaults.standard
        let defaultControl = defaults.integer(forKey: "defaultControl")
        let defaultCustom = defaults.double(forKey: "defaultCustom")
        let defaultColor = defaults.integer(forKey: "defaultColor")
        DefaultControl.selectedSegmentIndex = defaultControl
        ColorControl.selectedSegmentIndex = defaultColor
        CustomField.text = String(format:"%.2f",defaultCustom)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DefaultCustomChange(_ sender: Any) {
        let defaults = UserDefaults.standard
        let defaultCustom = Double(CustomField.text!) ?? 0
        defaults.set(defaultCustom, forKey: "defaultCustom")
        defaults.synchronize()
    }
    
    @IBAction func DefaultChange(_ sender: Any) {
        if DefaultControl.selectedSegmentIndex == 4 {
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
        let defaults = UserDefaults.standard
        let defaultControl = DefaultControl.selectedSegmentIndex
        defaults.set(defaultControl, forKey: "defaultControl")
        defaults.synchronize()
    }
    
    @IBAction func ColorChange(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(ColorControl.selectedSegmentIndex, forKey: "defaultColor")
        switch ColorControl.selectedSegmentIndex {
        case 0:
            defaults.set(0xFFFFFF, forKey: "backgroundColor")
            defaults.set(0x000000, forKey: "textColor")
            defaults.set(0xFFFFFF, forKey: "boxColor")
            defaults.set(0x0000FF,forKey: "specColor")
        case 1:
            defaults.set(0x000000, forKey: "backgroundColor")
            defaults.set(0xFFFFFF, forKey: "textColor")
            defaults.set(0x000000, forKey: "boxColor")
            defaults.set(0xFFFFFF,forKey: "specColor")
        case 2:
            defaults.set(0xC4F1BE, forKey: "backgroundColor")
            defaults.set(0x525B76, forKey: "textColor")
            defaults.set(0xA2C3A4, forKey: "boxColor")
            defaults.set(0x201E50,forKey: "specColor")
        case 3:
            defaults.set(0x829CBC, forKey: "backgroundColor")
            defaults.set(0x1D3461, forKey: "textColor")
            defaults.set(0x6290C8, forKey: "boxColor")
            defaults.set(0x1F487E,forKey: "specColor")
        case 4:
            defaults.set(0x086788, forKey: "backgroundColor")
            defaults.set(0xDD1C1A, forKey: "textColor")
            defaults.set(0xF0C808, forKey: "boxColor")
            defaults.set(0xFFF1D0,forKey: "specColor")
        default:
            defaults.set(0x000000, forKey: "backgroundColor")
            defaults.set(0xFFFFFF, forKey: "textColor")
            defaults.set(0x000000, forKey: "boxColor")
            defaults.set(0x0000FF,forKey: "specColor")
        }
        colorChange()
        defaults.synchronize()
    }
    
    //helper method
    func hexToUIColor(hex: Int) -> UIColor {
        return UIColor(red: CGFloat((hex & 0xFF0000)>>16)/255.0,green: CGFloat((hex&0x00FF00)>>8)/255.0,blue: CGFloat(hex&0x0000FF)/255.0,alpha: CGFloat(1.0)
        )
    }
    
    func colorChange(){
        let defaults = UserDefaults.standard
        let backgroundColor = hexToUIColor(hex:defaults.integer(forKey: "backgroundColor"))
        let textColor = hexToUIColor(hex:defaults.integer(forKey: "textColor"))
        let boxColor = hexToUIColor(hex:defaults.integer(forKey: "boxColor"))
        let specColor = hexToUIColor(hex:defaults.integer(forKey: "specColor"))
        self.view.backgroundColor=backgroundColor
        DefaultField.textColor=textColor
        ColorField.textColor=textColor
        DefaultField.backgroundColor=boxColor
        ColorField.backgroundColor=boxColor
        DefaultControl.tintColor=specColor
        DefaultControl.backgroundColor=boxColor
        ColorControl.tintColor=specColor
        ColorControl.backgroundColor=boxColor
        Custom1.textColor=textColor
        Custom2.textColor=textColor
        CustomField.textColor=textColor
        CustomField.backgroundColor=boxColor
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
