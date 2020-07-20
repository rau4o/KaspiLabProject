//
//  CustomDatePicker+Extension.swift
//  MyNotes
//
//  Created by rau4o on 6/21/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

//import UIKit
////import SBDropDown
//
//// MARK: - SBDateProtocol
//
//extension AddEntryController: SBDateProtocol {
//    
//    func didSBDateValueChanged(date: Date, key: Any?) {
//        guard let txtf = key as? UITextField else { return }
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MMM-yyyy HH:MM"
//        let strDate = dateFormatter.string(from: date)
//        
//        switch txtf {
//        case addEntryView.dateTextField:
//            addEntryView.dateTextField.text = strDate
//        default:
//            break
//        }
//    }
//    
//    func btnSBSelectPressed(date: Date, key: Any?) {
//        guard let txtf = key as? UITextField else { return }
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MMM-yyyy HH:MM"
//        let strDate = dateFormatter.string(from: date)
//        
//        switch txtf {
//        case addEntryView.dateTextField:
//            addEntryView.dateTextField.text = strDate
//        default:
//            break
//        }
//    }
//}
//
//// MARK: - UITextFieldDelegate
//
//extension AddEntryController: UITextFieldDelegate {
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        isCallSetUP = true
//        
//        switch textField {
//            
//        case addEntryView.dateTextField:
//            let strDate = (addEntryView.dateTextField.text ?? "").isEmpty ? "01-08-2019 00:00" : (addEntryView.dateTextField.text ?? "")
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
//            if let date = dateFormatter.date(from: strDate) {
//                SBDropDown.shared.arrowDirection = .down
//                var cgFrame = textField.bounds
//                cgFrame.size.height = 280.0
//                self.showSBDatePicker(strTitle: "CREATED ON", currentDate: date, minDate: date, maxDate: nil, sourceView: textField, sourceRect: cgFrame, key: textField)
//            }
//        default:
//            break
//        }
//        return false
//    }
//} 
//
