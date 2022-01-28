//
//  ThreeViewController.swift
//  LabelAppOne
//
//  Created by Александр Николаевич on 26.01.2022.
//

import UIKit
import SnapKit

class ThreeViewController: UIViewController {
    
    
    
    //MARK: - Elements
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("НАЖМИ НА МЕНЯ", for: .normal)
        button.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 300, height: 100))
        button.backgroundColor = .white
        button.titleLabel?.textAlignment = .center
        return button
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupTabBar()
        setup()
    }
    
    //MARK: - Hierarchy
    private func setupHierarchy()  {
        view.addSubview(button)
    }
    
    //MARK: - Constraints
    private func setupConstraints() {
        button.snp.makeConstraints { make in
            make.center.equalTo(view.center)
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
        view.backgroundColor = .lightGray
    }
}
