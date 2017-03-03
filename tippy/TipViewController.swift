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
      
      //let offset = view.bounds.height
      let offset = CGFloat(200)
      
      self.tipResultsView.isHidden = false
      
      if numberOfCharacters == 2 && tipResultsViewCenterY > 400 {
        
        self.tipResultsView.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
          self.tipResultsView.alpha = 1.0
          self.tipResultsView.center.y -= offset
        }, completion: { finished in print("End of amimation1")})
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
          let translate = CGAffineTransform(translationX: 75, y: -25)
          let translateAndScale = translate.scaledBy(x: 0.5, y: 0.5)
          self.billField.transform = translateAndScale
        }, completion: { finished in print("TIP VIEW CENTER1 = \(tipResultsViewCenterY)")})
        
        print("INITIAL AFT1 POSITION X = \(tipResultsView.center.x)")
        print("INITIAL AFT1 POSITION Y = \(tipResultsView.center.y)")
        print("INITIAL AFT1 POSITION FRAME ORIGIN X = \(tipResultsView.frame.origin.x)")
        print("INITIAL AFT1 POSITION FRAME ORIGIN Y = \(tipResultsView.frame.origin.y)")
        
      }
        
      else if numberOfCharacters == 1 && tipResultsViewCenterY < 400 {
        
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
          self.tipResultsView.alpha = 0.0
          self.tipResultsView.center.y += offset
        }, completion: { finished in print("End of amimation1")})
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
          let translate = CGAffineTransform(translationX: 0, y: 0)
          let translateAndScale = translate.scaledBy(x: 1, y: 1)
          self.billField.transform = translateAndScale
          
        }, completion: { finished in print("TIP VIEW CENTER2 = \(tipResultsViewCenterY)")})
        
        print("INITIAL AFT2 POSITION X = \(tipResultsView.center.x)")
        print("INITIAL AFT2 POSITION Y = \(tipResultsView.center.y)")
        print("INITIAL AFT2 POSITION FRAME ORIGIN X = \(tipResultsView.frame.origin.x)")
        print("INITIAL AFT2 POSITION FRAME ORIGIN Y = \(tipResultsView.frame.origin.y)")
        
        
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
    
    // If user deleted currency symbol, then put it back
    if billField.text! == "" {
      billField.text = DataStore.singleton.formatter.currencySymbol
    }
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
    billField.text = DataStore.singleton.billAmount
    
        print("Setting up VIEW POSITION")
        print("CHAR COUNT = \(billField.text!.characters.count)")
    
        // Set tip results view initial position
        if billField.text!.characters.count == 1 {
          //tipResultsView.center.y += view.bounds.height
          tipResultsView.center.x = CGFloat(187.5)
          tipResultsView.center.y = CGFloat(415)
    
          print("INITIAL 1 POSITION X = \(tipResultsView.center.x)")
          print("INITIAL 1 POSITION Y = \(tipResultsView.center.y)")
          print("INITIAL 1 POSITION FRAME ORIGIN X = \(tipResultsView.frame.origin.x)")
          print("INITIAL 1 POSITION FRAME ORIGIN Y = \(tipResultsView.frame.origin.y)")
    
    
        } else {
          tipResultsView.center.x = CGFloat(187.5)
          tipResultsView.center.y = CGFloat(215)
    
          print("INITIAL 2 POSITION X = \(tipResultsView.center.x)")
          print("INITIAL 2 POSITION Y = \(tipResultsView.center.y)")
          print("INITIAL 2 POSITION FRAME ORIGIN X = \(tipResultsView.frame.origin.x)")
          print("INITIAL 2 POSITION FRAME ORIGIN Y = \(tipResultsView.frame.origin.y)")
          
        }
    
    calculateTip(self)
    
  }
  
  // This method will be called by UIApplicationDidBecomeActive Notification
  // Check DataStore variable and clear Bill UI input field if needed
  // Otherwise load Bill UI input field value from storage
  @objc func checkBillField() {
    let clearBillAmount = DataStore.singleton.billAmountNeedsToBeReset
    print("Method called by notification - Clear Bill Amount is \(clearBillAmount)")
    if clearBillAmount {
      billField.text = DataStore.singleton.formatter.currencySymbol
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
    
    // preserve billAmount
    DataStore.singleton.billAmount = billField.text!
    
  }
}
