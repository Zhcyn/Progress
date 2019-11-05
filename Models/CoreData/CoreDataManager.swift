import UIKit
import CoreData
class CoreDataManager {
    static let sharedManager = CoreDataManager()
    private init() {}
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Progress")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func createGoal(name: String, hours: Int) {
        let entity = NSEntityDescription.entity(forEntityName: "Goal", in: context)
        guard let unwrappedEntity = entity else {
            print("FAILURE: entity unable to be unwrapped: \(String(describing: entity))")
            return
        }
        let object = Goal(entity: unwrappedEntity, insertInto: context)
        object.setValue(name, forKey: "title")
        object.setValue(hours, forKey: "totalSeconds")
        object.setValue(0, forKey: "currSeconds")
        saveContext()
    }
    func createTimestamp(time: Int, goal: Goal) {
        let entity = NSEntityDescription.entity(forEntityName: "Timestamps", in: context)
        guard let unwrappedEntity = entity else {
            print("FAILURE: entity unable to be unwrapped: \(String(describing: entity))")
            return
        }
        let currentDate = Date()
        let object = NSManagedObject(entity: unwrappedEntity, insertInto: context)
        object.setValue(time, forKey: "session")
        object.setValue(currentDate, forKey: "day")
        goal.addToTimestamps(object as! Timestamps)
        saveContext()
    }
    func fetchTimeStamps(goal: Goal) -> [Timestamps] {
        let arr = goal.timestamps
        var timeStampsArr = arr?.allObjects as! [Timestamps]
        timeStampsArr.sort(by: { $0.day?.compare($1.day! as Date) == .orderedDescending })
        return timeStampsArr
    }
    func fetchAllGoals() -> [Goal]? {
        var goalNameArr: [Goal] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Goal")
        do {
            goalNameArr = try context.fetch(fetchRequest) as! [Goal]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return goalNameArr
    }
    func removeItem( objectID: NSManagedObjectID ) {
        let obj = context.object(with: objectID)
        context.delete(obj)
    }
}
