//
//  TabBarController.swift
//  LabelAppOne
//
//  Created by Александр Николаевич on 28.02.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Settings
        view.backgroundColor = .white
        tabBar.isTranslucent = false
        tabBar.tintColor = .systemBlue
        
        // MARK: - Controllers
        let vcOne = ViewController()
        let vcTwo = SecondViewController()
        let vcThree = CollectionMainViewController()
        
        
        viewControllers = [
            settinViewControllers(rootVc: vcOne, title: StringTitles.tabBarOne, image: Images.tabBarOne),
            settinViewControllers(rootVc: vcTwo, title: StringTitles.tabBarTwo, image: Images.tabBarTwo),
            settinViewControllers(rootVc: vcThree, title: StringTitles.tabBarThree, image: Images.tabBarThree)
        ]
    }
    
    
    // MARK: - SettingViewControllers
    private func settinViewControllers(rootVc: UIViewController, title: String, image: UIImage?) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootVc)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
    
    
    // MARK: - Enums
    enum StringTitles {
        static let tabBarOne = "PickerView, Slider, Switch"
        static let tabBarTwo = "TextField,TextView"
        static let tabBarThree = "Collection and Networking"
    }
    
    enum Images {
        static let tabBarOne = UIImage(systemName: "photo.fill.on.rectangle.fill")
        static let tabBarTwo = UIImage(systemName: "heart.text.square.fill")
        static let tabBarThree = UIImage(systemName: "rectangle.stack.fill")
    }
}
