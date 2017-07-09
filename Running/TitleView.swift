//
//  ViewController.swift
//  Running
//
//  Created by Debbie Neubieser on 6/8/17.
//  Copyright © 2017 Craig Neubieser. All rights reserved.
//

import UIKit

class TitleView: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        placeNameLabel.text = textField.text
    }
    
    @IBAction func setDefaultText(_ sender: UIButton) {
        placeNameLabel.text = "Default Text"
      }

}

