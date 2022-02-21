//
//  ViewModifiers.swift
//  GuessTheMusicalInstrument
//
//  Created by Daveed Balcher on 2/20/22.
//

import SwiftUI


// Title Style View Modifier
struct Title: ViewModifier {
    
    func body(content: Content)-> some View {
        content
            .foregroundColor(goldColor)
            .font(Font.title2.weight(.light))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 12)
    }
}
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

// Score Style View Modifier
struct Score: ViewModifier {
    
    func body(content: Content)-> some View {
        content
            .foregroundColor(.white)
            .padding(12)
            .background(.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 12)
    }
}
extension View {
    func scoreStyle() -> some View {
        modifier(Score())
    }
}

