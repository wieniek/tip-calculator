//
//  TipCalculator.swift
//  tippy
//
//  Created by Home Mac on 19/02/2017.
//  Copyright © 2017 Home Mac. All rights reserved.
//

import Foundation

struct TipCalculator {
  
  func calculateTip(forBill bill: Double, withIndex index: Int) -> (total: Double, tip: Double) {
    
    //var dataStore = DataStore()
    DataStore.singleton.loadSettings()
    
    let tipPercetages = DataStore.singleton.tipPercentages
    
    let tip = bill * Double(tipPercetages[index]) * 0.01
    let total = bill + tip
    
    return (total, tip)
    
  }
}
