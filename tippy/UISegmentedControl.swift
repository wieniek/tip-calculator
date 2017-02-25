//
//  UISegmentedControl.swift
//  tippy
//
//  Created by Home Mac on 21/02/2017.
//  Copyright © 2017 Home Mac. All rights reserved.
//

import UIKit

// Extend Segmented Control in order to reuse code
// loadTitles method can be called from different classes
extension UISegmentedControl {
  
  func loadTitles()  {
    
    for index in 0...2 {
      setTitle("\(DataStore.singleton.tipPercentages[index])%", forSegmentAt: index)
    }
    selectedSegmentIndex = DataStore.singleton.defaultPercentageIndex
  }
}
