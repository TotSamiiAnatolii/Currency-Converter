//
//  ViewKeyBoard.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

final class ViewKeyBoard: UIView {
    
    //MARK: Properties
    private var target: (UIKeyInput & UITextInput)?
    
    private var timer = Timer()
    
    private var numeralsButtonArray: [UIButton] = []
    
    private let indentForLayout: CGFloat = 20
    
    private let indentBottom: CGFloat = 10
    
    private var lastButton: UIButton?
    
    private  var currentButton: UIButton?
    
    private let containerView = UIView()
        .setStyle()
        .setRoundCorners(radius: 20)
        .setShadows(
            color: Colors.shadow,
            width: 0.1,
            height: 1,
            radius: 2,
            opacity: 4)
    
    private let lastStackView = UIStackView()
        .myStyleStack(
            spacing: AppDesign.spacingBetweenButtons,
            alignment: .fill,
            axis: .horizontal,
            distribution: .fillEqually,
            userInteraction: true)
    
    private let mainStackView = UIStackView()
        .myStyleStack(
            spacing: 7,
            alignment: .fill,
            axis: .vertical,
            distribution: .fillEqually,
            userInteraction: true)
        .setLayoutMargins(top: 10, left: 10, bottom: 10, right: 10)
    
    private lazy var decimalSeparatorButton = UIButton()
        .setMyStyle(cornerRadius: AppDesign.cornerRadiusKeyBoard)
        .setStyleTitle(
            color: .black,
            font: Fonts.numbersOnKeyboard)
    
    private lazy var zeroButton = UIButton()
        .setMyStyle(cornerRadius: AppDesign.cornerRadiusKeyBoard)
        .setStyleTitle(
            color: .black,
            font: Fonts.numbersOnKeyboard)
    
    private lazy var deleteButton = UIButton()
        .setMyStyle(cornerRadius: AppDesign.cornerRadiusKeyBoard)
        .setStyleTitle(
            color: .black,
            font: Fonts.numbersOnKeyboard)
    
    private func createButtonAnswer(title: String) -> UIButton {
        let button = UIButton()
            .setMyStyle(cornerRadius: AppDesign.cornerRadiusKeyBoard)
            .setStyleTitle(
                color: .black,
                font: Fonts.numbersOnKeyboard)
            .setMyTitle(text: title, state: .normal)
        return button
    }
    
    private func createStackViewNumber(element: UIButton) {
        let buttonsInARow = 3
        
        if numeralsButtonArray.count < buttonsInARow {
            numeralsButtonArray.append(element)
        } else {
            
            let stackViewAnswer = UIStackView()
                .myStyleStack(
                    spacing: AppDesign.spacingBetweenButtons,
                    alignment: .fill,
                    axis: .horizontal,
                    distribution: .fillEqually,
                    userInteraction: true)
            
            numeralsButtonArray.forEach { button in
                stackViewAnswer.addArrangedSubview(button)
            }
            
            mainStackView.addArrangedSubview(stackViewAnswer)
            numeralsButtonArray.removeAll()
            numeralsButtonArray.append(element)
        }
    }
    
    private func createPositionButtons() {
        for numeral in 1...10 {
            let numeralButton = createButtonAnswer(title: String(numeral))
            createStackViewNumber(element: numeralButton)
        }
    }
    
    //MARK: Init 
    init(target: UIKeyInput & UITextInput) {
        self.target = target
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.addSubview(containerView)
        createPositionButtons()
        lastStackView.addArrangedSubview(decimalSeparatorButton)
        lastStackView.addArrangedSubview(zeroButton)
        lastStackView.addArrangedSubview(deleteButton)
        mainStackView.addArrangedSubview(lastStackView)
        containerView.addSubview(mainStackView)
        setConstraints()
        target.insertText("1")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location: CGPoint = touch.location(in: self)

        self.subviews.reversed().forEach { subview in
            let coordinates = self.convert(location, to:subview)
            
            if let button = subview.hitTest(coordinates, with: event) as? UIButton {
                touchDown(sender: button)
                currentButton = button
                
                if button == deleteButton {
                  touchDownDelete(sender: button)
                }
            }
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location: CGPoint = touch.location(in: self)
        
        self.subviews.reversed().forEach { subview in
            let coordinates = self.convert(location, to:subview)
            if let button = subview.hitTest(coordinates, with: event) as? UIButton {
                lastButton = currentButton
                currentButton = button
                touchDown(sender: currentButton)
            } else {
                touchUpInside(sender: currentButton)
            }
        }
        
        if lastButton != currentButton {
            touchUpInside(sender: lastButton)
        }
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location: CGPoint = touch.location(in: self)
        
        guard let numbers = currentButton?.titleLabel?.text else { return }

        if currentButton == lastButton {
            touchUpInside(sender: lastButton)
            
        } else {
            touchUpInside(sender: currentButton)
        }

        self.subviews.reversed().forEach { subview in
            let coordinates = self.convert(location, to:subview)
            
            if let button = subview.hitTest(coordinates, with: event) as? UIButton {
                
                switch button {
                case deleteButton:
                    deleteTouchUpInside(sender: button)
                default:
                    insertText(numbers)
                }
            }
        }
        super.touchesEnded(touches, with: event)
    }
   
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: indentForLayout),
            containerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -indentForLayout),
            containerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -indentBottom)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func insertText(_ text: String) {
        guard let range = target?.selectedRange else { return }

        guard let textField = target as? UITextField else { return }

        if textField.delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: text) == false  { return }
        
        target?.insertText(text)
        textField.delegate?.textFieldDidBeginEditing!(textField)
    }
    
    private func touchDown(sender: UIButton?) {
        guard let button = sender else { return }
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.tochDownKeyBoard
    }
    
    private func touchUpInside(sender: UIButton?) {
        guard let button = sender else { return }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = Colors.upInsideKeyBoard
        }, completion: nil)
    }
    
    private func deleteTouchUpInside(sender: UIButton) {
        target?.deleteBackward()
        
        timer.invalidate()
        if let textField = target as? UITextField, textField.delegate?.textFieldShouldClear?(textField) == false { return }
    }
    
    private func touchDownDelete(sender: UIButton) {
        sender.backgroundColor = Colors.tochDownKeyBoard
        sender.setTitleColor(.white, for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(deleteButtonForTimer), userInfo: nil, repeats: true)
    }
    
    @objc func deleteButtonForTimer() {
        target?.deleteBackward()
    }
}

//MARK: Extension
extension ViewKeyBoard: ConfigurableView {
    
    typealias Model = KeyBoardView
    
    func configure(with model: Model) {
        self.decimalSeparatorButton.setTitle(model.decimalSeparator, for: .normal)
        self.decimalSeparatorButton.accessibilityLabel = model.decimalSeparator
        self.deleteButton.setTitle(model.deleteElement, for: .normal)
        self.zeroButton.setTitle(model.zero, for: .normal)
    }
}

extension UITextInput {
    var selectedRange: NSRange? {
        guard let textRange = selectedTextRange else { return nil }
        let location = offset(from: beginningOfDocument, to: textRange.start)
        let length = offset(from: textRange.start, to: textRange.end)
        return NSRange(location: location, length: length)
    }
}
