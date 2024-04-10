//
//  DataModel.swift
//  Charts-SwiftUI
//
//  Created by Janarthanan Kannan on 09/04/24.
//

import SwiftUI

struct DataModel: Identifiable {
    
    //MARK: - Constants
    var id: UUID = .init()
    var date: Date
    var value: Double
    var isAnimated: Bool = false
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: date)
    }
}

var dataList: [DataModel] = [
    .init(date: .createDate(1, 1, 2023), value: 1000),
    .init(date: .createDate(4, 2, 2023), value: 1500),
    .init(date: .createDate(2, 3, 2023), value: 3000),
    .init(date: .createDate(8, 4, 2023), value: 8000),
    .init(date: .createDate(12, 5, 2023), value: 1800),
    .init(date: .createDate(19, 6, 2023), value: 4900),
    .init(date: .createDate(23, 7, 2023), value: 2800),
    .init(date: .createDate(28, 8, 2023), value: 7300)
]

extension Date {
    static func createDate(_ day: Int, _ month: Int, _ year: Int) -> Date {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        
        let calendar = Calendar.current
        let date = calendar.date(from: components) ?? .init()
        return date
    }
}
