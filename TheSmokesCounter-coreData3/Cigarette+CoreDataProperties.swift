//
//  Cigarette+CoreDataProperties.swift
//  TheSmokesCounter-coreData3
//
//  Created by Gilbert Andrei Floarea on 14/04/2019.
//  Copyright © 2019 Gilbert Andrei Floarea. All rights reserved.
//
//

import Foundation
import CoreData


extension Cigarette {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cigarette> {
        return NSFetchRequest<Cigarette>(entityName: "Cigarette")
    }

    @NSManaged public var brand: String?
    @NSManaged public var smokes: NSOrderedSet?

}

// MARK: Generated accessors for smokes
extension Cigarette {

    @objc(insertObject:inSmokesAtIndex:)
    @NSManaged public func insertIntoSmokes(_ value: Smoke, at idx: Int)

    @objc(removeObjectFromSmokesAtIndex:)
    @NSManaged public func removeFromSmokes(at idx: Int)

    @objc(insertSmokes:atIndexes:)
    @NSManaged public func insertIntoSmokes(_ values: [Smoke], at indexes: NSIndexSet)

    @objc(removeSmokesAtIndexes:)
    @NSManaged public func removeFromSmokes(at indexes: NSIndexSet)

    @objc(replaceObjectInSmokesAtIndex:withObject:)
    @NSManaged public func replaceSmokes(at idx: Int, with value: Smoke)

    @objc(replaceSmokesAtIndexes:withSmokes:)
    @NSManaged public func replaceSmokes(at indexes: NSIndexSet, with values: [Smoke])

    @objc(addSmokesObject:)
    @NSManaged public func addToSmokes(_ value: Smoke)

    @objc(removeSmokesObject:)
    @NSManaged public func removeFromSmokes(_ value: Smoke)

    @objc(addSmokes:)
    @NSManaged public func addToSmokes(_ values: NSOrderedSet)

    @objc(removeSmokes:)
    @NSManaged public func removeFromSmokes(_ values: NSOrderedSet)

}
