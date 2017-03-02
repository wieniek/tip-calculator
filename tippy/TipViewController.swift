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
  
  @IBOutlet weak var tipResultsView: UIView!
  
  // Calulated variable
  // Returns numerical value converted from input text field
  var billAmount: Double {
    get {
      
      let billText = billField.text ?? ""
      let amountText = billText.replacingOccurrences(of: DataStore.singleton.formatter.currencySymbol, with: "")
      return Double(amountText) ?? 0.0
    }
    set { }
  }
  // Set focus to the view and dismiss keyboard when tapped
  @IBAction func onTap(_ sender: AnyObject) {
    view.becomeFirstResponder()
    view.endEditing(true)
  }
  
  @IBAction func animateTipResultsView(_ sender: UITextField) {
    
    if let numberOfCharacters = billField.text?.characters.count {
      
      let tipResultsViewCenterY = Double(tipResultsView.center.y)
      let offset = view.bounds.height / 2
      
      if numberOfCharacters == 1 && tipResultsViewCenterY > 300 {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
          self.tipResultsView.center.y -= offset
        }, completion: { finished in print("End of amimation1")})
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
          let translate = CGAffineTransform(translationX: 75, y: -25)
          let translateAndScale = translate.scaledBy(x: 0.5, y: 0.5)
          self.billField.transform = translateAndScale
        }, completion: { finished in print("VIEW CENTER1 = \(tipResultsViewCenterY)")})
      }
        
      else if numberOfCharacters == 0 && tipResultsViewCenterY < 300 {
        
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
          self.tipResultsView.center.y += offset
        }, completion: { finished in print("End of amimation1")})
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
          
          let translate = CGAffineTransform(translationX: 0, y: 0)
          let translateAndScale = translate.scaledBy(x: 1, y: 1)
          self.billField.transform = translateAndScale
          
        }, completion: { finished in print("VIEW CENTER2 = \(tipResultsViewCenterY)")})
      }
    }
  }
  
  // Recalculate tip amount and total using provided values
  @IBAction func calculateTip(_ sender: AnyObject) {
    
    // Get user input
    let tipIndex = tipControl.selectedSegmentIndex
    
    // Use TipCalculator struct to calculate tip and total amount
    let calculator = TipCalculator()
    let result = calculator.calculateTip(forBill: billAmount, withIndex: tipIndex)
    
    // Display results
    tipLabel.text = DataStore.singleton.formatter.string(from: NSNumber(value: result.tip))
    totalLabel.text = DataStore.singleton.formatter.string(from: NSNumber(value: result.total))
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
    
    //Animation part
    tipResultsView.center.y += view.bounds.height
    
    //Setup UISegmentedControl properties
    tipControl.loadTitles()
    
    //Initialize input field with locale currency symbol
    billField.text = DataStore.singleton.formatter.currencySymbol
    
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
