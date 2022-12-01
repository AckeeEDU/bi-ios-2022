//
//  Game.swift
//  GamesApp
//
//  Created by Igor Rosocha on 30.11.2022.
//

import Foundation

/// Model of game
struct Game: Identifiable, Codable {
    let id: String
    let title: String
    let rating: Int
    let genre: String
    let review: String
}
