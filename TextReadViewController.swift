//
//  TextReadViewController.swift
//  LabelAppOne
//
//  Created by Александр Николаевич on 28.01.2022.
//

import UIKit
import SnapKit

class TextReadViewController: UIViewController {
    
    let familesFont = UIFont.familyNames
    var currentFont = ""
    
    //MARK: - Elements
    let mainTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(white: 0.5, alpha: 0.4)
        textView.textAlignment = .center
        textView.text = exampleText
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        return textView
    }()
    
    let sizeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 18.0
        slider.minimumValue = 0
        slider.maximumValue = 70
        slider.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        return slider
    }()
    
    let styleTextPickerView : UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 0
        picker.backgroundColor = UIColor(white: 0.65, alpha: 0.2)
        picker.layer.cornerRadius = 20
        picker.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 25, height: 50))
        return picker
    }()
    
    let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.addTarget(self, action: #selector(changeSwitchStatus), for: .valueChanged)
        return switcher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupHierarchy()
        setupConstraints()
        setupTabBar()
        setupDelegateDatasource()
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil , queue: nil) { nc in
            self.view.frame.origin.y = -200
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { nc in
            self.view.frame.origin.y = 0
        }
    }
    
    //MARK: - Hierarchy
    private func setupHierarchy() {
        view.addSubview(mainTextView)
        view.addSubview(styleTextPickerView)
        view.addSubview(switcher)
        view.addSubview(sizeSlider)
    }
    
    //MARK: - TabBar
    private func setupTabBar() {
        
        var tabBar = UITabBarItem()
        tabBar = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance;
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        self.tabBarItem = tabBar
    }
    
    //MARK: - Constraints
    private func setupConstraints() {
        
        mainTextView.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(-300)
        }
        
        styleTextPickerView.snp.makeConstraints { make in
            make.top.equalTo(mainTextView.snp.bottom).offset(20)
            make.left.equalTo(30)
            make.right.equalTo(-250)
            make.bottom.equalTo(-200)
        }
        
        sizeSlider.snp.makeConstraints { make in
            make.left.equalTo(styleTextPickerView.snp.right).offset(20)
            make.top.equalTo(mainTextView.snp.bottom).offset(20)
            make.right.equalTo(-30)
            make.bottom.equalTo(-200)
        }
        
        switcher.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.top.equalTo(styleTextPickerView.snp.bottom).offset(20)
            make.bottom.equalTo(-100)
            make.right.equalTo(-250)
        }
    }
    //MARK: - Delegate and DataSource
    private func setupDelegateDatasource() {
        styleTextPickerView.delegate = self
        styleTextPickerView.dataSource = self
        mainTextView.delegate = self
    }
    
    //MARK: - Setup View
    private func setup() {
        view.backgroundColor = .white
    }
    
    //MARK: - Метод для слайдера
    @objc func changeValue( sender: UISlider) {
        if sender == sizeSlider {
            DispatchQueue.main.async {
                self.mainTextView.font = UIFont(name: self.currentFont , size: CGFloat(sender.value))
            }
        }
    }
    
    //MARK: - Метод для свитчера
    @objc func changeSwitchStatus (sender: UISwitch) {
        if sender == switcher {
            if sender.isOn {
                DispatchQueue.main.async {
                    self.view.overrideUserInterfaceStyle = .dark
                    self.view.backgroundColor = .white
                }
                
            } else {
                DispatchQueue.main.async{
                    self.view.overrideUserInterfaceStyle = .dark
                    self.view.backgroundColor = .black
                }
            }
        }
    }
    
}
