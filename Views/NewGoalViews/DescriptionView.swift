import UIKit
class DescriptionView: UIStackView {
    var descriptionLabel = UILabel()
    var descriptionView = UITextView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit() {
        createStack()
        descriptionLabel = createDescriptionLabel()
        descriptionView = createDescriptionView()
        self.addArrangedSubview(descriptionLabel)
        self.addArrangedSubview(descriptionView)
    }
    private func createStack() {
        axis = .vertical
        distribution = .fill
        alignment = .fill
        spacing = 0
    }
    private func createDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.text = "Goal Description"
        label.font = UIFont.newGoalNameFont
        return label
    }
    private func createDescriptionView() -> UITextView {
        let view = UITextView()
        view.font = UIFont.newGoalFieldFont
        view.text = "Placeholder..."
        view.textColor = .lightGray
        return view
    }
    func textLabelConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4)
        ])
    }
}
