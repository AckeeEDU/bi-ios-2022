//
//  Comment.swift
//  FITstagram
//
//  Created by Igor Rosocha on 19.10.2022.
//

import Foundation

struct Comment: Identifiable {    
    let id: String = UUID().uuidString
    let username: String
    let text: String
}
