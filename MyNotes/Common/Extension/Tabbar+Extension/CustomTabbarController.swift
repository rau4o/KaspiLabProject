//
//  CustomTabbarController.swift
//  MyNotes
//
//  Created by rau4o on 6/18/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)

public protocol CustomTabBarControllerDelegate: NSObjectProtocol {
    func tabBarController(_ tabBarController: CustomTabbarController, didSelect viewController: UIViewController)
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool
}

@available(iOS 10.0, *)
open class CustomTabbarController: UIViewController, TabBarDelegate {
    
    weak open var delegate: CustomTabBarControllerDelegate?
    
    public var selectedIndex: Int = 0
    public var previousSelectedIndex = 0
    
    public var viewControllers = [UIViewController]() {
        didSet {
            tabBar.viewControllers = viewControllers
        }
    }
    
    private lazy var tabBar: CustomTabBar = {
        let tabBar = CustomTabBar()
        tabBar.delegate = self
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        return tabBar
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(containerView)
        self.view.addSubview(tabBar)
        self.view.bringSubviewToFront(tabBar)
        self.drawConstraint()
    }
    
    private func drawConstraint() {
        let safeAreaView = UIView()
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        safeAreaView.backgroundColor = CustomTabbarSetting.tabBarBackground
        self.view.addSubview(safeAreaView)
        self.view.bringSubviewToFront(safeAreaView)
        var constraints = [NSLayoutConstraint]()
        if #available(iOS 11.0, *) {
            constraints += [containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(CustomTabbarSetting.tabBarHeight)),
                            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)]
        } else {
            constraints += [containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(CustomTabbarSetting.tabBarHeight)),
                            tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
        }
        constraints += [containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        containerView.topAnchor.constraint(equalTo: view.topAnchor),
                        tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                        tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        tabBar.heightAnchor.constraint(equalToConstant: CustomTabbarSetting.tabBarHeight),
                        safeAreaView.topAnchor.constraint(equalTo: tabBar.bottomAnchor),
                        safeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                        safeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        safeAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
    
    func tabBar(_ tabBar: CustomTabBar, didSelectTabAt index: Int) {
        
        let previousVC = viewControllers[index]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        previousSelectedIndex = selectedIndex
        
        let vc = viewControllers[index]
        delegate?.tabBarController(self, didSelect: vc)
        addChild(vc)
        selectedIndex = index + 1
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
}

