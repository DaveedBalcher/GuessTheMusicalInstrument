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
    
    private let goldColor = Color(red: 148/255, green: 130/255, blue: 80/255)
    private let longScreen = UIScreen.ratio > 2.0
    
    
    var body: some View {
        ZStack {
            
            goldColor
                .opacity(0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                if longScreen {
                    Spacer()
                }
                Spacer()
                
                Text("What Musical Instrument?")
                    .foregroundColor(goldColor)
                    .font(Font.title2.weight(.light))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 12)
                
                HStack {
                    Text("Current Streak: \( currentStreak)")
                        .foregroundColor(.white)
                        .padding(12)
                        .background(.secondary)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal, 12)
                }
                
                if longScreen {
                    Spacer()
                }
                Spacer()
                
                
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
                                    Button {
                                        tappedInstrument(number)
                                    } label: {
                                        Image(instruments[number])
                                            .renderingMode(.original)
                                            .resizable()
                                            .scaledToFit()
                                            .padding(12)
                                            .background(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }
                                }
                            }
                        }
                    }
//                    .padding(12)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.white.opacity(0.33))
                
                if longScreen {
                    Spacer()
                }
                
                Text("© Daveed Balcher 2022")
                    .foregroundColor(.white)
                    .font(Font.body.weight(.light))
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        }
    }
    
    func tappedInstrument(_ number: Int) {
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
