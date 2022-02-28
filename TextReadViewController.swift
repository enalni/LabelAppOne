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
        textView.backgroundColor = Metric.textViewBackgroundColor
        textView.textAlignment = .center
        textView.text = exampleText
        textView.font = Metric.textViewFont
        return textView
    }()
    
    let sizeSlider: UISlider = {
        let slider = UISlider()
        slider.value = Metric.sliderStartValue
        slider.minimumValue = Metric.sliderMinimumValue
        slider.maximumValue = Metric.sliderMaximumValue
        slider.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        return slider
    }()
    
    let styleTextPickerView : UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 0
        picker.backgroundColor = Metric.pickerViewBackgroundColor
        picker.layer.cornerRadius = Metric.cornerRadius
        return picker
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
            make.topMargin.equalTo(Metric.topMargin)
            make.left.equalTo(Metric.leftConstraints)
            make.right.equalTo(Metric.rightConstraints)
            make.height.equalTo(view.bounds.size.height / 2)
        }
        
        styleTextPickerView.snp.makeConstraints { make in
            make.topMargin.equalTo(mainTextView.snp.bottom).offset(Metric.topMargin)
            make.left.equalTo(Metric.leftConstraints)
            make.height.equalTo(view.bounds.size.height / 4)
            make.width.equalTo(view.bounds.size.width / 3)

        }
        
        sizeSlider.snp.makeConstraints { make in
            make.left.equalTo(styleTextPickerView.snp.right).offset(Metric.leftConstraints)
            make.topMargin.equalTo(mainTextView.snp.bottom).offset(Metric.topMarginSlider)
            make.right.equalTo(Metric.rightConstraints)

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

    enum Metric {
        static let textViewFont = UIFont.boldSystemFont(ofSize: 20)
        static let sliderStartValue: Float = 18
        static let pickerViewBackgroundColor = UIColor(white: 0.65, alpha: 0.2)
        static let textViewBackgroundColor = UIColor(white: 0.5, alpha: 0.4)
        static let sliderMinimumValue: Float = 0
        static let sliderMaximumValue: Float = 70
        static let topMargin: CGFloat = 20
        static let topMarginSlider: CGFloat = 100
        static let leftConstraints: CGFloat = 20
        static let cornerRadius: CGFloat = 20
        static let rightConstraints: CGFloat = -20
    }
    
}
