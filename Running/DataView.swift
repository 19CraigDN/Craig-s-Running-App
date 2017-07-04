//
//  ViewController3.swift
//  Running
//
//  Created by Debbie Neubieser on 6/27/17.
//  Copyright © 2017 Craig Neubieser. All rights reserved.
//

import UIKit
import MapKit

class ViewController3: UIViewController {
    
    var run: Run!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    
    var timeStr: String?
    var distStr: String?
    var paceStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = timeStr
        distanceLabel.text = distStr
        paceLabel.text = paceStr
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customInit(timeStr: String, distStr: String, paceStr: String){
        self.timeStr = timeStr
        self.distStr = distStr
        self.paceStr = paceStr
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
