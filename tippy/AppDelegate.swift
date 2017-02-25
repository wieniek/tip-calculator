//
//  AppDelegate.swift
//  tippy
//
//  Created by Home Mac on 18/02/2017.
//  Copyright © 2017 Home Mac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
 
    // Load application settings from user defaults
    // If settings not found in user defaults then assume initial app defaults
    print("Application Did Finish Launching - Load settings from user defaults")
    DataStore.singleton.loadSettings()
    print("Application Did Finish Launching - Load Bill Amount from user defaults")
    DataStore.singleton.billAmount = DataStore.singleton.loadBillAmount()
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    print("Application Will Resign Active - Save current time to user defaults")
    DataStore.singleton.saveDateTime()
    print("Application Will Resign Active - Save settings to user defaults")
    DataStore.singleton.saveSettings()
    
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    print("Application Did Become Active - Load time from defaults and compare with current time")
    let currentDateTime = Date()
    let timeoutDateTime = DataStore.singleton.loadDateTime().addingTimeInterval(30)
    print("TimeOut DateTime is = \(timeoutDateTime))")
    
    if timeoutDateTime < currentDateTime {
      print("Timeout has been reached, set billAmountNeedsToBeReset true")
      DataStore.singleton.billAmountNeedsToBeReset = true
    }
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
}

