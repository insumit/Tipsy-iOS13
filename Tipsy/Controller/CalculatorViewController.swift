//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var result2DecimalPlaces = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        tipLogic(button: sender)
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let billAmount = billTextField.text!
        
        if billAmount != "" {
            billTotal = Double(billAmount)!
            let result = billTotal * (1 + tip)/Double(numberOfPeople)
            result2DecimalPlaces = String(format: "%.2f", result)
            performSegue(withIdentifier: "calculateResult", sender: self)
        }
    }
    
    func tipLogic(button: UIButton) {
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        button.isSelected = true
        
        let selectedValue: Int = Int(button.currentTitle!.dropLast()) ?? 0
        
        tip = Double(selectedValue)/100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calculateResult" {
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.result = result2DecimalPlaces
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
            
        }
    }
}

