import Foundation
import UIKit
class NewGoalViewModel {
    func checkHourStringError(hourString: String) -> Bool {
        guard let hours = Int(hourString) else { return true }
        return hours <= 0 ? true : false
    }
    func addGoal(name: String, hourString: String) {
        guard var goalHours = Int(hourString) else { return }
        goalHours = goalHours * 3600
        CoreDataManager.sharedManager.createGoal(name: name, hours: goalHours)
    }
}
