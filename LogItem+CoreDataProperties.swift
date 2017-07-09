//
//  LogItem+CoreDataProperties.swift
//  Running
//
//  Created by Debbie Neubieser on 7/8/17.
//  Copyright © 2017 Craig Neubieser. All rights reserved.
//

import Foundation
import CoreData


extension LogItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LogItem> {
        return NSFetchRequest<LogItem>(entityName: "LogItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var itemText: String?

}
