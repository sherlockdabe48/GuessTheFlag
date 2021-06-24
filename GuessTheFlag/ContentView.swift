//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Antarcticaman on 18/6/2564 BE.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: 0, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 60, anchor: .topLeading))
    }
}

struct FlagImage: View {
    let number: Int
    let countries: [String]
    let animationAmount: Double
    let correctFlag: Bool
    
    var body: some View {
        if correctFlag {
            Image(self.countries[number])
                .renderingMode(.original)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 2))
                .shadow(color: .black, radius: 6)
                .rotation3DEffect(
                    .degrees(animationAmount),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
        } else {
            Image(self.countries[number])
                .renderingMode(.original)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 2))
                .shadow(color: .black, radius: 6)
        }
        
        
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var totalScore = 0
    @State private var nameOfFlagButtonTapped = ""
    
    @State private var correctFlag = false
    @State private var isWrong = false
    @State private var animationAmount = 0.0
    
    @State private var bgColor = [Color.blue, Color.black]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: bgColor), startPoint: .top ,endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            
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
                        withAnimation(.spring()) {
                            self.animationAmount += 360
                        }
                    }) {
                        if correctFlag {
                            if number == correctAnswer {
                                FlagImage(number: number, countries: countries,animationAmount: animationAmount, correctFlag: correctFlag)
                            } else {
                                FlagImage(number: number, countries: countries,animationAmount: 0, correctFlag: correctFlag)
                                    .opacity(0.3)
                            }
                        } else if isWrong {
                            if number != correctAnswer {
                                FlagImage(number: number, countries: countries,animationAmount: 0, correctFlag: correctFlag)
                                    .opacity(0.3)
                            } else {
                                    FlagImage(number: number, countries: countries,animationAmount: 0, correctFlag: correctFlag)
                                        .transition(.pivot)
                                        
                                
                            }
                        } else {
                            FlagImage(number: number, countries: countries,animationAmount: 0, correctFlag: correctFlag)
                        }
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
            self.correctFlag = true
            bgColor = [Color.green, Color.black]
        } else {
            scoreTitle = "Wrong!"
            self.correctFlag = false
            withAnimation(
                Animation.interpolatingSpring(stiffness: 30, damping: 1)
                    .delay(0.2)) {
                self.isWrong.toggle()
            }
            bgColor = [Color.red, Color.black]
        }
        showingScore = true
        nameOfFlagButtonTapped = countries[number]
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        self.correctFlag = false
        self.isWrong = false
        bgColor = [Color.blue, Color.black]
        self.animationAmount = 0.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
