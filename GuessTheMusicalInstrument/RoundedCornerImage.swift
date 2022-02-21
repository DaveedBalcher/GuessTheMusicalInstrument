//
//  RoundedCornerImage.swift
//  GuessTheMusicalInstrument
//
//  Created by Daveed Balcher on 2/20/22.
//

import SwiftUI

struct RoundedCornerImage: View {
    var name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .resizable()
            .scaledToFit()
            .padding(12)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

