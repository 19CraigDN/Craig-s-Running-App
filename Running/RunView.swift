//
//  ViewController2.swift
//  Running
//
//  Created by Debbie Neubieser on 6/14/17.
//  Copyright © 2017 Craig Neubieser. All rights reserved.
//

import UIKit

let DetailSegueName = "RunDetails"

class ViewController2: UIViewController {

    private var run: Run?

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
                                     selector: #selector(ViewController2.eachSecond(timer:)),
                                                       userInfo: nil,
                                                       repeats: true)
        startLocationUpdates()
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Run Stopped", message: nil, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: self.saveHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }

    func saveHandler(alert: UIAlertAction!) {

        let viewController3 = ViewController3()
        viewController3.customInit(timeStr: timeLabel.text!, distStr: distanceLabel.text!,
                                   paceStr: paceLabel.text!)
        self.navigationController?.pushViewController(viewController3, animated: true)
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
    
}

extension ViewController2: SegueHandlerType {
    enum SegueIdentifier: String {
        case details = "ViewController3"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .details:
            let destination = segue.destination as! ViewController3
            destination.run = run
        }
    }
}
