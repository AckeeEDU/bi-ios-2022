//
//  CommentsScreenState.swift
//  FITstagram
//
//  Created by Igor Rosocha on 09.11.2022.
//

import Foundation

enum CommentsScreenState {
    case loading
    case error(Error)
    case comments([Comment])
}
