//
//  UserDefaults.swift
//  Budget Manager
//
//  Created by Ye Yint Aung on 16/01/2023.
//

import Foundation

let signdefault = UserDefaults.standard

func setSignDefault(sign: String){
    signdefault.set(sign, forKey: "sign")
}

func removeDefault(){
    signdefault.removeObject(forKey: "sign")
}
