//
//  Date+Format.swift
//  MCD
//
//  Created by Weiyi Kong on 16/8/2022.
//

import Foundation

extension Date {
    private static let formater: DateFormatter = {
        let formater = DateFormatter()
        formater.dateFormat = "MMM d, yyyy 'at' hh:mm:ss a"
        return formater
    }()

    func customFormatted() -> String {
        return Date.formater.string(from: self)
    }
}
