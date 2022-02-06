//
//  ContentView.swift
//  GuessTheMusicalInstrument
//
//  Created by David Balcher on 2/5/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var totalCorrect = 0
    
    @State private var instruments = ["Alto Flute", "Bass Clarinet", "Celesta", "Contrabassoon", "Euphonium", "Harp", "Oboe", "Organ", "Piano", "Saxophone"].shuffled()
    @State private var removedInstruments: [String] = []
    @State private var correctAnswer = Int.random(in: 0...3)
    
    var body: some View {
        ZStack {
            let lightGray = Color(red: 0.8, green: 0.8, blue: 0.8)
            
            LinearGradient(stops:[
                .init(color: .white, location: 0.23),
                .init(color: lightGray, location: 0.27)
            ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                HStack {
                    Text("Correct Answers: \( totalCorrect)")
                    Spacer()
                }
                .padding(12)
                
                
                HStack(spacing: 12) {
//                    Text("Tap the")
//                        .font(Font.subheadline.weight(.medium))
                    Text("Tap the " + instruments[correctAnswer])
                        .font(Font.title.weight(.bold))
                    Spacer()
                }
                .padding(12)
                
                HStack{
                    ForEach(0..<2) { row in
                        VStack {
                            ForEach(0..<2) { column in
                                let number = row*2 + column
                                Button {
                                    tappedInstrument(number)
                                } label: {
                                    Image(instruments[number])
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                }
                            }
                        }
                    }
                }
                .padding(12)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(12)
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        }
    }
    
    func tappedInstrument(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            totalCorrect += 1
            
            // Remove correctly tapped instrument
            let removed = instruments.remove(at: number)
            removedInstruments.append(removed)
            
            askQuestion()
        } else {
            scoreTitle = "Wrong"
            showingScore = true
        }
    }
    
    func askQuestion() {
        // Add back to array of instruments
        print("removedInstruments: ",removedInstruments.description)
        if removedInstruments.count >= 4 {
            let last = removedInstruments.removeFirst()
            instruments.append(last)
        }
        
        
        instruments.shuffle()
        correctAnswer = Int.random(in: 0...3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
