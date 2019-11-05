import UIKit
import CoreData
class HomeViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    private let viewModel = HomeViewModel()
    private var goalTableView = UITableView()
    private var newGoalButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Goals"
        navigationItem.hidesBackButton = true
        updateTableView()
    }
    private func setupView() {
        newGoalButton = createNewGoalBtn()
        view.addSubview(newGoalButton)
        buttonConstraints()
        setTableView()
        viewModel.goalsArr = viewModel.populateGoalList()
    }
    private func updateTableView() {
        viewModel.goalsArr = viewModel.populateGoalList()
        goalTableView.reloadData()
        configTableView()
    }
    private func configTableView() {
        if viewModel.goalsArr.isEmpty {
            let noGoalsView = NoGoalsHomeView(frame: goalTableView.frame)
            noGoalsView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            goalTableView.backgroundView = noGoalsView
        } else {
            goalTableView.backgroundView = nil
        }
        goalTableView.separatorStyle = .none
    }
    private func setTableView() {
        goalTableView.register(GoalTableViewCell.self, forCellReuseIdentifier: GoalTableViewCell.identifier)
        goalTableView.dataSource = self
        goalTableView.delegate = self
        goalTableView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        view.addSubview(goalTableView)
        tableConstraints()
    }
    private func createNewGoalBtn() -> UIButton {
        let button = UIButton()
        button.setTitle("NEW", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.layer.cornerRadius = 25
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .highlighted)
        button.addTarget(self, action: #selector(newGoalTapped), for: .touchUpInside)
        button.layer.shadowColor = #colorLiteral(red: 0.5105954409, green: 0.5106848478, blue: 0.5105836391, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 3
        return button
    }
    private func buttonConstraints() {
        newGoalButton.translatesAutoresizingMaskIntoConstraints = false
        newGoalButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        newGoalButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        newGoalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newGoalButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    private func tableConstraints() {
        goalTableView.translatesAutoresizingMaskIntoConstraints = false
        goalTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        goalTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        goalTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        goalTableView.bottomAnchor.constraint(equalTo: newGoalButton.topAnchor).isActive = true
    }
}
extension HomeViewController {
    @objc func newGoalTapped() {
        coordinator?.createNewGoal()
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let goalToPass = viewModel.goalsArr[indexPath.row]
        coordinator?.goToDetailScreen(goal: goalToPass)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                guard let resultList = self.viewModel.deleteGoal(indexPath: indexPath, goalList: self.viewModel.goalsArr) else { return }
                self.viewModel.goalsArr = resultList
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
            alert.addAction(okAction)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        configTableView()
        return viewModel.goalsArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellString = viewModel.getCellString(indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: GoalTableViewCell.identifier, for: indexPath) as! GoalTableViewCell
        cell.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        cell.selectionStyle = .none
        cell.cellLabel.text = cellString
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height * 0.197
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.bounds.height * 0.01
    }
}
