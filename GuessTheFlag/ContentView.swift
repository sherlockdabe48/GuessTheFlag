//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Antarcticaman on 18/6/2564 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var totalScore = 0
    @State private var nameOfFlagButtonTapped = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top ,endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 40) {
                VStack {
                    Text("Choose a flag of country...")
                    Text(countries[correctAnswer])
                        .font(.title)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 2))
                            .shadow(color: .black, radius: 6)
                    }
                }
                
                    Text("Total Scores: \(totalScore) ")
                        .font(.body)
                        .foregroundColor(.white)
                
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("That is the \(nameOfFlagButtonTapped) flag."), dismissButton: .default(Text("Continue")){
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            totalScore += 1
        } else {
            scoreTitle = "Wrong!"
        }
        showingScore = true
        nameOfFlagButtonTapped = countries[number]
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
