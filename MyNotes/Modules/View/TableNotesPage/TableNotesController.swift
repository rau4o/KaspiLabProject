//
//  TableNotesController.swift
//  MyNotes
//
//  Created by rau4o on 6/16/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class TableNotesController: UIViewController {
    
    // MARK: - Properties
    
    var entries: [EntryModel] = []
    
    let headerView = HeaderView()
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableNotesViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

// MARK: - Initial Setup Views

private extension TableNotesController {
    func initialSetup() {
        layoutUI()
        stylizeView()
    }
    
    private func stylizeView() {
        view.backgroundColor = .white
        headerView.backgroundColor = .mainBlue
    }
    
    private func layoutUI() {
        [headerView, tableView].forEach {
            view.addSubview($0)
        }
        
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate

extension TableNotesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

// MARK: - UITableViewDataSource

extension TableNotesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: TableNotesViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TableNotesViewCell {
            cell.selectionStyle = .none
//            let entryModel = entries[indexPath.row]
            cell.addShadow()
//            cell.configureCell(entryModel: entryModel)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
