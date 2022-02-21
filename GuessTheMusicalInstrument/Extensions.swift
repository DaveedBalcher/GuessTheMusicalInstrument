//
//  Extensions.swift
//  GuessTheMusicalInstrument
//
//  Created by David Balcher on 2/8/22.
//

import SwiftUI

extension UIScreen {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let size = UIScreen.main.bounds.size
    static let ratio = UIScreen.main.bounds.size.height / UIScreen.main.bounds.size.width
}

extension Spacer {
    
    func responsive(spacers: Int = 1) -> some View  {
        responsiveSpacer(spacers: spacers)
    }
}

private struct responsiveSpacer: View {
    var spacers: Int = 1
    
    var body: some View  {
        ForEach(0..<spacers, id: \.self) { _ in
            Spacer()
        }
        
        if UIScreen.ratio > 2.0 {
            Spacer()
        }
    }
}
