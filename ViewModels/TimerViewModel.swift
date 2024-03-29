import Foundation
import UIKit
class TimerViewModel {
    var seconds = 0
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    func getTimeLabel() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        formatter.timeStyle = DateFormatter.Style.none
        return "\(formatter.string(from: date)) - \(timeString(time: TimeInterval(seconds)))"
    }
    func getSeconds() -> Int {
        return seconds
    }
}
