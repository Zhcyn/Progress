import Foundation
import CoreData
extension Goal {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }
    @NSManaged public var currSeconds: Int64
    @NSManaged public var title: String?
    @NSManaged public var totalSeconds: Int64
    @NSManaged public var timestamps: NSSet?
}
extension Goal {
    @objc(addTimestampsObject:)
    @NSManaged public func addToTimestamps(_ value: Timestamps)
    @objc(removeTimestampsObject:)
    @NSManaged public func removeFromTimestamps(_ value: Timestamps)
    @objc(addTimestamps:)
    @NSManaged public func addToTimestamps(_ values: NSSet)
    @objc(removeTimestamps:)
    @NSManaged public func removeFromTimestamps(_ values: NSSet)
}
