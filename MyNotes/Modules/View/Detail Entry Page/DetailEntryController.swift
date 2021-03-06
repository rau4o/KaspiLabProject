//
//  DetailEntryController.swift
//  MyNotes
//
//  Created by rau4o on 6/28/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class DetailEntryController: UIViewController {
    
    private struct Identifier {
        let descEntryCell = "descEntryCell"
        let staticLabelCell = "staticLabel"
        let locationCell = "locationCell"
        let headerDetailViewCell = "headerDetailViewCell"
        let addressEntryCell = "addressEntryCell"
    }
    
    private struct HeightRow {
        let descEntryHeight: CGFloat = 50
        let staticLabelHeight: CGFloat = 40
        let locationCellHeight: CGFloat = 200
        let headerViewHeight: CGFloat = 200
        let addressEntryHeight: CGFloat = 50
    }
    
    // MARK: - Properties
    
    var entryModel = EntryModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: Identifier().descEntryCell)
        tableView.register(StaticLabelViewCell.self, forCellReuseIdentifier: Identifier().staticLabelCell)
        tableView.register(MapLocationCell.self, forCellReuseIdentifier: Identifier().locationCell)
        tableView.register(HeaderDetailView.self, forCellReuseIdentifier: Identifier().headerDetailViewCell)
        tableView.register(AddressTableViewCell.self, forCellReuseIdentifier: Identifier().addressEntryCell)
        return tableView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setNavigationBar()
    }
    
    // MARK: - Helper Function

    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let startingYPos = UIApplication.shared.statusBarFrame.size.height
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: startingYPos, width: screenSize.width, height: 50))
        let navItem = UINavigationItem(title: entryModel.datePrettyString())
        let backItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(backAction(_:)))
        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: nil, action: #selector(deleteEntry(_:)))
        navItem.leftBarButtonItem = backItem
        navItem.rightBarButtonItem = deleteItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    // MARK: - Selectors
    
    @objc private func backAction(_ sender: UINavigationItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func deleteEntry(_ sender: UINavigationItem) {
        RealmService.shared.delete(entryModel)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Setup UI

private extension DetailEntryController {
    
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

extension DetailEntryController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return HeightRow().headerViewHeight
        case 1:
            return UITableView.automaticDimension
        case 2:
            return HeightRow().addressEntryHeight
        case 3:
            return HeightRow().staticLabelHeight
        case 4:
            return HeightRow().locationCellHeight
        default:
            fatalError("OPs")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell0 = tableView.dequeueReusableCell(withIdentifier: Identifier().headerDetailViewCell, for: indexPath) as? HeaderDetailView
            cell0?.configureDetailView(with: entryModel)
            return cell0 ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier().descEntryCell, for: indexPath) as? DescriptionTableViewCell
            cell?.configureCell(with: entryModel)
            return cell ?? UITableViewCell()
        case 2:
            let cell10 = tableView.dequeueReusableCell(withIdentifier: Identifier().addressEntryCell, for: indexPath) as? AddressTableViewCell
            cell10?.configureCell(with: entryModel)
            return cell10 ?? UITableViewCell()
        case 3:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: Identifier().staticLabelCell, for: indexPath) as? StaticLabelViewCell
            cell2?.configureCell()
            return cell2 ?? UITableViewCell()
        case 4:
            let cell3 = tableView.dequeueReusableCell(withIdentifier: Identifier().locationCell, for: indexPath) as? MapLocationCell
            let query = entryModel.address
            cell3?.configure(with: query)
            return cell3 ?? UITableViewCell()
        default:
            fatalError("ops")
        }
    }
}

// MARK: - UITableViewDelegate

extension DetailEntryController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
