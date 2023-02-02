//
//  RecordVO.swift
//  Budget Manager
//
//  Created by Ye Yint Aung on 13/01/2023.
//

import Foundation

struct RecordVO {
    var type: RecordType
    var id: String
    var amount: Double
    var description: String
    var category: String
}

enum RecordType: String {
    case income = "income"
    case expense = "expense"
}
