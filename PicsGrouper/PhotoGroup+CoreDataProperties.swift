//
//  PhotoGroup+CoreDataProperties.swift
//  PicsGrouper
//
//  Created by SeungWoo on 2023/01/13.
//
//

import Foundation
import CoreData


extension PhotoGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoGroup> {
        return NSFetchRequest<PhotoGroup>(entityName: "PhotoGroup")
    }

    @NSManaged public var title: String?
    @NSManaged public var update: Date?
    @NSManaged public var date: String?
    @NSManaged public var pictures: [Data]

}

extension PhotoGroup : Identifiable {

}
