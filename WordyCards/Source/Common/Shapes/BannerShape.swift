//
//  BannerShape.swift
//  WordyCards
//
//  Created by Sebastian on 11/08/24.
//

import SwiftUI

struct BannerShape:Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addRoundedRect(in: CGRect(x:0, y:0, width: rect.size.width, height: rect.size.height), cornerSize: .init(width: rect.size.height / 2, height: rect.size.height / 2))
        
        path.move(to: CGPoint(x: rect.size.width, y: -rect.size.height / 2 ))
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height / 2 ))
        path.addLine(to: CGPoint(x: rect.size.width - (rect.size.height / 2), y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.size.width, y: -rect.size.height / 2), control: CGPoint(x: rect.size.width, y: 0))
        
        path.move(to: CGPoint(x: rect.size.width - (rect.size.height / 2), y: rect.size.height))
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height / 2))
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height + (rect.size.height / 2)))
        path.addQuadCurve(to: CGPoint(x: rect.size.width - (rect.size.height / 2), y: rect.size.height), control: CGPoint(x: rect.size.width, y: rect.size.height))
        return path
    }
}


#Preview {
    VStack{
    }
    .frame(width: 300, height: 50)
    .background(BannerShape())
}
