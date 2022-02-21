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
    @State private var currentStreak = 0
    
    @State private var instruments = ["Alto Flute", "Bass Clarinet", "Bass Drum", "Celesta", "Cello", "Contrabassoon", "Double Bass", "Euphonium", "French Horn", "Harp", "Marimba", "Oboe", "Organ", "Piano", "Piccolo", "Saxophone", "Snare Drum", "Timpani", "Trombone", "Trumpet", "Tuba", "Viola", "Violin", "Xylophone"].shuffled()
    @State private var removedInstruments: [String] = []
    @State private var correctAnswer = Int.random(in: 0...3)
    
    private let audioQueue = AudioQueue.shared

    
    var body: some View {
        ZStack {
            
            goldColor
                .opacity(0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Spacer()
                    .responsive()
                
                Text("Musical Instrument Quiz")
                    .titleStyle()
                
                HStack {
                    Text("Current Streak: \( currentStreak)")
                        .scoreStyle()
                }
                
                Spacer()
                    .responsive()
                
                VStack {
                    
                    HStack(spacing: 12) {
                        Text("Tap the " + instruments[correctAnswer])
                            .font(Font.title2.weight(.semibold))
                    }
                    .padding(.horizontal, 12)
                    
                    HStack{
                        ForEach(0..<2) { row in
                            VStack {
                                ForEach(0..<2) { column in
                                    let number = row*2 + column
                                    RoundedCornerImage(name: instruments[number])
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.white.opacity(0.33))
                
                Spacer()
                    .responsive(spacers: 0)
                
                Text("© Daveed Balcher 2022")
                    .foregroundColor(.white)
                    .font(Font.body.weight(.light))
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        }
    }
    
    func tapInstrument(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            currentStreak += 1
            
            // Remove correctly tapped instrument
            let removed = instruments.remove(at: number)
            removedInstruments.append(removed)
            
            askQuestion()
        } else {
            
            audioQueue.playSadTombone()
            
            scoreTitle = "Wrong, you tapped the \(instruments[number])"
            currentStreak = 0
            showingScore = true
        }
    }
    
    func askQuestion() {
        // Add back to array of instruments
//        print("removedInstruments: ",removedInstruments.description)
        if removedInstruments.count >= instruments.count - 4 {
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
