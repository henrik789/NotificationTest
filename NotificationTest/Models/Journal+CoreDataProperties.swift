//
//  Journal+CoreDataProperties.swift
//  NotificationTest
//
//  Created by Henrik on 2019-09-19.
//  Copyright © 2019 Henrik. All rights reserved.
//
//

import Foundation
import CoreData


extension Journal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Journal> {
        return NSFetchRequest<Journal>(entityName: "Journal")
    }

    @NSManaged public var dailyNote: String?

}
