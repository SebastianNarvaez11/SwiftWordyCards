//
//  ExerciseItemView.swift
//  WordyCards
//
//  Created by Sebastian on 24/09/24.
//

import SwiftUI

struct ExerciseItemView: View {
    var exercise: ExerciseModel
    
    var body: some View {
        HStack{
            Text(exercise.englishWord)
            Text(exercise.spanishTranslation)
                
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}

#Preview {
    ExerciseItemView(exercise: ExerciseModel(id: "", englishWord: "asdasd", spanishTranslation: "asdasd", image: nil, rating: 1, color: .primary, isDeleted: false))
}
