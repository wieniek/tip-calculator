//
//  SettingsViewController.swift
//  tippy
//
//  Created by Home Mac on 19/02/2017.
//  Copyright © 2017 Home Mac. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

  @IBOutlet weak var tipSettingsControl: UISegmentedControl!
  
  // Called when one of the [+] [-] buttons is pressed
  // Changes tip amount at the selected segment
  @IBAction func changeTipAmount(_ sender: UIButton) {
    
    let buttonTitle = sender.currentTitle
    let selectedSegment = tipSettingsControl.selectedSegmentIndex
    let title = tipSettingsControl.titleForSegment(at: selectedSegment)!
    
    // Convert text to number
    let percent = Int(title.substring(to: title.index(before: title.endIndex)))!
    
    if buttonTitle == "⊖" && percent > 1 {
      tipSettingsControl.setTitle("\(percent - 1)%" , forSegmentAt: selectedSegment)
    } else if percent < 99 {
      tipSettingsControl.setTitle("\(percent + 1)%" , forSegmentAt: selectedSegment)
    }
  }
  
  // Load precentages before view appears
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tipSettingsControl.loadTitles()
  }
  
  // Save values to DataStore before view is dismissed
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    var newTipPercentages = [Int]()
    
    for index in 0...2 {
      let title = tipSettingsControl.titleForSegment(at: index)!
      let percent = Int(title.substring(to: title.index(before: title.endIndex)))!
      newTipPercentages.append(percent)
    }
    DataStore.singleton.tipPercentages = newTipPercentages
    DataStore.singleton.defaultPercentageIndex = tipSettingsControl.selectedSegmentIndex
  }
}
