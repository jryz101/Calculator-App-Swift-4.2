//
//  ViewController.swift
//  Calculator-App
//
//  Created by Jerry Tan on 03/03/2019.
//  Copyright © 2019 Initiate Design®. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //#1.Linked up IB outlets.
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    
    //#2.Declare instance variables.
    var numberOnScreen: String?
    var numberOnSecondScreen: String?
    var previousSign: String = "+"
    var performMath: Bool? = true
    var previousButton: String = ""
    
    var result: Double = 0
    
    
    
    
    //#3.Linked up IB Action numberTap.
    @IBAction func numberTap(_ sender: UIButton) {
        //Declare numberTap methods.
        if previousButton == "+" || previousButton == "-" || previousButton == "x" || previousButton == "÷" || previousButton == "%" {
            
            performMath = false
        }
        
        if performMath! {
            self.clearScreen()
        }
        
        performMath = false
        
        numberOnScreen = resultLabel.text
        if sender.currentTitle == "." {
            if resultLabel.text!.contains(".") {
                return
            }
            if numberOnScreen == "0" {
                resultLabel.text = numberOnScreen! + sender.currentTitle!
                return
            }
        }
        if numberOnScreen == "0" {
            numberOnScreen = ""
        }
        resultLabel.text = numberOnScreen! + sender.currentTitle!
        
        previousButton = sender.currentTitle!
    }
    
    
    
    
    //#4.Linked up IB Action operatorTap.
    @IBAction func operatorTap(_ sender: UIButton) {
    //Declare operatorTap methods.
    if (previousButton == "+" || previousButton == "-" || previousButton == "x" || previousButton == "÷" || previousButton == "%") && sender.currentTitle != "=" {
            operationLabel.text = "\(formatNumber(result)) \(sender.currentTitle!) "
            previousButton = sender.currentTitle!
            previousSign = previousButton
            return
        }
        
        if sender.currentTitle! == "=" {
            if operationLabel.text! == "" || previousButton == "="{
                return
            }
        }
        
        numberOnSecondScreen = operationLabel.text!
        
        if sender.currentTitle != "=" {
            if numberOnSecondScreen == "" {
                numberOnSecondScreen = resultLabel.text!
                operationLabel.text = numberOnSecondScreen! + sender.currentTitle!
            } else {
                numberOnSecondScreen = operationLabel.text!
                operationLabel.text = numberOnSecondScreen! + resultLabel.text! + sender.currentTitle!
            }
        } else {
            if numberOnSecondScreen == "" {
                numberOnSecondScreen = resultLabel.text!
                operationLabel.text = numberOnSecondScreen!
            } else {
                numberOnSecondScreen = operationLabel.text!
                operationLabel.text = numberOnSecondScreen! + resultLabel.text!
            }
        }
        //Switch case of previousSign.
        switch previousSign {
        case "+":
            result += Double(resultLabel.text!)!
        case "-":
            result -= Double(resultLabel.text!)!
        case "x":
            result *= Double(resultLabel.text!)!
        case "÷":
            result /= Double(resultLabel.text!)!
        case "%":
            result = result.truncatingRemainder(dividingBy: Double(resultLabel.text!)!)
        default:
            print("err")
        }
        
        
        
        if sender.currentTitle! == "=" {
            operationLabel.text = "\(operationLabel.text!) "
            
            if formatNumber(result) == "inf" || formatNumber(result) == "nan" {
                resultLabel.text = "Error"
            } else {
                resultLabel.text = formatNumber(result)
            }
            self.resetCalculator()
        } else {
            operationLabel.text = "\(formatNumber(result)) \(sender.currentTitle!) "
            previousSign = sender.currentTitle!
            
            resultLabel.text = "0"
        }
        
        
        previousButton = sender.currentTitle!
        
        
    }
        
    
    
    
    //#5.Linked up IB Action otherButtonTap.
    @IBAction func otherButtonTap(_ sender: UIButton) {
        
        if sender.currentTitle == "C" {
            self.clearScreen()
        } else if sender.currentTitle == "+/-" {
            var tempNum = Double(resultLabel.text!)!
            tempNum = -tempNum
            resultLabel.text = self.formatNumber(tempNum)
        }
        
        previousButton = sender.currentTitle!
    }
    
    
    //Create clearScreen, resetCalculator function.
    func clearScreen() -> Void {
        operationLabel.text = ""
        resultLabel.text = "0"
        result = 0
        previousSign = "+"
        performMath = true
    }
    
    func resetCalculator() -> Void {
        previousSign = "+"
        performMath = true
        result = 0
    }
    //Declare function takes one input Double and output as String.
    func formatNumber(_ number: Double) -> String{
        return String(format: "%g", number)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        


   override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

