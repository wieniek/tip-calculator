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
    

  @IBAction func setDefaultTip(_ sender: UISegmentedControl) {
    

    let tipPercetages = [0.18, 0.2, 0.25]
    let defaultPercentage = tipPercetages[sender.selectedSegmentIndex]
    print("Selected Default % = \(defaultPercentage)")
    
    let defaults = UserDefaults.standard
    //defaults.set("some_string_to_save", forKey: "some_key_that_you_choose")
    defaults.set(defaultPercentage, forKey: "tippy_default_percentage")
    defaults.synchronize()
    
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
