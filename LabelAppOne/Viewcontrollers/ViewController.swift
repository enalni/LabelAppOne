//
//  ViewController.swift
//  LabelAppOne
//
//  Created by Александр Николаевич on 25.01.2022.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    //MARK: - Elements
    let familesFont = UIFont.familyNames
    let systemColor = ["Черный","Синий","Красный","Зеленый","Серый"]
    var currentFont = ""
    let color = [UIColor.black, UIColor.systemBlue, UIColor.systemRed, UIColor.systemGreen, UIColor.gray]
    var currentFontSize = Metric.sliderStartValue
    
    
    let myLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Metric.mainLabelBoldSystemFont)
        label.text = Strings.welcome
        label.textAlignment = .center
        return label
    }()
    
    let textStyleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.textStyleLabelTitle
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: Metric.textStyleColorBoldSystemFont)
        return label
    }()
    
    let textColorLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.textColorLabelTitle
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: Metric.textStyleColorBoldSystemFont)
        return label
    }()
    
    lazy var styleColorTextStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textStyleLabel,textColorLabel])
        stackView.axis = .horizontal
        stackView.spacing = Metric.spacingStackView
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    let styleTextPickerView : UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 0
        picker.backgroundColor = Metric.pickerViewBackgroundColor
        picker.layer.cornerRadius = Metric.cornerRadius
        return picker
    }()
    
    let colorTextPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.tag  = 1
        picker.backgroundColor = Metric.pickerViewBackgroundColor
        picker.layer.cornerRadius = Metric.cornerRadius
        return picker
    }()
    
    lazy var styleColorPickerViewStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [styleTextPickerView,colorTextPickerView])
        stackView.axis = .horizontal
        stackView.spacing = Metric.spacingStackView
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    let labelSlider: UILabel = {
        let label = UILabel()
        label.text = Strings.labelSliderText
        label.textAlignment = .center
        return label
    }()
    
    let sizeSlider: UISlider = {
        let slider = UISlider()
        slider.value = Metric.sliderStartValue
        slider.minimumValue = Metric.sliderMinimumValue
        slider.maximumValue = Metric.sliderMaximumValue
        slider.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        return slider
    }()
    
    let labelSwitcher: UILabel = {
        let label = UILabel()
        label.text = Strings.labelSliderText
        label.textAlignment = .center
        return label
    }()
    
    let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        switcher.addTarget(self, action: #selector(changeSwitchStatus), for: .valueChanged)
        return switcher
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "1")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.frame = CGRect(x: 0, y: 0, width: 0, height: 250)
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setup()
        setupTabBar()
        setupConstraints()
        setupDelegateDatasource()
        print(currentFont)
    }
    
    //MARK: - Hierarchy
    private func setupHierarchy() {
        view.addSubview(myLabel)
        view.addSubview(styleColorTextStackView)
        view.addSubview(styleColorPickerViewStackView)
        view.addSubview(labelSlider)
        view.addSubview(sizeSlider)
        view.addSubview(labelSwitcher)
        view.addSubview(switcher)
        view.addSubview(imageView)
    }
    
    //MARK: - TabBar
    private func setupTabBar() {
        var tabBar = UITabBarItem()
        tabBar = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance;
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        self.tabBarItem = tabBar
    }
    
    //MARK: - Constraints
    private func setupConstraints() {
        
        myLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(Metric.topMarginMainLabel)
            make.leadingMargin.equalTo(Metric.leftConstraints)
            make.trailingMargin.equalTo(Metric.rightConstraints)
            make.height.equalTo(view.bounds.size.width / 5)
        }
        
        styleColorTextStackView.snp.makeConstraints { make in
            make.topMargin.equalTo(myLabel.snp.bottom).offset(Metric.topMarginMainLabel)
            make.left.equalTo(Metric.leftConstraints)
            make.right.equalTo(Metric.rightConstraints)
        }
        
        styleColorPickerViewStackView.snp.makeConstraints { make in
            make.topMargin.equalTo(styleColorTextStackView.snp.bottom).offset(Metric.topMarginMainLabel)
            make.left.equalTo(Metric.leftConstraints)
            make.right.equalTo(Metric.rightConstraints)
        }
        
        labelSlider.snp.makeConstraints { make in
            make.width.equalTo(sizeSlider.snp.width)
            make.topMargin.equalTo(styleColorPickerViewStackView.snp.bottom).offset(Metric.topMarginMainLabel)
            
            make.left.equalTo(Metric.leftConstraints)
            make.right.equalTo(Metric.rightConstraints)
        }
        
        sizeSlider.snp.makeConstraints { make in
            make.width.equalTo(styleColorTextStackView.snp.width)
            make.topMargin.equalTo(labelSlider.snp.bottom).offset(Metric.topMarginMainLabel)
            make.left.equalTo(Metric.leftConstraints)
            make.right.equalTo(Metric.rightConstraints)
        }
        
        labelSwitcher.snp.makeConstraints { make in
            make.width.equalTo(styleColorTextStackView.snp.width)
            make.topMargin.equalTo(sizeSlider.snp.bottom).offset(Metric.topMarginMainLabel)
            make.left.equalTo(Metric.leftConstraints)
            make.right.equalTo(Metric.rightConstraints)
        }
        
        switcher.snp.makeConstraints { make in
            make.topMargin.equalTo(labelSwitcher.snp.bottom).offset(Metric.topMarginMainLabel)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        imageView.snp.makeConstraints { make in
            make.topMargin.equalTo(Metric.topMarginMainLabel)
            make.leadingMargin.equalTo(Metric.leftConstraints)
            make.trailingMargin.equalTo(Metric.rightConstraints)
            make.height.equalTo(view.bounds.size.height / 3 )
        }
    }
    
    //MARK: - Setup View
    private func setup() {
        view.backgroundColor = .white
        navigationItem.title = "1️⃣"
    }
    
    
    //MARK: - Delegate and DataSource
    private func setupDelegateDatasource() {
        styleTextPickerView.delegate = self
        styleTextPickerView.dataSource = self
        
        colorTextPickerView.delegate = self
        colorTextPickerView.dataSource = self
    }
    //MARK: - Метод для слайдера
    @objc func changeValue( sender: UISlider) {
        if sender == sizeSlider {
            DispatchQueue.main.async {
                self.myLabel.font = UIFont(name: self.currentFont , size: CGFloat(sender.value))
            }
        }
    }
    
    //MARK: - Метод для свитчера
    @objc func changeSwitchStatus (sender: UISwitch) {
        if sender == switcher {
            if sender.isOn {
                self.styleTextPickerView.isHidden = true
                self.colorTextPickerView.isHidden = true
                self.labelSwitcher.isHidden = true
                self.labelSlider.isHidden = true
                self.sizeSlider.isHidden = true
                self.myLabel.isHidden = true
                self.textColorLabel.isHidden = true
                self.textStyleLabel.isHidden = true
                self.imageView.isHidden = false
            } else {
                self.styleTextPickerView.isHidden = false
                self.colorTextPickerView.isHidden = false
                self.labelSwitcher.isHidden = false
                self.labelSlider.isHidden = false
                self.sizeSlider.isHidden = false
                self.myLabel.isHidden = false
                self.textColorLabel.isHidden = false
                self.textStyleLabel.isHidden = false
                self.imageView.isHidden = true
            }
        }
    }
    
    
    enum Strings {
        static let welcome = "Alexander"
        static let textStyleLabelTitle = "Шрифт текста"
        static let textColorLabelTitle = "Цвет текста"
        static let labelSliderText = "Ты можешь поменять размер шрифта"
        static let labelSwitcherText = "НАЖМИ 😉"
    }
    
    enum Metric {
        static let spacingStackView: CGFloat = 50
        static let sliderStartValue: Float = 18
        static let mainLabelBoldSystemFont: CGFloat = 25
        static let textStyleColorBoldSystemFont: CGFloat = 18
        static let cornerRadius: CGFloat = 20
        static let pickerViewBackgroundColor = UIColor(white: 0.65, alpha: 0.2)
        static let sliderMinimumValue: Float = 0
        static let sliderMaximumValue: Float = 70
        static let topMarginMainLabel: CGFloat = 20
        static let leftConstraints: CGFloat = 20
        static let rightConstraints: CGFloat = -20
    }
}
