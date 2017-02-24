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
    //var dataStore = DataStore()
    
    //DataStore.singleton.loadSettings()
    
    for index in 0...2 {
      setTitle("\(DataStore.singleton.tipPercentages[index])%", forSegmentAt: index)
    }
    selectedSegmentIndex = DataStore.singleton.defaultPercentageIndex
  }
}
