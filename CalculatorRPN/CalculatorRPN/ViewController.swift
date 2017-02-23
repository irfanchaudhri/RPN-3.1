//
//  ViewController.swift
//  CalculatorRPN
//
//  Created by Irfan Chaudhri on 08/02/2017.
//  Copyright © 2017 Irfan Chaudhri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelDisplay: UILabel!
    @IBOutlet weak var calcDisplay: UILabel!
    @IBOutlet weak var dec: UIButton!
    @IBOutlet weak var sin: UIButton!
    @IBOutlet weak var tan: UIButton!
    @IBOutlet weak var second: UIButton!
    @IBOutlet weak var cos: UIButton!
    
    // declaring a variable of type "calculatorengine"
    var calcEngine: CalculatorEngine?
    
    
    var butname: String?
    
    // boolean value to determine if the user has started typing or not.
    var userHasStartedTyping = false;
    
    // empty string
    var labelString: String = ""
    
    // variable for calculator tape use
    var calcTape = Array<String>()
    
    
    // method for detecting presses of digits
    @IBAction func digitPressed(_ sender: UIButton) {
        
        // setting a constant based on the title of the button which is pressed
        let digit = sender.currentTitle!
        
        // printing that digit to the console
        print("digit pressed= \(digit)")
        
        // if the user has started typing...
        if userHasStartedTyping {
            // set the label display to the current display plus the tapped digit
            labelDisplay.text = labelDisplay.text! + "\(digit)"
        }
        // otherwise
        else {
            // the user is typing for the first time, so set the display to the tapped digit
            labelDisplay.text = digit
            // the user has now started typing
            userHasStartedTyping = true
        }
    }
    
    
    // method to handle the decimal point
    @IBAction func decimal(_ sender: UIButton) {
        
        // declaring a constant for the title of the decimal point
        let decimal = sender.currentTitle!
        
        // if the user has started to type...
        if userHasStartedTyping {
            // set the display to the current text plus the decimal point
            labelDisplay.text = labelDisplay.text! + "\(decimal)"
            //set the calcdisplay to the same
            calcDisplay.text = calcDisplay.text! + "\(decimal)"
            // stop reoccurance/use of the decimal point button
            dec.isEnabled = false;
        }
        // otherwise
        else {
            // set the display to zero
            labelDisplay.text=("0")
            // the user has started to type
            userHasStartedTyping = true
            // enable the button again
            dec.isEnabled = true
        }
        
    }
    
    
    @IBAction func degRad(_ sender: UIButton) {
        
        // if the title of the senders button is "deg"...
        if(sender.titleLabel!.text == "deg") {
            // change it to "rad"
            sender.setTitle("rad", for: UIControlState())
            // this variable is now set to this string
            butname = "rad"
        }
        else {
            // otherwise, set it to this one (the original)
            sender.setTitle("deg", for: UIControlState())
            // this variable is now set to this string
            butname = "deg"
        }
    }
    
    
    @IBAction func second(_ sender: UIButton) {
        //same for all IF statements below:
        // if the title of this button is "sin"...
        if(sin.titleLabel!.text == "sin"){
            // change it to this one, as a state change
            sin.setTitle("sin-¹", for: UIControlState())
        }
        // otherwise, set it to this one (the original)
        else {
            sin.setTitle("sin", for: UIControlState())
        }
        
        if(cos.titleLabel!.text == "cos"){
            cos.setTitle("cos-¹", for: UIControlState())
        }
        else {
            cos.setTitle("cos", for: UIControlState())
        }
        
        if(tan.titleLabel!.text == "tan"){
            tan.setTitle("tan-¹", for: UIControlState())
        }
        else {
            tan.setTitle("tan", for: UIControlState())
        }
        
        if(second.titleLabel!.text == "2nd"){
            second.setTitle("1st", for: UIControlState())
        }
        else {
            second.setTitle("2nd", for: UIControlState())
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        butname = "deg"
        
        if self.calcEngine == nil {
            self.calcEngine = CalculatorEngine()
        }
        
    }
    
    var displayValue: Double {
        
        get {
            return (NumberFormatter().number(from: labelDisplay.text!)?.doubleValue)!
        }
        
        set(newValue) {
            labelDisplay.text = "\(newValue)"
        }
        
    }
    
    
    @IBAction func enter() {
        
        userHasStartedTyping = false
        
        self.calcEngine!.operandStack.append(displayValue)
        
        dec.isEnabled = true
        
        calcDisplay.text! += "\(displayValue)↵"
        
        labelString = labelString + "\(displayValue)↵"
        
        print("Operand Stack on engine = \(self.calcEngine!.operandStack)")
        
    }
    
    
    @IBAction func operation(_ sender: UIButton) {
        
        let operation = sender.currentTitle!
        
        if userHasStartedTyping {
            enter()
        }
        self.displayValue = (self.calcEngine?.operate(operation, buttonname: butname!))!
        
        labelString += "\(operation)"
        
        calcDisplay.text! += "\(operation)"
        
        enter()
        
        calcTape.append(labelString)
        
        labelString = ""
        
    }
    
    @IBAction func clear(_ sender: UIButton) {
        
        labelDisplay.text = "\(0)"
        
        self.calcEngine!.operandStack.removeLast()
        
        userHasStartedTyping = false
        
    }
    
    
    @IBAction func allClear(_ sender: UIButton) {
        
        labelDisplay.text = "0"
        
        calcDisplay.text = ""
        
        self.calcEngine!.operandStack.removeAll()
        
        userHasStartedTyping = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let calcVC: ViewControllerTwo = segue.destination as! ViewControllerTwo
        

        
        calcVC.tape = calcTape
        
        print(calcTape)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

