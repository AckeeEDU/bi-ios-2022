//
//  Post.swift
//  FITstagram
//
//  Created by Igor Rosocha on 12.10.2022.
//

import Foundation

typealias User = Author

struct Author: Hashable {
    let id: String
    let username: String
}

extension Author: Codable { }

struct Post: Identifiable, Hashable {
    let id: String
    let likes: Int
    let photos: [String]
    let description: String
    let comments: Int
    let author: Author
}

extension Post: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case likes
        case photos
        case description = "text"
        case comments = "numberOfComments"
        case author
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        let likes = try container.decode([String].self, forKey: .likes)
        self.likes = likes.count
        photos = try container.decode([String].self, forKey: .photos)
        description = try container.decode(String.self, forKey: .description)
        comments = try container.decode(Int.self, forKey: .comments)
        author = try container.decode(Author.self, forKey: .author)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(likes, forKey: .likes)
        try container.encode(photos, forKey: .photos)
        try container.encode(description, forKey: .description)
        try container.encode(comments, forKey: .comments)
        try container.encode(author, forKey: .author)
    }
}
