import Foundation
import UIKit
class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navController = navigationController
    }
    func onboard() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        navController.delegate = self
        let vc = OnboardViewController(collectionViewLayout: layout)
        vc.coordinator = self
        navController.pushViewController(vc, animated: true)
    }
    func start() {
        navController.delegate = self
        let vc = HomeViewController()
        vc.coordinator = self
        navController.pushViewController(vc, animated: true)
    }
    func createNewGoal() {
        let vc = NewGoalViewController()
        vc.coordinator = self
        navController.pushViewController(vc, animated: true)
    }
    func goToDetailScreen(goal: Goal) {
        let vc = DetailViewController()
        vc.coordinator = self
        vc.goal = goal
        navController.pushViewController(vc, animated: true)
    }
}
