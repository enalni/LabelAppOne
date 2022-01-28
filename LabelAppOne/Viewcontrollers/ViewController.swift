//
//  ViewController.swift
//  LabelAppOne
//
//  Created by Александр Николаевич on 25.01.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK: - Elements
    let familesFont = UIFont.familyNames
    let systemColor = ["Черный","Синий","Красный","Зеленый","Серый"]
    var currentFont = ""
    let color = [UIColor.black, UIColor.systemBlue, UIColor.systemRed, UIColor.systemGreen, UIColor.gray]
    var currentFontSize = Float(18.0)
    
    
    let myLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 200, height: 100))
        label.text = "Alexander"
        label.textAlignment = .center
        return label
    }()
    
    let textStyleLabel: UILabel = {
        let label = UILabel()
        label.text = "Стиль текста"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 0, height: 25))
        return label
    }()
    
    let textColorLabel: UILabel = {
        let label = UILabel()
        label.text = "Цвет текста"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 0, height: 25))
        return label
    }()
    
    lazy var styleColorTextStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textStyleLabel,textColorLabel])
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    let styleTextPickerView : UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 0
        picker.backgroundColor = UIColor(white: 0.65, alpha: 0.2)
        picker.layer.cornerRadius = 20
        return picker
    }()
    
    let colorTextPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.tag  = 1
        picker.backgroundColor = UIColor(white: 0.65, alpha: 0.2)
        picker.layer.cornerRadius = 20
        return picker
    }()
    
    lazy var styleColorPickerViewStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [styleTextPickerView,colorTextPickerView])
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.distribution = .fillEqually
        stackView.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 0, height: 45))
        return stackView
    }()
    
    
    let labelSlider: UILabel = {
        let label = UILabel()
        label.text = "Ты можешь поменять размер шрифта"
        label.textAlignment = .center
        return label
    }()
    
    let sizeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 18.0
        slider.minimumValue = 0
        slider.maximumValue = 70
        slider.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        return slider
    }()
    
    let labelSwitcher: UILabel = {
        let label = UILabel()
        label.text = "НАЖМИ 😉"
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
        self.tabBarItem = tabBar
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance;
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }
    
    //MARK: - Constraints
    private func setupConstraints() {
        
        myLabel.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(100)
        }
        
        styleColorTextStackView.snp.makeConstraints { make in
            make.top.equalTo(myLabel.snp.bottom).offset(30)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
        
        styleColorPickerViewStackView.snp.makeConstraints { make in
            make.top.equalTo(styleColorTextStackView.snp.bottom).offset(30)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
        
        labelSlider.snp.makeConstraints { make in
            make.width.equalTo(sizeSlider.snp.width)
            make.top.equalTo(styleColorPickerViewStackView.snp.bottom).offset(30)
            
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
        
        sizeSlider.snp.makeConstraints { make in
            make.width.equalTo(styleColorTextStackView.snp.width)
            make.top.equalTo(labelSlider.snp.bottom).offset(15)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
        
        labelSwitcher.snp.makeConstraints { make in
            make.width.equalTo(styleColorTextStackView.snp.width)
            make.top.equalTo(sizeSlider.snp.bottom).offset(30)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
        
        switcher.snp.makeConstraints { make in
            make.top.equalTo(labelSwitcher.snp.bottom).offset(15)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-600)
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
}
