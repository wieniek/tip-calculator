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
  
  var tipPercentages = [18, 20, 25] // predifined tip amounts for first app run
  let tipPercentagesKey = "tippy_tip_percentages03" // key value for user defaults database
  
  var defaultPercentageIndex = 0 // predefined for first app run
  let defaultPercentageIndexKey = "tippy_default_percentage_index03" // key value for user defaults database
  
  // converts provided parameters to text and saves them to user defaults
  func saveSettings(tipPercentages percentages: [Int], defaultPercentageIndex index: Int) {
    let defaults = UserDefaults.standard
    defaults.set(percentages.map { String($0) }, forKey: tipPercentagesKey)
    defaults.set(String(index), forKey: defaultPercentageIndexKey)
    defaults.synchronize()
  }
  
  // loads values from user defaults and converts them to numbers
  mutating func loadSettings() {
    let defaults = UserDefaults.standard
    if let array = defaults.stringArray(forKey: tipPercentagesKey) {
      print("Array from user defaults = \(array)")
      tipPercentages = array.map { Int($0)! }
    }
    if let value = defaults.string(forKey: defaultPercentageIndexKey) {
      print("String from user defaults = \(value)")
      defaultPercentageIndex = Int(value)!
    }
  }
}
