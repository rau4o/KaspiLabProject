//
//  ProfileController.swift
//  MyNotes
//
//  Created by rau4o on 6/28/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    // MARK: - Properties
    
    let profileHeaderView = ProfileHeaderView()
    
    private let reuseIdentifier = "AboutCell"
    private var sectionTitles = [NSLocalizedString("Feedback", comment: "Feedback"), NSLocalizedString("Follow Me", comment: "Follow Me")]
    private var sectionContent = [
        [(image: "chat", text: NSLocalizedString("Tell me your feedback", comment: "Tell me your feedback"), link: "https://mail.google.com/mail")],
        [(image: "twitter", text: "Twitter", link: "https://twitter.com/appcodamobile"), (image: "facebook", text: "Facebook", link: "https://facebook.com/appcodamobile"), (image: "instagram", text: "Instagram", link: "https://www.instagram.com/appcodadotcom")]
    ]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        return tableView
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

// MARK: - Setup Views

private extension ProfileController {
    
    func initialSetup() {
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension ProfileController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionContent[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let cellData = sectionContent[indexPath.section][indexPath.row]
        cell.textLabel?.text = cellData.text
        cell.imageView?.image = UIImage(named: cellData.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            profileHeaderView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            profileHeaderView.backgroundColor = .white
            return profileHeaderView
        }
        return nil
    }
}

// MARK: - UITableViewDelegate

extension ProfileController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(123)
    }
}
