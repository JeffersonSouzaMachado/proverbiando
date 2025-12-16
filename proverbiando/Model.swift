//
//  Model.swift
//  proverbiando
//
//  Created by Jefferson Machado on 15/12/25.
//

import Foundation


struct Proverb: Decodable {
    let text: String
    let chapter: Int
    let verse: Int
}


struct BibleApiResponse: Decodable {
    let verses: [BibleVerseDTO]
}

struct BibleVerseDTO: Decodable {
    let chapter: Int
    let verse: Int
    let text: String
}
