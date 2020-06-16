//
//  MainRegistrationController.swift
//  MyNotes
//
//  Created by rau4o on 6/16/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import BmoViewPager

class MainRegistrationController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Notes 📝"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 40)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()

    lazy private var viewPager: BmoViewPager = {
        let view = BmoViewPager()
        view.scrollable = true
        view.dataSource = self
        return view
    }()
    
    lazy private var pagerNavigationBar: BmoViewPagerNavigationBar = {
        let view = BmoViewPagerNavigationBar()
        view.backgroundColor = UIColor.mainBlue
        view.autoFocus = false
        return view
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        view.backgroundColor = .mainBlue
        pagerNavigationBar.viewPager = viewPager
    }
    
    // MARK: - Helper function
    
    private func layoutUI() {
        [titleLabel ,pagerNavigationBar, viewPager].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(70)
            make.centerX.equalToSuperview()
        }
        
        pagerNavigationBar.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        
        viewPager.snp.makeConstraints { (make) in
            make.top.equalTo(pagerNavigationBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - BmoViewPagerDataSource

extension MainRegistrationController: BmoViewPagerDataSource {
    
    func bmoViewPagerDataSourceNaviagtionBarItemNormalAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [
            NSAttributedString.Key.strokeWidth     : 1.5,
            NSAttributedString.Key.strokeColor     : UIColor.white,
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
    }
    
    func bmoViewPagerDataSourceNumberOfPage(in viewPager: BmoViewPager) -> Int {
        return 2
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemTitle(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> String? {
        return page == 0 ? "Sign In" : "Sign Up"
    }
    
    func bmoViewPagerDataSource(_ viewPager: BmoViewPager, viewControllerForPageAt page: Int) -> UIViewController {
        switch page {
        case 0:
            let vc = LoginController()
            return vc
        case 1:
            let vc2 = RegistrationController()
            return vc2
        default:
            break
        }
        return UIViewController()
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Medium", size: 25)!]
    }
    
    func bmoViewPagerDataSourceNaviagtionBarItemSize(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> CGSize {
        return CGSize(width: navigationBar.bounds.width / 2, height: navigationBar.bounds.height)
    }
}
