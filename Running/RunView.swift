//
//  ViewController2.swift
//  Running
//
//  Created by Debbie Neubieser on 6/14/17.
//  Copyright © 2017 Craig Neubieser. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class RunView: UIViewController {
    
    fileprivate var run: NSManagedObject?
    var managedObjectContext: NSManagedObjectContext!
    
    fileprivate let locationManager = LocationManager.shared
    fileprivate var seconds = 0
    fileprivate var timer: Timer?
    fileprivate var distance = Measurement(value: 0, unit: UnitLength.meters)
    fileprivate var locationList: [CLLocation] = []
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // Transition functions
    
    @IBAction func pastDataTapped(_ sender: Any) {
        self.performSegue(withIdentifier: .pastDetails, sender: nil)
    }
    
    @IBAction func startTapped(_ sender: Any) {
        startRun()
    }
    
    @IBAction func stopTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "End run?",
                                                message: "Do you wish to end your run?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            self.stopRun()
            self.saveRun()
            self.performSegue(withIdentifier: .details, sender: nil)
        })
        alertController.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
            self.stopRun()
            _ = self.navigationController?.popToRootViewController(animated: true)
        })
        
        present(alertController, animated: true)
    }
    
    // Actual functions
    
    fileprivate func startRun() {
        startButton.isHidden = true
        stopButton.isHidden = false
        timeLabel.isHidden = false
        distanceLabel.isHidden = false
        paceLabel.isHidden = false
        
        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        updateDisplay()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSecond()
        }
        startLocationUpdates()
    }
    
    fileprivate func stopRun() {
        startButton.isHidden = false
        stopButton.isHidden = true
        timeLabel.isHidden = false
        distanceLabel.isHidden = false
        paceLabel.isHidden = false
        
        locationManager.stopUpdatingLocation()
    }
    
    func eachSecond() {
        seconds += 1
        updateDisplay()
    }
    
    fileprivate func updateDisplay() {
        let formattedDistance = FormatDisplay.distance(distance)
        let formattedTime = FormatDisplay.time(seconds)
        let formattedPace = FormatDisplay.pace(distance: distance,
                                               seconds: seconds,
                                               outputUnit: UnitSpeed.minutesPerMile)
        
        distanceLabel.text = "Distance:  \(formattedDistance)"
        timeLabel.text = "Time:  \(formattedTime)"
        paceLabel.text = "Pace:  \(formattedPace)"
    }
    
    fileprivate func startLocationUpdates() {
        locationManager.delegate = self
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }
    
    fileprivate func saveRun() {
        let newRun = Run(context: managedObjectContext)
        
        newRun.distance = distance.value
        newRun.duration = Int16(seconds)
        newRun.timestamp = Date() as NSDate
        
        for location in locationList {
            let locationObject = Location(context: managedObjectContext)
            locationObject.timestamp = location.timestamp as NSDate
            locationObject.latitude = location.coordinate.latitude
            locationObject.longitude = location.coordinate.longitude
            newRun.addToLocation(locationObject)
        }
        
        do {
            try self.managedObjectContext.save()
        }
        catch {
            print("Could not save data \(error.localizedDescription)")
        }
        
        run = newRun
    }
    
    // State functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        locationManager.stopUpdatingLocation()
    }
    
}

// Extensions

extension RunView: SegueHandlerType {
    enum SegueIdentifier: String {
        case details = "DataView"
        case pastDetails = "FullDataView"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .details:
            let destination = segue.destination as! DataView
            destination.run = run
        case .pastDetails:
            return
//            let destination = segue.destination as! FullDataView
//            destination.run = run
        }
    }
}

extension RunView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
            
            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
            }
            
            locationList.append(newLocation)
        }
    }
}
