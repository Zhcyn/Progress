import UIKit
enum TextType {
    case goalName
    case goalHours
    case goalDescription
}
class NewGoalViewController: UIViewController {
    weak var coordinator: Coordinator?
    private let newGoalView = NewGoalView()
    private var textType: TextType = .goalName
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotifications()
        setupView()
    }
    private func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        let uiComponents = [newGoalView.goalNameField.formField.textField, newGoalView.goalHourField.formField.textField]
        view.addGestureRecognizer(tapGesture)
        navigationItem.title = "New Goal"
        view.addSubview(newGoalView)
        newGoalView.frame = view.frame
        newGoalView.defaultButton.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        uiComponents.forEach({$0.addTarget(self, action: #selector(editingChanged), for: .editingChanged)})
        newGoalView.goalNameField.formField.textField.delegate = self
        newGoalView.goalHourField.formField.textField.delegate = self
        newGoalView.goalDescriptionField.descriptionView.delegate = self
        newGoalView.goalHourField.formField.textField.keyboardType = .asciiCapableNumberPad
    }
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func createGoal() {
        guard let goalName = newGoalView.goalNameField.formField.textField.text,
            let goalHours = newGoalView.goalHourField.formField.textField.text else { return }
        let shouldPresentError = newGoalView.viewModel.checkHourStringError(hourString: goalHours)
        if shouldPresentError {
            newGoalView.goalHourField.formLine.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            newGoalView.errorLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            newGoalView.viewModel.addGoal(name: goalName, hourString: goalHours)
            navigationController?.popViewController(animated: true)
        }
    }
    @objc func createTapped() {
        createGoal()
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if textType == .goalHours {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= (keyboardSize.height/2)
                }
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    @objc func editingChanged(textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        if textField == newGoalView.goalHourField.formField.textField {
            newGoalView.errorLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        guard
            let nameField = newGoalView.goalNameField.formField.textField.text,
            let hourField = newGoalView.goalHourField.formField.textField.text,
            !nameField.isEmpty, !hourField.isEmpty
        else {
            newGoalView.defaultButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            newGoalView.defaultButton.isEnabled = false
            return
        }
        newGoalView.defaultButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        newGoalView.defaultButton.isEnabled = true
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("errorVC dismissed"), object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
extension NewGoalViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == newGoalView.goalNameField.formField.textField {
            newGoalView.goalNameField.formField.textField.resignFirstResponder()
            newGoalView.goalHourField.formField.textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == newGoalView.goalNameField.formField.textField {
            let line = newGoalView.goalNameField.formLine
            newGoalView.highlightLine(line: line)
            textType = .goalName
        } else if textField == newGoalView.goalHourField.formField.textField {
            let line = newGoalView.goalHourField.formLine
            newGoalView.highlightLine(line: line)
            textType = .goalHours
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == newGoalView.goalNameField.formField.textField {
            let line = newGoalView.goalNameField.formLine
            newGoalView.unhighlightLine(line: line)
        } else if textField == newGoalView.goalHourField.formField.textField {
            let line = newGoalView.goalHourField.formLine
            newGoalView.unhighlightLine(line: line)
        }
    }
}
extension NewGoalViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Beginning")
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("Ending")
        if textView.text.isEmpty {
            textView.textColor = .lightGray
            textView.text = "Placeholder..."
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        print("changed")
    }
}
