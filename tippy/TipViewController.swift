//
//  ViewController.swift
//  tippy
//
//  Created by Home Mac on 18/02/2017.
//  Copyright © 2017 Home Mac. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
  
  @IBOutlet weak var tipLabel: UILabel!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var billField: UITextField!
  @IBOutlet weak var tipControl: UISegmentedControl!
  
  // Set focus to the view and dismiss keyboard when tapped
  @IBAction func onTap(_ sender: AnyObject) {
    view.becomeFirstResponder()
    view.endEditing(true)
  }
  
  // Recalculate tip amount and total using provided values
  @IBAction func calculateTip(_ sender: AnyObject) {
    
    // Get user input
    let billAmount = Double(billField.text!) ?? 0
    let tipIndex = tipControl.selectedSegmentIndex
    
    // Use TipCalculator struct to calculate tip and total amount
    let calculator = TipCalculator()
    let result = calculator.calculateTip(forBill: billAmount, withIndex: tipIndex)
    
    // Display results
    tipLabel.text = String(format: "$%.2f", result.tip)
    totalLabel.text = String(format: "$%.2f", result.total)
  }
  
  // Setup notification observers and properties before view is shown
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("Tip view will appear - setup observers")
    //register TipViewController class as an observer
    //for UIApplicationDidBecomeActive Notification
    //and UIApplicationWillResignActive Notification
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(checkBillField),
                                           name: .UIApplicationDidBecomeActive,
                                           object: nil)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(saveBillFieldTextInput),
                                           name: .UIApplicationWillResignActive,
                                           object: nil)
    
    //Setup UISegmentedControl properties
    tipControl.loadTitles()
    
    //Set focus to the input field
    //Shows numeric keyboard to input bill amount
    billField.becomeFirstResponder()
  }
  
  // This method will be called by UIApplicationDidBecomeActive Notification
  // Check DataStore variable and clear Bill UI input field if needed
  // Otherwise load Bill UI input field value from storage
  @objc func checkBillField() {
    let clearBillAmount = DataStore.singleton.billAmountNeedsToBeReset
    print("Method called by notification - Clear Bill Amount is \(clearBillAmount)")
    if clearBillAmount {
      billField.text = ""
      DataStore.singleton.billAmountNeedsToBeReset = false
    } else {
      billField.text = DataStore.singleton.billAmount
    }
  }
  
  // This method will be called by UIApplicationWillResignActive Notification
  // Save Bill UI input field to user settings
  @objc func saveBillFieldTextInput() {
    print("Method called by notification - Save Bill Amount")
    DataStore.singleton.billAmount = billField.text!
    DataStore.singleton.saveBillAmount()
  }
  
  // Must remove notification observers before view goes away
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print("Tip view will disappear - remove observers")
    
    // removing notification observers
    NotificationCenter.default.removeObserver(self,
                                              name: .UIApplicationDidBecomeActive,
                                              object: nil)
    NotificationCenter.default.removeObserver(self,
                                              name: .UIApplicationWillResignActive,
                                              object: nil)
  }
}

