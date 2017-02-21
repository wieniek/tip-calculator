//
//  SettingsViewController.swift
//  tippy
//
//  Created by Home Mac on 19/02/2017.
//  Copyright © 2017 Home Mac. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBOutlet weak var tipSettingsControl: UISegmentedControl!
  
  @IBAction func setDefaultTip(_ sender: UISegmentedControl) {
    
    let defaultTipIndex = sender.selectedSegmentIndex
    print("\(defaultTipIndex)")
  }
  
  @IBAction func changeTipAmount(_ sender: UIButton) {
    
    let buttonTitle = sender.currentTitle
    let selectedSegment = tipSettingsControl.selectedSegmentIndex
    let title = tipSettingsControl.titleForSegment(at: selectedSegment)!
    
    let percent = Int(title.substring(to: title.index(before: title.endIndex)))!
    
    print("selected segment value is \(percent)%")
    
    if buttonTitle == "-" && percent > 1 {
      tipSettingsControl.setTitle("\(percent - 1)%" , forSegmentAt: selectedSegment)
    } else if percent < 99 {
      tipSettingsControl.setTitle("\(percent + 1)%" , forSegmentAt: selectedSegment)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("view will appear")
    
    tipSettingsControl.loadTitles()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print("view will disappear")
    
    var newTipPercentages = [Int]()
    
    for index in 0...2 {
      let title = tipSettingsControl.titleForSegment(at: index)!
      let percent = Int(title.substring(to: title.index(before: title.endIndex)))!
      newTipPercentages.append(percent)
    }
    
    let dataStore = DataStore()
    dataStore.saveSettings(tipPercentages: newTipPercentages, defaultPercentageIndex: tipSettingsControl.selectedSegmentIndex)
  }
}
