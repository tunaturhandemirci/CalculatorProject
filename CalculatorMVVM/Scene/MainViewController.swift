//
//  MainViewController.swift
//  CalculatorMVVM
//
//  Created by Tuna Demirci on 26.08.2024.
//

import UIKit
import SnapKit
import Combine

class MainViewController: UIViewController {
    
    //MARK: -Properties
    
    let mainViewModel = MainViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    lazy var zeroButton : UIButton = createButton(title: .zero, action: #selector(buttonTapped), backgroundColor: .darkGrayColor)
    lazy var decimalButton : UIButton = createButton(title: .decimal, action: #selector(buttonTapped), backgroundColor: .darkGrayColor)
    lazy var equalButton : UIButton = createButton(title: .equal, action: #selector(buttonTapped), backgroundColor: .orangeColor)
    lazy var oneButton : UIButton = createButton(title: .one, action: #selector(buttonTapped), backgroundColor: .darkGrayColor)
    lazy var twoButton : UIButton = createButton(title: .two, action: #selector(buttonTapped), backgroundColor: .darkGrayColor)
    lazy var threeButton : UIButton = createButton(title: .three, action: #selector(buttonTapped), backgroundColor: .darkGrayColor)
    lazy var plusButton : UIButton = createButton(title: .plus, action: #selector(buttonTapped), backgroundColor: .orangeColor)
    lazy var fourButton : UIButton = createButton(title: .four, action: #selector(buttonTapped), backgroundColor: .darkGrayColor)
    lazy var fiveButton : UIButton = createButton(title: .five, action: #selector(buttonTapped), backgroundColor: .darkGrayColor)
    lazy var sixButton : UIButton = createButton(title: .six, action: #selector(buttonTapped), backgroundColor: .darkGrayColor)
    lazy var minusButton : UIButton = createButton(title: .minus, action: #selector(buttonTapped), backgroundColor: .orangeColor)
    lazy var sevenButton : UIButton = createButton(title: .seven, action: #selector(buttonTapped), backgroundColor: .darkGrayColor)
    lazy var eightButton : UIButton = createButton(title: .eight, action: #selector(buttonTapped), backgroundColor: .darkGrayColor)
    lazy var nineButton : UIButton = createButton(title: .nine, action: #selector(buttonTapped), backgroundColor: .darkGrayColor)
    lazy var multipleButton : UIButton = createButton(title: .multiple, action: #selector(buttonTapped), backgroundColor: .orangeColor)
    lazy var clearButton : UIButton = createButton(title: .clear, action: #selector(buttonTapped), backgroundColor: .lightGrayColor)
    lazy var negativeButton : UIButton = createButton(title: .negative, action: #selector(buttonTapped), backgroundColor: .lightGrayColor)
    lazy var percentButton : UIButton = createButton(title: .percent, action: #selector(buttonTapped), backgroundColor: .lightGrayColor)
    lazy var divideButton : UIButton = createButton(title: .divide, action: #selector(buttonTapped), backgroundColor: .orangeColor)
    
    lazy var buttons: [UIButton] = {
        return[zeroButton,decimalButton,equalButton,oneButton,twoButton,threeButton,plusButton,fourButton,fiveButton,sixButton,minusButton,sevenButton,eightButton,nineButton,multipleButton,clearButton,negativeButton,percentButton,divideButton]
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        // Combine aboneliği oluşturma
            mainViewModel.$resultText
                .sink { [weak self] newText in
                    self?.resultLabel.text = newText
                }
                .store(in: &cancellables)
    }
    
    // MARK: - User Interaction
    
    @objc func buttonTapped(sender: UIButton) {
        guard let title = sender.currentTitle, let buttonText = Buttons(rawValue: title) else { return }
        mainViewModel.selectedButton(item: buttonText)
    }
}


//MARK: - SetupUI

extension MainViewController {
    
    private func createButton(title: Buttons, action: Selector? = nil, backgroundColor: UIColor = .darkGray ) -> UIButton! {
        guard let buttonAction = action else { return nil }
        let button = UIButton(type: .system)
        button.setTitle(title.rawValue, for: .normal)
        button.setTitleColor(.whiteColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.clipsToBounds = true
        button.addTarget(self, action: buttonAction, for: .touchUpInside)
        return button
    }
    
    private func setButtonCornerRadius(button: UIButton, width: CGFloat, height: CGFloat) {
        button.layer.cornerRadius = min(width, height) / 2
    }
    
    private func setupUI() {
        
        view.backgroundColor = .viewBackgroundColor
        
        for button in buttons {
            view.addSubview(button)
        }
        
        view.addSubview(resultLabel)
        
        let height = screenHeight * 0.10
        let width = screenWidth * 0.20
        let horizontil = screenWidth * 0.040
        let vertical = screenHeight * 0.025
        
        zeroButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(horizontil)
            make.bottom.equalToSuperview().inset(vertical)
            make.height.equalTo(height)
            make.width.equalTo(width * 2)
        }
        
        decimalButton.snp.makeConstraints { make in
            make.leading.equalTo(zeroButton.snp.trailing).inset(-horizontil)
            make.bottom.equalToSuperview().inset(vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        equalButton.snp.makeConstraints { make in
            make.leading.equalTo(decimalButton.snp.trailing).inset(-horizontil)
            make.trailing.equalToSuperview().inset(horizontil)
            make.bottom.equalToSuperview().inset(vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        oneButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(horizontil)
            make.bottom.equalTo(zeroButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        twoButton.snp.makeConstraints { make in
            make.leading.equalTo(oneButton.snp.trailing).inset(-horizontil)
            make.trailing.equalTo(threeButton.snp.leading).inset(-horizontil)
            make.bottom.equalTo(zeroButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        threeButton.snp.makeConstraints { make in
            make.leading.equalTo(twoButton.snp.trailing).inset(-horizontil)
            make.trailing.equalTo(plusButton.snp.leading).inset(-horizontil)
            make.bottom.equalTo(decimalButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        plusButton.snp.makeConstraints { make in
            make.leading.equalTo(threeButton.snp.trailing).inset(-horizontil)
            make.trailing.equalToSuperview().inset(horizontil)
            make.bottom.equalTo(equalButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        fourButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(horizontil)
            make.bottom.equalTo(oneButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        fiveButton.snp.makeConstraints { make in
            make.leading.equalTo(fourButton.snp.trailing).inset(-horizontil)
            make.trailing.equalTo(sixButton.snp.leading).inset(-horizontil)
            make.bottom.equalTo(twoButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        sixButton.snp.makeConstraints { make in
            make.leading.equalTo(fiveButton.snp.trailing).inset(-horizontil)
            make.trailing.equalTo(minusButton.snp.leading).inset(-horizontil)
            make.bottom.equalTo(threeButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        minusButton.snp.makeConstraints { make in
            make.leading.equalTo(sixButton.snp.trailing).inset(-horizontil)
            make.trailing.equalToSuperview().inset(horizontil)
            make.bottom.equalTo(plusButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        sevenButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(horizontil)
            make.bottom.equalTo(fourButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        eightButton.snp.makeConstraints { make in
            make.leading.equalTo(sevenButton.snp.trailing).inset(-horizontil)
            make.trailing.equalTo(nineButton.snp.leading).inset(-horizontil)
            make.bottom.equalTo(fiveButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        nineButton.snp.makeConstraints { make in
            make.leading.equalTo(eightButton.snp.trailing).inset(-horizontil)
            make.trailing.equalTo(multipleButton.snp.leading).inset(-horizontil)
            make.bottom.equalTo(sixButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        multipleButton.snp.makeConstraints { make in
            make.leading.equalTo(nineButton.snp.trailing).inset(-horizontil)
            make.trailing.equalToSuperview().inset(horizontil)
            make.bottom.equalTo(minusButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        clearButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(horizontil)
            make.bottom.equalTo(sevenButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        negativeButton.snp.makeConstraints { make in
            make.leading.equalTo(clearButton.snp.trailing).inset(-horizontil)
            make.trailing.equalTo(percentButton.snp.leading).inset(-horizontil)
            make.bottom.equalTo(eightButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        percentButton.snp.makeConstraints { make in
            make.leading.equalTo(negativeButton.snp.trailing).inset(-horizontil)
            make.trailing.equalTo(divideButton.snp.leading).inset(-horizontil)
            make.bottom.equalTo(nineButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        divideButton.snp.makeConstraints { make in
            make.leading.equalTo(percentButton.snp.trailing).inset(-horizontil)
            make.trailing.equalToSuperview().inset(horizontil)
            make.bottom.equalTo(multipleButton.snp.top).inset(-vertical)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.bottom.equalTo(percentButton.snp.top).inset(-screenHeight * 0.05)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(height)
        }
        
        
        for buttonRadius in buttons {
            setButtonCornerRadius(button: buttonRadius, width: width, height: height)
        }
        
    }
    
}

