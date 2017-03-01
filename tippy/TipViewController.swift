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
  
  
  @IBOutlet weak var billView: UIView!
  
  
  
  @IBOutlet weak var tipResultsView: UIView!
  
  // Set focus to the view and dismiss keyboard when tapped
  @IBAction func onTap(_ sender: AnyObject) {
    view.becomeFirstResponder()
    view.endEditing(true)
  }
  
  // Function setAnchorPoint adjusts CALayer's position to account for new anchorPoint
  // Source: stackoverflow.com
  // Question: Changing my CALayer's anchorPoint moves the view
  // http://stackoverflow.com/questions/1968017/changing-my-calayers-anchorpoint-moves-the-view
  
  func setAnchorPoint(anchorPoint point: CGPoint, forView view: UIView) {
    
    var newPoint = CGPoint(x: view.bounds.size.width * point.x, y: view.bounds.size.height * point.y)
    
    var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)
    
    newPoint = __CGPointApplyAffineTransform(newPoint, view.transform)
    
    oldPoint = __CGPointApplyAffineTransform(oldPoint, view.transform)
    
    var position = view.layer.position
 
    position.x -= oldPoint.x
    position.x += newPoint.x
    
    position.y -= oldPoint.y
    position.y += newPoint.y
    
    view.layer.position = position
    view.layer.anchorPoint = point
  }
  
  func correctLayerPosition() {
    
    //correct layer possition
    var position = billView.layer.position
    let anchorPoint = billView.layer.anchorPoint
    let bounds = billView.bounds
    position.x = (0.5 * bounds.size.width) + (anchorPoint.x - 0.5) * bounds.size.width
    position.y = (0.5 * bounds.size.height) + (anchorPoint.y - 0.5) * bounds.size.height
    billView.layer.position = position
    
  }
  
  @IBAction func animateTipResultsView(_ sender: UITextField) {
    
    if let numberOfCharacters = billField.text?.characters.count {
      
      let tipResultsViewCenterY = Double(tipResultsView.center.y)
      let offset = view.bounds.height
      
      //print("TEXT LENGHT = \(numberOfCharacters)")
      //print("VIEW CENTER = \(tipResultsViewCenterY)")
      
      if numberOfCharacters == 1 && tipResultsViewCenterY > 300 {
        
        UIView.animate(withDuration: 5.0, delay: 0.0, options: .curveEaseOut, animations: {
          self.tipResultsView.center.y -= offset
        }, completion: { finished in print("End of amimation1")})
        
        let duration = 5.0
        let delay = 0.0
        let options = UIViewKeyframeAnimationOptions.calculationModeLinear
        let point = CGPoint(x: 0, y: 0)
        
        UIView.animateKeyframes(withDuration: duration, delay: delay, options: options, animations: {
//          UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
//            self.billField.center.x += point.x
//            self.billField.center.y -= point.y })
          
          UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
            //self.billView.layer.anchorPoint = CGPoint(x: 0, y: 1)
            
            //correct layer possition
//            var position = self.billView.layer.position
//            
//            print("POSITION1 = \(position)")
//            
//            let anchorPoint = self.billView.layer.anchorPoint
//            let bounds = self.billView.bounds
//            position.x = (0.5 * bounds.size.width) + (anchorPoint.x - 0.5) * bounds.size.width
//            position.y = (0.5 * bounds.size.height) + (anchorPoint.y - 0.5) * bounds.size.height
//            
//            print("POSITION2 = \(position)")
            
            //self.billView.layer.position = CGPoint(x: 280, y: 110)
            //self.billView.layer.position = CGPoint(x: 128.5, y: 56.5) //position
            
            
            //self.setAnchorPoint(anchorPoint: CGPoint(x: 0, y: 0), forView: self.billView)
            //let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)})
            let translate = CGAffineTransform(translationX: 50, y: 0)
            let translateAndScale = translate.scaledBy(x: 0.5, y: 0.5)
            self.billView.transform = translateAndScale })
          
        }, completion: {finished in })
      }
        
      else if numberOfCharacters == 0 && tipResultsViewCenterY < 300 {
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
          self.tipResultsView.center.y += offset
        }, completion: { finished in print("End of amimation1")})
        
        let duration = 2.0
        let delay = 0.0
        let options = UIViewKeyframeAnimationOptions.calculationModeLinear
        let point = CGPoint(x: 20, y: 20)
        
        UIView.animateKeyframes(withDuration: duration, delay: delay, options: options, animations: {
          
          UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
            self.billField.center.x += point.x
            self.billField.center.y += point.y })
          
          UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
            self.billField.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)})
          
          UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
            self.billField.center.x += point.x
            self.billField.center.y += point.y })
          
        }, completion: {finished in })
      }
    }
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
    
    //Animation part
    tipResultsView.center.y += view.bounds.height
    
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
  
  
  override func viewDidAppear(_ animated: Bool) {
    
    UIView.animate(withDuration: 3.0, delay: 2.0, options: .curveEaseOut, animations: {
      
      //Animation part
      //self.tipResultsView.center.y -= self.view.bounds.height
      
      
      //self.tipResultsView.transform = CGAffineTransform(translationX: -20, y: +50)
      //self.billField.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }, completion: { finished in print("End of amimation1")})
    
    //    UIView.animate(withDuration: 1.0, delay: 3.0, options: .curveEaseOut, animations: {
    //      self.billField.transform = CGAffineTransform(translationX: +20, y: -50)
    //      //self.billField.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    //    }, completion: { finished in print("End of amimation")})
  }
}
