//
//  UISegmentedControl.swift
//  tippy
//
//  Created by Home Mac on 21/02/2017.
//  Copyright © 2017 Home Mac. All rights reserved.
//

import UIKit

extension UISegmentedControl {
  
  func loadTitles()  {
    var dataStore = DataStore()
    dataStore.loadSettings()
    
    for index in 0...2 {
      setTitle("\(dataStore.tipPercentages[index])%", forSegmentAt: index)
    }
    selectedSegmentIndex = dataStore.defaultPercentageIndex
  }
}
