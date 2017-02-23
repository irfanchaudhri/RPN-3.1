//
//  CalculatorEngine.swift
//  CalculatorRPN
//
//  Created by Irfan Chaudhri on 08/02/2017.
//  Copyright © 2017 Irfan Chaudhri. All rights reserved.
//

import Foundation
import UIKit
import Darwin

class CalculatorEngine: NSObject {
    
    var operandStack = Array<Double>()
    
    func updateStackWithValue(_ value: Double) {
        self.operandStack.append(value)
    }
    
    func sindegrees(_ degrees: Double)->Double {
        return sin(degrees * M_PI / 180.0)
    }
    
    func cosdegrees(_ degrees: Double)->Double {
        return cos(degrees * M_PI / 180.0)
    }
    
    func tandegrees(_ degrees: Double)->Double {
        return tan(degrees * M_PI / 180.0)
    }
    
    func asinradian(_ radian: Double)->Double {
        return asin(radian) * (180.0 / M_PI)
    }
    
    func acosradian(_ radian: Double)->Double {
        return acos(radian) * (180.0 / M_PI)
    }
    
    func atanradian(_ radian: Double)->Double {
        return atan(radian) * (180.0 / M_PI)
    }
    
    func operate(_ operation: String, buttonname: String)->Double {
        
        switch operation {
            
        case "×":
            if operandStack.count >= 2 {
                return self.operandStack.removeLast() * self.operandStack.removeLast()
            }
            
        case "÷":
            if operandStack.count >= 2 {
                return self.operandStack.removeFirst() / self.operandStack.removeLast()
            }
            
        case "+":
            if operandStack.count >= 2 {
                return self.operandStack.removeLast() + self.operandStack.removeLast()
            }
            
        case "−":
            if operandStack.count >= 2 {
                return self.operandStack.removeFirst() - self.operandStack.removeLast()
            }
            
        case "±":
            return self.operandStack.removeLast() * (-1)
            
        case "x²":
            let number = self.operandStack.removeLast()
            return number * number
            
        case "√":
            return sqrt(self.operandStack.removeLast())
            
        case "π":
            let ans = self.operandStack.removeLast() * M_PI
            return round(ans * 10000000) / 10000000
            
        case "⅟x":
            return 1 / self.operandStack.removeLast()
            
        case "log₁₀":
            return log10(self.operandStack.removeLast())
            
        case "logᵉ":
            return log(self.operandStack.removeLast())
            
        case "sin":
            if (buttonname == "rad") {
                return sin(self.operandStack.removeLast())
            }
            else {
                return sindegrees(self.operandStack.removeLast())
            }
            
        case "cos":
            if (buttonname == "rad") {
                return cos(self.operandStack.removeLast())
            }
            else {
                return cosdegrees(self.operandStack.removeLast())
            }
            
        case "tan":
            if (buttonname == "rad") {
                return tan(self.operandStack.removeLast())
            }
            else {
                return tandegrees(self.operandStack.removeLast())
            }
            
        case "sin-¹":
            if (buttonname == "rad") {
                return asin(self.operandStack.removeLast())
            }
            else {
                return asinradian(self.operandStack.removeLast())
            }
            
        case "cos-¹":
            if (buttonname == "rad") {
                return acos(self.operandStack.removeLast())
            }
            else {
                return acosradian(self.operandStack.removeLast())
            }
            
        case "tan-¹":
            if (buttonname == "rad") {
                return atan(self.operandStack.removeLast())
            }
            else {
                return atanradian(self.operandStack.removeLast())
            }
            
        default: break
        }
        return 0.0
        
    }
    
    }



