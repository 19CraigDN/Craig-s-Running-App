//
//  ViewController2.swift
//  Running
//
//  Created by Debbie Neubieser on 6/14/17.
//  Copyright © 2017 Craig Neubieser. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    var timer = Timer()
    var counter = 0
    
    @IBOutlet var countingLabel: UILabel!
    @IBAction func clear(_ sender: UIBarButtonItem) {
    }
    
    func updateCounter() {
        countingLabel.text = String(describing: counter += 1)
    }
    @IBAction func play(_ sender: UIBarButtonItem) {
        timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(ViewController2.updateCounter), userInfo:nil, repeats:true)
    }
    @IBAction func pause(_ sender: UIBarButtonItem) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countingLabel.text = String(counter)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
