//
//  CalendarController.swift
//  MyNotes
//
//  Created by rau4o on 6/19/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarController: UIViewController {
    
    // MARK: - Properties
    
    private(set) var entries: Results<EntryModel>?
    
    private lazy var calendarView: FSCalendar = {
        let calendar = FSCalendar()
        calendar.scrollDirection = .vertical
        calendar.scope = .month
        calendar.dataSource = self
        return calendar
    }()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, yyyy"
        return formatter
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.entries = RealmService.shared.realm.objects(EntryModel.self).sorted(byKeyPath: "date", ascending: false)
        
    }
    // MARK: - Helper function

    private func configureUI() {
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - FSCalendarDataSource

extension CalendarController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {

        let dateString = self.dateFormatter.string(from: date)
        guard let dataArray = entries else {return 0}
        for i in dataArray {
            let date = i.datePrettyString()
            if dateString.contains(date) {
                return 1
            }
        }
        return 0
    }
}
