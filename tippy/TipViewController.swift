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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onTap(_ sender: AnyObject) {
    view.endEditing(true)
  }
  
  @IBAction func calculateTip(_ sender: AnyObject) {
    
    let bill = Double(billField.text!) ?? 0
    let tipIndex = tipControl.selectedSegmentIndex
    let calculator = TipCalculator()
    let result = calculator.calculateTip(forBill: bill, withIndex: tipIndex)
    tipLabel.text = String(format: "$%.2f", result.tip)
    totalLabel.text = String(format: "$%.2f", result.total)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("view will appear")
    tipControl.loadTitles()
    
    billField.becomeFirstResponder()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print("view did appear")
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print("view will disappear")
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    print("view did disappear")
  }
}

