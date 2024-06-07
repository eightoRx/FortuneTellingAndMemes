//
//  Model.swift
//  Fortune telling and memes
//
//  Created by Pavel Kostin on 05.06.2024.
//

import Foundation


// MARK: - Welcome
struct Welcome: Decodable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Decodable {
    let memes: [Meme]
}

// MARK: - Meme
struct Meme: Decodable {
    let id: String
    let name: String
    let url: URL
    
}
