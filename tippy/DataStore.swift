//
//  DataStore.swift
//  tippy
//
//  Created by Home Mac on 20/02/2017.
//  Copyright © 2017 Home Mac. All rights reserved.
//

import Foundation

// DataStore provides persisten storage of default tip amounts to user defaults
struct DataStore {
  
  static var singleton = DataStore() // singleton
  
  var billAmountNeedsToBeReset = false
  let dateTimeKey = "tippy_date_time_07"
  
  var tipPercentages = [18, 20, 25] // predifined tip amounts for first app run
  let tipPercentagesKey = "tippy_tip_percentages07" // key value for user defaults database
  
  var defaultPercentageIndex = 0 // predefined for first app run
  let defaultPercentageIndexKey = "tippy_default_percentage_index07" // key value for user defaults database
  
  // converts provided parameters to text and saves them to user defaults
  func saveSettings() {
    let defaults = UserDefaults.standard
    defaults.set(tipPercentages.map { String($0) }, forKey: tipPercentagesKey)
    defaults.set(String(defaultPercentageIndex), forKey: defaultPercentageIndexKey)
    defaults.synchronize()
  }
  
  // loads settings from user defaults and converts them to numbers
  mutating func loadSettings() {
    let defaults = UserDefaults.standard
    if let array = defaults.stringArray(forKey: tipPercentagesKey) {
      //print("Array from user defaults = \(array)")
      tipPercentages = array.map { Int($0)! }
    }
    if let value = defaults.string(forKey: defaultPercentageIndexKey) {
      //print("String from user defaults = \(value)")
      defaultPercentageIndex = Int(value)!
    }
  }
  
  func saveDateTime() {
    let currentDateTime = Date()
    print("Save DateTime to user defaults, value is \(currentDateTime)")
    
    let defaults = UserDefaults.standard
    defaults.set(currentDateTime, forKey: dateTimeKey)
    defaults.synchronize()
    
  }
  
  func loadDateTime() -> Date {
    
    let defaults = UserDefaults.standard
    if let savedDateTime = defaults.object(forKey: dateTimeKey) as? Date {
      print("Load DateTime from user defaults, value is \(savedDateTime)")
      return savedDateTime
    } else {
      let currentDateTime = Date()
      print("Load DateTime from user defaults, not found, set to \(currentDateTime)")
      return currentDateTime
    }
  }
}





