//
//  PhotoGroupDate+CoreDataProperties.swift
//  PicsGrouper
//
//  Created by SeungWoo on 2023/01/13.
//
//

import Foundation
import CoreData


extension PhotoGroupDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoGroupDate> {
        return NSFetchRequest<PhotoGroupDate>(entityName: "PhotoGroupDate")
    }

    @NSManaged public var date: String?

}

extension PhotoGroupDate : Identifiable {

}
