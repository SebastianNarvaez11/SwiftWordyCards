//
//  GroupDetailModel.swift
//  WordyCards
//
//  Created by Sebastian on 23/09/24.
//

import Foundation

struct GroupDetailModel {
    var id, name, iconName: String
    var maxNumberOfExercisesPerRound: Int
    var exercises: [ExerciseModel]
}

extension GroupDetailModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, name, iconName, maxNumberOfExercisesPerRound, exercises
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.iconName = try container.decode(String.self, forKey: .iconName)
        self.maxNumberOfExercisesPerRound = try container.decode(Int.self, forKey: .maxNumberOfExercisesPerRound)
        self.exercises = try container.decode([ExerciseModel].self, forKey: .exercises)
    }
}
