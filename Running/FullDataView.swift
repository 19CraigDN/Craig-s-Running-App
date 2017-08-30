//
//  FullDataViewController2.swift
//  Running
//
//  Created by Debbie Neubieser on 8/3/17.
//  Copyright © 2017 Craig Neubieser. All rights reserved.
//

import UIKit
import CoreData

class FullDataView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var runs = [Run]()
    var newRuns = [Run]()
    var managedObjectContext: NSManagedObjectContext!

    @IBAction func clearPressed(_ sender: Any) {
        clearData()
        
        let runRequest:NSFetchRequest<Run> = Run.fetchRequest()
        
        do {
            runs = try managedObjectContext.fetch(runRequest)
            tableView.reloadData()
        } catch {
            print(" Could not clear data from database \(error.localizedDescription)")
        }
    }
    
    func clearData() {
        let runRequest:NSFetchRequest<Run> = Run.fetchRequest()
        
        do {
            runs = try managedObjectContext.fetch(runRequest)
            for object in runs {
                managedObjectContext.delete(object)
            }
            try managedObjectContext.save()
        }catch {
            print("Could not clear data from database \(error.localizedDescription)")
        }
    }

    @IBAction func distanceSortPressed(_ sender: Any) {
        newRuns = mergeSort(runs)
        saveRuns()
        
        let runRequest:NSFetchRequest<Run> = Run.fetchRequest()
        do{
            runs = try managedObjectContext.fetch(runRequest)

        }        catch {
            print("Could not load data from database \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    func saveRuns() {
        clearData()
        
        for thisRun in newRuns {
            let newRun = Run(context: managedObjectContext)
            newRun.distance = thisRun.distance
            newRun.duration = thisRun.duration
            newRun.timestamp = thisRun.timestamp
            
            /*let locationObject = Location(context: managedObjectContext)
            locationObject.timestamp = thisLocation.timestamp as NSDate
            locationObject.latitude = thisLocation.coordinate.latitude
            locationObject.longitude = thisLocation.coordinate.longitude*/
            newRun.addToLocation(thisRun.location!)
            
            do {
                try managedObjectContext.save()
            }
            catch {
                print("Could not save data \(error.localizedDescription)")
            }
        }
    }
    
    func mergeSort(_ array: [Run]) -> [Run] {
        guard array.count > 1 else {
            return array
        }
        
        let mid = array.count / 2
        
        let left = mergeSort(Array(array[0..<mid]))
        let right = mergeSort(Array(array[mid..<array.count]))
        
        return merge(left, right)
    }
    
    func merge(_ left: [Run], _ right: [Run]) -> [Run] {
        var leftIndex = 0
        var rightIndex = 0
        
        var orderedArray: [Run] = []
        
        while leftIndex < left.count && rightIndex < right.count {
            let leftElement = left[leftIndex].distance
            let rightElement = right[rightIndex].distance
            
            if leftElement < rightElement {
                orderedArray.append(left[leftIndex])
                leftIndex += 1
            } else if leftElement > rightElement {
                orderedArray.append(right[rightIndex])
                rightIndex += 1
            } else {
                orderedArray.append(left[leftIndex])
                leftIndex += 1
                orderedArray.append(right[rightIndex])
                rightIndex += 1
            }
        }
        
        while leftIndex < left.count {
            orderedArray.append(left[leftIndex])
            leftIndex += 1
        }
        
        while rightIndex < right.count {
            orderedArray.append(right[rightIndex])
            rightIndex += 1
        }
        
        return orderedArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        tableView.dataSource = self
        
        loadData()
    }
    
    func loadData() {
        let runRequest:NSFetchRequest<Run> = Run.fetchRequest()
        
        do {
            runs = try managedObjectContext.fetch(runRequest)
            tableView.reloadData()
        }catch {
            print("Could not load data from database \(error.localizedDescription)")
        }
    }
}

extension FullDataView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RunsTableViewCell
        
        let runItem = runs[indexPath.row]
        
        let distance = Measurement(value: runItem.distance, unit: UnitLength.meters)
        let seconds = Int(runItem.duration)
        let formattedDistance = FormatDisplay.distance(distance)
        let formattedDate = FormatDisplay.date(runItem.timestamp! as Date)
        let formattedTime = FormatDisplay.time(seconds)
        let formattedPace = FormatDisplay.pace(distance: distance,
                                               seconds: seconds,
                                               outputUnit: UnitSpeed.minutesPerMile)
        
        cell.distLabel.text = "Distance:  \(formattedDistance)"
        cell.dateLabel.text = formattedDate
        cell.timeLabel.text = "Time:  \(formattedTime)"
        cell.paceLabel.text = "Pace:  \(formattedPace)"
        
        return cell
    }
}
