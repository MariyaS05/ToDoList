//
//  Dates+Ext.swift
//  ToDoList
//
//  Created by Мария  on 10.08.23.
//

import Foundation

extension Date {
    func convertToDayMonthYearFormat()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }
    func convertToHourMinute()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }

}
