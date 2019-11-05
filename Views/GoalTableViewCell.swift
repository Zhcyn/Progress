import UIKit
class GoalTableViewCell: UITableViewCell, UITextViewDelegate {
    static let identifier = "goalTableID"
    private var cellTextView = UITextView()
    var cellView = UIView()
    var cellLabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellView = createCellView()
        cellLabel = createCellLabel()
        cellTextView = createTextView()
        cellView.addSubview(cellLabel)
        cellView.addSubview(cellTextView)
        addSubview(cellView)
        cellViewConstraints()
        cellLabelConstraints()
        textViewConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        cellView.backgroundColor = selected ? #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1) : #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        cellTextView.backgroundColor = selected ? #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1) : #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    }
    private func createCellView() -> UIView {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return view
    }
    private func createCellLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.goalTitleFont
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }
    private func createTextView() -> UITextView {
        let view = UITextView()
        let actionArr = ["Be honest rather clever.","Believe not all that you see nor half what you hear.","Be swift to hear, slow to speak.","Bind the sack before it be full.","Business before pleasure.","I feel strongly that I can make it.","The shortest answer is doing.","Four short words sum up what has lifted most successful individuals above the crowd: a little bit more.","All things in their being are good for something.","None is of freedom or of life deserving unless he daily conquers it anew. -Erasmus","Our destiny offers not the cup of despair, but the chalice of opportunity. So let us seize it, not in fear, but in gladness. -- R.M. Nixon","Living without an aim is like sailing without a compass. -- John Ruskin","What makes life dreary is the want of motive. -- George Eliot"];
        let randomNumber:Int = Int(arc4random() % 13)
        view.text = actionArr[randomNumber]
        view.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.layer.cornerRadius = 25
        view.font = UIFont.goalDescriptionFont
        view.isScrollEnabled = false
        view.isUserInteractionEnabled = false
        view.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return view
    }
    private func cellViewConstraints() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            cellView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            cellView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cellView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    private func cellLabelConstraints() {
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellLabel.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.9),
            cellLabel.heightAnchor.constraint(equalTo: cellView.heightAnchor, multiplier: 0.4),
            cellLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            cellLabel.topAnchor.constraint(equalTo: cellView.topAnchor)
        ])
    }
    private func textViewConstraints() {
        cellTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellTextView.heightAnchor.constraint(equalTo: cellView.heightAnchor, multiplier: 0.6),
            cellTextView.widthAnchor.constraint(equalTo: cellView.widthAnchor),
            cellTextView.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            cellTextView.topAnchor.constraint(equalTo: cellLabel.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
