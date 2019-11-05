import UIKit
class NoGoalsHomeView: UIView {
    private var emptyStateLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        emptyStateLabel = createEmptyStateLabel()
        self.addSubview(emptyStateLabel)
        labelConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createEmptyStateLabel() -> UILabel {
        let label = UILabel()
        label.text = "Get started with a new goal!"
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 25)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }
    private func labelConstraints() {
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyStateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emptyStateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        emptyStateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        emptyStateLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
