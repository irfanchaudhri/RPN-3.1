//
//  CalcViewController.swift
//  CalculatorRPN
//
//  Created by Irfan Chaudhri on 08/02/2017.
//  Copyright © 2017 Irfan Chaudhri. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerTwo: UIViewController {
    
    var tape = Array<String>()
    
    @IBOutlet weak var calcTape: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calcTape.text = tape.joined(separator: "\r\n")
        
        let sel:Selector = #selector(self.appMovedToBackground)
        let notificationCentre = NotificationCenter.default
        notificationCentre.addObserver(self, selector: sel, name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
        let defaults = UserDefaults.standard
        
        if let _:AnyObject = defaults.object(forKey: "savedStringKey") as AnyObject?{
            
            calcTape.text = UserDefaults.standard.string(forKey: "savedStringKey")
            
            print("SAVED")
        }
        else {
            print("not saved")
        }
        
        
    }
    
    @IBAction func clearAll(_ sender: UIButton) {
        
        // if the tape is not empty...
        if (calcTape.text != ""){
            
            // empty it (set to empty string)
            
            calcTape.text = ""
            let bundleIdentifier = Bundle.main.bundleIdentifier
            UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier!)
            
            
        } else {
            // otherwise, it was already empty, so display a message
            let alert = UIAlertController(title: "Alert", message: "Nothing to clear", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func appMovedToBackground(){
        print("App moved to background")
        let bundleIdentifier = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier!)
        let myText = calcTape.text
        UserDefaults.standard.set(myText, forKey: "savedStringKey")
        print("saved in bg")
    }
}
