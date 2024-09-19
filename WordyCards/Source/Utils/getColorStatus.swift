//
//  getColorStatus.swift
//  WordyCards
//
//  Created by Sebastian on 13/08/24.
//

import Foundation
import SwiftUI

func getColorStatus (countEasy:Int, total:Int) -> Color {
    
    let percentage: Double = (Double(countEasy) * 100.0) / Double(total)
        
    switch percentage {
    case 0...30:
        return .danger
        
    case 31...60:
        return .warning
        
    case 61...89:
        return .info
        
        
    default:
        return .success
    }
    
}
