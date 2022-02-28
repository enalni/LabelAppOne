//
//  SecondViewController.swift
//  LabelAppOne
//
//  Created by Александр Николаевич on 25.01.2022.
//

import UIKit
import SnapKit

 final class SecondViewController: UIViewController {
    
    //MARK: - Elements
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.welcome
        label.font = UIFont.boldSystemFont(ofSize: Metric.boldSystemFont)
        label.textAlignment = .center
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Strings.placeHolderLoginTextfiled
        textField.textAlignment = .center
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField =  UITextField()
        textField.placeholder = Strings.placeHolderPasswordTextfiled
        textField.textAlignment = .center
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    lazy var stackview: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [nameTextField,passwordTextField])
        stackview.axis = .vertical
        stackview.spacing = Metric.spacingStackView
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.labelButton, for: .normal)
        button.layer.cornerRadius = Metric.cornerRadius
        button.layer.borderWidth = Metric.borderWidth
        button.titleLabel?.font = .boldSystemFont(ofSize: Metric.systemFont)
        button.layer.borderColor = Metric.buttonBorderColor
        button.addTarget(self, action: #selector(changeVC), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        passwordTextField.delegate = self
        setup()
        setupHierarchy()
        setupConstraints()
    }
    //MARK: - Hierarchy
    private func setupHierarchy() {
        view.addSubview(stackview)
        view.addSubview(button)
        view.addSubview(mainLabel)
    }
    
    //MARK: - Constraints
    private func setupConstraints() {
        
        mainLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(Metric.topMarginMainLabel)
            make.right.equalTo(Metric.rightConstraints)
            make.left.equalTo(Metric.leftConstraints)
            make.height.equalTo(view.bounds.size.height / Metric.heightMainLabel)
        }
        
        stackview.snp.makeConstraints { make in
            make.topMargin.equalTo(mainLabel.snp.bottom).offset(Metric.topMarginStackView)
            make.left.equalTo(Metric.leftConstraints)
            make.right.equalTo(Metric.rightConstraints)
        }
        
        button.snp.makeConstraints { make in
            make.topMargin.equalTo(stackview.snp.bottom).offset(Metric.topMarginButton)
            make.left.equalTo(Metric.leftConstraints)
            make.right.equalTo(Metric.rightConstraints)
            make.height.equalTo(Metric.height)
        }
    }
    
    
    //MARK: - Setup View
    private func setup() {
        view.backgroundColor = .white
        navigationItem.title = "2️⃣"
    }
    
    @objc private func changeVC() {
        let vc = TextReadViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SecondViewController : UITextFieldDelegate {
    
    // символы
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField {
            DispatchQueue.main.async {
                self.mainLabel.text = string
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameTextField {
            self.passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            self.passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    enum Strings {
        static let welcome = "ДОБРО ПОЖАЛОВАТЬ"
        static let placeHolderLoginTextfiled = "введите логин"
        static let placeHolderPasswordTextfiled = "введите пароль"
        static let labelButton = "ВОЙТИ"
    }
    
    enum Metric {
        static let spacingStackView: CGFloat = 30
        static let cornerRadius: CGFloat = 30
        static let boldSystemFont: CGFloat = 25
        static let borderWidth: CGFloat = 3
        static let systemFont: CGFloat = 16
        
        static let leftConstraints: CGFloat = 20
        static let rightConstraints: CGFloat = -20
        static let heightMainLabel: CGFloat = 8
        
        static let topMarginMainLabel: CGFloat = 30
        static let topMarginStackView: CGFloat = 100
        static let topMarginButton: CGFloat = 150
        
        static let height: CGFloat = 50
        
        static let buttonBorderColor = CGColor(red: 103.0/255.0, green: 140.0/255.0, blue: 242.0/255.0, alpha: 1.0)
    }

}
