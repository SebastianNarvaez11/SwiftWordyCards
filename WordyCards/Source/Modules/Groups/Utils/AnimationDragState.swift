//
//  AnimationDragState.swift
//  WordyCards
//
//  Created by Sebastian on 25/09/24.
//

import Foundation

enum AnimationDragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
        
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive, .pressing:
            return false
        case .dragging:
            return true
        }
    }
    
    var isPressing: Bool {
        switch self {
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }
}
