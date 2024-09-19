//
//  GroupModel.swift
//  WordyCards
//
//  Created by Sebastian on 12/08/24.
//

import Foundation

struct GroupModel {
    let id: String
    let name:String
    let iconName:String
    let countEasy:Int
    let countExercises: Int
}


extension GroupModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, name, iconName
        case countEasy = "_countEasy"
        case countExercises = "_count"
    }
    
    enum CountExercisesKeys: String, CodingKey {
        case exercises
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.iconName = try container.decode(String.self, forKey: .iconName)
        self.countEasy = try container.decode(Int.self, forKey: .countEasy)
        let countExerciseContainer = try container.nestedContainer(keyedBy: CountExercisesKeys.self, forKey: .countExercises)
        self.countExercises = try countExerciseContainer.decode(Int.self, forKey: .exercises)
    }
}
