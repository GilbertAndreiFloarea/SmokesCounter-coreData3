//
//  Smoke+CoreDataProperties.swift
//  TheSmokesCounter-coreData3
//
//  Created by Gilbert Andrei Floarea on 14/04/2019.
//  Copyright © 2019 Gilbert Andrei Floarea. All rights reserved.
//
//

import Foundation
import CoreData


extension Smoke {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Smoke> {
        return NSFetchRequest<Smoke>(entityName: "Smoke")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var cigarette: Cigarette?

}
