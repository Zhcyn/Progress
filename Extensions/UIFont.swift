import Foundation
import UIKit
extension UIFont {
    static let onboardTitleFont: UIFont = {
        let font = UIFont(name: "Avenir-Heavy", size: 30)
        return font ?? UIFont.systemFont(ofSize: 30)
    }()
    static let onboardDescriptionFont: UIFont = {
        let font = UIFont(name: "Avenir", size: 18)
        return font ?? UIFont.systemFont(ofSize: 18)
    }()
    static let goalTitleFont: UIFont = {
        let font = UIFont(name: "Avenir-Medium", size: 18)
        return font ?? UIFont.systemFont(ofSize: 18)
    }()
    static let goalDescriptionFont: UIFont = {
        let font = UIFont(name: "Avenir", size: 16)
        return font ?? UIFont.systemFont(ofSize: 16)
    }() 
    static let newGoalNameFont: UIFont = {
        let font = UIFont(name: "Avenir-Heavy", size: 20)
        return font ?? UIFont.systemFont(ofSize: 20)
    }()
    static let newGoalFieldFont: UIFont = {
        let font = UIFont(name: "Avenir-Medium", size: 18)
        return font ?? UIFont.systemFont(ofSize: 18)
    }()
}
