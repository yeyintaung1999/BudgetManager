//
//  DummyData.swift
//  Budget Manager
//
//  Created by Ye Yint Aung on 13/01/2023.
//

import Foundation

class DummyData{
    static var dummy = [
        RecordVO(type: .income, id: "1", amount: 190000.00, description: "Description", category: "Shopping"),
        RecordVO(type: .income, id: "2", amount: 20000.00, description: "Description", category: "Shopping"),
        RecordVO(type: .income, id: "3", amount: 210000.00, description: "Description", category: "Shopping"),
        RecordVO(type: .income, id: "4", amount: 20000.00, description: "Description", category: "food"),
        RecordVO(type: .expense, id: "5", amount: 25000.00, description: "Description", category: "Shopping"),
        RecordVO(type: .income, id: "6", amount: 20000.00, description: "Description", category: "Shopping"),
        RecordVO(type: .income, id: "7", amount: 20000.00, description: "Description", category: "Shopping"),
        RecordVO(type: .income, id: "8", amount: 20000.00, description: "Description", category: "merchandise"),
        RecordVO(type: .expense, id: "9", amount: 20000.00, description: "Description", category: "Shopping"),
        RecordVO(type: .income, id: "10", amount: 20000.00, description: "Description", category: "Shopping"),
        RecordVO(type: .expense, id: "11", amount: 20000.00, description: "Description", category: "Shopping"),
        RecordVO(type: .income, id: "12", amount: 20000.00, description: "Description", category: "Shopping"),
        RecordVO(type: .expense, id: "13", amount: 20000.00, description: "Description", category: "Shopping"),
        RecordVO(type: .income, id: "14", amount: 20000.00, description: "Description", category: "Shopping"),
        RecordVO(type: .income, id: "15", amount: 20000.00, description: "Description", category: "Shopping")
    ]
}


var incomeCategories = [
    "Salary",
    "Pocket Money",
    "Refund",
    "Award"
]

var expenseCategories = [
    "Shopping",
    "Food",
    "Transportation",
    "Bills"
]
