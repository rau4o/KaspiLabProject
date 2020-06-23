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
    
    var viewModel = TableNotesViewModel()
    let addEntryController = AddEntryController()
    let headerView = HeaderView()
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableNotesViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        tableView.layer.backgroundColor = UIColor.cyan.cgColor
        tableView.addShadow()
        return tableView
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        openAddEntry()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getEntries()
    }
    // MARK: - Helper function
    
    private func openAddEntry() {
        headerView.plusAction = { [weak self] in
            guard let self = self else { return }
            self.addEntryController.modalPresentationStyle = .fullScreen
            self.present(self.addEntryController, animated: true, completion: nil)
        }
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
        return viewModel.numberOfData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: TableNotesViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TableNotesViewCell {
            cell.selectionStyle = .none
            cell.addShadow()
            let entryModel = viewModel.getData(at: indexPath.row)
            cell.configureCell(entryModel: entryModel)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let pickUpLine = viewModel.getData(at: indexPath.row)
        
        RealmService.shared.delete(pickUpLine)
        tableView.reloadData()
    }
}

extension TableNotesController: TableNotesDelegate {
    func reloadTableView() {
        tableView.reloadData()
    }
}
