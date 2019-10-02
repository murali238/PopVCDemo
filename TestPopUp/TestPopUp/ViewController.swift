//
//  ViewController.swift
//  TestPopUp
//
//  Created by Murali on 22/06/19.
//  Copyright © 2019 Murali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonSettings(_ sender: Any) {
        let popup : ServerSettingsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ServerSettingsViewController") as! ServerSettingsViewController
        
        let navigationController = UINavigationController(rootViewController: popup)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    
}

