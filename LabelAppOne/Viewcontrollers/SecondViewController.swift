//
//  SecondViewController.swift
//  LabelAppOne
//
//  Created by Александр Николаевич on 25.01.2022.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {
    
    //MARK: - Elements
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "ДОБРО ПОЖАЛОВАТЬ"
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "введите логин"
        textField.textAlignment = .center
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField =  UITextField()
        textField.placeholder = "введите пароль"
        textField.textAlignment = .center
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    lazy var stackview: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [nameTextField,passwordTextField])
        stackview.axis = .vertical
        stackview.spacing = 30
        //stackview.backgroundColor = .systemGreen
        //stackview.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 250, height: 500))
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ВОЙТИ", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemGreen
        button.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 150, height: 30))
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
        setupTabBar()
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
            make.top.equalTo(150)
            make.right.equalTo(-40)
            make.left.equalTo(40)
        }
        
        stackview.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(mainLabel.snp.bottom).offset(150)
            make.bottom.equalTo(-400)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(stackview.snp.bottom).offset(100)
            make.left.equalTo(100)
            make.right.equalTo(-100)
        }
    }
    
    
    //MARK: - TabBar
    private func setupTabBar() {
        var tabBar = UITabBarItem()
        tabBar = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 2)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance;
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        self.tabBarItem = tabBar
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

}
