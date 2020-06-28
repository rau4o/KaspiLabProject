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
    }
    
    private struct HeightRow {
        let descEntryHeight: CGFloat = 50
        let staticLabelHeight: CGFloat = 50
        let locationCellHeight: CGFloat = 200
        let defaultHeight: CGFloat = 50
    }
    
    // MARK: - Properties
    
    var entryModel = EntryModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: Identifier().descEntryCell)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifier().staticLabelCell)
        tableView.register(MapLocationCell.self, forCellReuseIdentifier: Identifier().locationCell)
        return tableView
    }()
    
    let headerView = HeaderDetailView()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK: - Helper Function
}

// MARK: - Setup UI

private extension DetailEntryController {
    
    func initialSetup() {
        configureUI()
        headerView.imageView.image = entryModel.pictures.first?.thumbnail()
    }
    
    private func configureUI() {
        
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top)
            make.height.equalTo(200)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension DetailEntryController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return HeightRow().descEntryHeight
        case 1:
            return HeightRow().staticLabelHeight
        case 2:
            return HeightRow().locationCellHeight
        default:
            break
        }
        return HeightRow().defaultHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier().descEntryCell, for: indexPath) as? DescriptionTableViewCell
            cell?.configureCell(with: entryModel)
            return cell ?? UITableViewCell()
        case 1:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: Identifier().staticLabelCell, for: indexPath)
            cell2.textLabel?.text = "Place"
            return cell2
        case 2:
            let cell3 = tableView.dequeueReusableCell(withIdentifier: Identifier().locationCell, for: indexPath) as? MapLocationCell
            let query = entryModel.address
            cell3?.configure(with: query)
            return cell3 ?? UITableViewCell()
        default:
            break
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension DetailEntryController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
