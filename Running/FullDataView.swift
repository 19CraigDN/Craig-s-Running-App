//
//  FullDataView.swift
//  Running
//
//  Created by Debbie Neubieser on 7/14/17.
//  Copyright © 2017 Craig Neubieser. All rights reserved.
//

import UIKit
import CoreData

class FullDataView: UIViewController {

    //var runs: [NSManagedObject] = []
    var run: NSManagedObject!
    
    @IBOutlet weak var distLabel: UILabel!
    //@IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thisRun = run as! Run
        let distance = Measurement(value: thisRun.distance, unit: UnitLength.meters)
        let formattedDistance = FormatDisplay.distance(distance)
        distLabel.text = "Distance:  \(formattedDistance)"
        /*
        title = "The List"
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
         */
    }
}
