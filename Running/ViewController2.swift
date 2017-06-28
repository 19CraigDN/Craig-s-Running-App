//
//  ViewController2.swift
//  Running
//
//  Created by Debbie Neubieser on 6/14/17.
//  Copyright © 2017 Craig Neubieser. All rights reserved.
//

import UIKit
/*
import CoreLocation
import HealthKit
import CoreData

let DetailSegueName = "RunDetails"
*/
class ViewController2: UIViewController {
/*
    var managedObjectContext: NSManagedObjectContext?
    
    var timer = Timer()
    var seconds = 0.0
    var distance = 0.0
    
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.activityType = .fitness
        
        _locationManager.distanceFilter = 10.0
        return _locationManager
    }()
    
    lazy var locations = [CLLocation]()
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var paceLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
    @IBAction func startPressed(_ sender: UIButton) {
        startButton.isHidden = true
        
        timeLabel.isHidden = false
        distanceLabel.isHidden = false
        paceLabel.isHidden = false
        stopButton.isHidden = false
        
        seconds = 0.0
        distance = 0.0
        locations.removeAll(keepingCapacity: false)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                                       selector: Selector(("eachSecond:")),
                                                       userInfo: nil,
                                                       repeats: true)
        startLocationUpdates()
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
    }
    
    func eachSecond(timer: Timer){
        seconds += 1
        let secondsQuantity = HKQuantity(unit: HKUnit.second(), doubleValue: seconds)
        timeLabel.text = "Time: " + secondsQuantity.description
        let distanceQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: distance)
        distanceLabel.text = "Distance: " + distanceQuantity.description
        
        let paceUnit = HKUnit.second().unitDivided(by: HKUnit.meter())
        let paceQuantity = HKQuantity(unit: paceUnit, doubleValue: seconds / distance)
        paceLabel.text = "Pace: " + paceQuantity.description
    }
    
    func startLocationUpdates() {
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startButton.isHidden = false
        
        timeLabel.isHidden = true
        distanceLabel.isHidden = true
        paceLabel.isHidden = true
        stopButton.isHidden = true
        
        locationManager.requestAlwaysAuthorization()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 
*/
}
/*
extension ViewController2: CLLocationManagerDelegate{
}
*/
