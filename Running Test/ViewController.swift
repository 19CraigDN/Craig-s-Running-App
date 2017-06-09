//
//  ViewController.swift
//  Running Test
//
//  Created by Debbie Neubieser on 6/5/17.
//  Copyright © 2017 Craig Neubieser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var placeNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: Actions
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        placeNameLabel.text = "Default Text"
    }
    
}

