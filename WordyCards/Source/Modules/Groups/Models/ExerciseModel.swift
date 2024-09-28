//
//  ExerciseModel.swift
//  WordyCards
//
//  Created by Sebastian on 23/09/24.
//

import Foundation
import SwiftUI

enum DeletedFrom {
    case right, left
}

struct ExerciseModel {
    let id, englishWord, spanishTranslation: String
    let image: URL?
    let rating: Int
    //estas props no viene del backend :)
    let color: Color
    var isDeleted: Bool
    var deletedFrom: DeletedFrom?
}

extension ExerciseModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, englishWord, spanishTranslation, image, rating
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.englishWord = try container.decode(String.self, forKey: .englishWord)
        self.spanishTranslation = try container.decode(String.self, forKey: .spanishTranslation)
        self.image = try container.decodeIfPresent(URL.self, forKey: .image)
        self.rating = try container.decode(Int.self, forKey: .rating)
        self.color = .accentColor
        self.isDeleted = false
        self.deletedFrom = nil
    }
}
