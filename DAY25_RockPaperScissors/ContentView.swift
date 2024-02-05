//  ContentView.swift
//  DAY25_RockPaperScissors
//
//  Created by Vladyslav Dikhtiaruk on 03/02/2024.
//

import SwiftUI

struct ContentView: View {
    let options = ["Rock", "Paper", "Scissors"]
    @State private var appChoice : String = ""
    @State private var appImageChoice = ""
    @State private var userChoice = "Choose"
    @State private var userImageChoice = ""
    @State private var isWin = ""
    @State private var score = 0
    @State private var isGameStarted = false
    @State private var isAlertStart = false
    @State private var alertTitleStart = ""
    @State private var alertTitleResult = ""
    @State private var isAlertFinish = false

    var body: some View {
        ZStack{
            RadialGradient(
                colors: [.black, .green],
                center: .topTrailing,
                startRadius: 100, endRadius: 1000
            )
            .ignoresSafeArea()
            
            VStack {
                Text("Rock Paper Scissors")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.linearGradient(colors: [.secondary, .green], startPoint: .bottomLeading, endPoint: .topTrailing))
                if isGameStarted {
                    Text("Score: \(score)")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.linearGradient(colors: [.secondary, .green], startPoint: .bottomLeading, endPoint: .topTrailing))
                }
                
                Spacer()
                
                if !isGameStarted {
                    Button {
                        // Start Game
                        withAnimation {
                            isGameStarted = true
                        }
                        pressedStartAlert()
                        isAlertStart = true
                        appChoice = appRandomChoiceRockPaperScissors()
                    } label: {
                        Label("Start the Game", systemImage: "gamecontroller")
                            .labelStyle(.automatic)
                            .font(.largeTitle)
                            .padding()
                            .foregroundStyle(.black.opacity(0.4))
                            .background(.ultraThinMaterial)
                            .clipShape(.capsule)
                    }
                } else {
                    HStack(spacing: 40){
                            VStack{
                                Image(systemName: userImageChoice)
                                Text(userChoice)
                            }       
                            .frame(maxWidth: 140, maxHeight: 120)
                            .font(.largeTitle)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(.buttonBorder)
                            .onChange(of: userChoice, updateUserImageChoice)

                            VStack{
                                Image(systemName: appImageChoice)
                                Text(appChoice)
                            }
                            .frame(maxWidth: 140, maxHeight: 120)
                            .font(.largeTitle)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(.buttonBorder)
                            .onChange(of: appChoice, updateAppImageChoice)

                        }
                    
                    Spacer()
                    
                    HStack(spacing: 10) {
                        PaperRockScissors(
                            userChoiceText: "Rock",
                            usChImage: "mountain.2",
                            getAppChoice: appRandomChoiceRockPaperScissors
                        ) {
                            userChoice = "Rock"
                            print("is \(userChoice)")
                            checkResult()
                            checkFinalResult()
                        }
                        
                        PaperRockScissors(
                            userChoiceText: "Paper",
                            usChImage: "newspaper",
                            getAppChoice: appRandomChoiceRockPaperScissors
                        ){
                            userChoice = "Paper"
                            print("is \(userChoice)")
                            checkResult()
                            checkFinalResult()
                        }
                        
                        PaperRockScissors(
                            userChoiceText: "Scissors",
                            usChImage: "scissors",
                            getAppChoice: appRandomChoiceRockPaperScissors
                        ){
                            userChoice = "Scissors"
                            print("is \(userChoice)")
                            checkResult()
                            checkFinalResult()
                            
                        }
                    }
                    .transition(.scale)
                }
            }
            .alert(alertTitleStart, isPresented: $isAlertStart) {
                Button("Continue", action: pressedStartAlert)
            } message: {
                Text("Your score is \(score)")
            }
            .alert(alertTitleResult, isPresented: $isAlertFinish) {
                Button("Start new Game", action: {
                    score = 0
                } )
            } message: {
                Text("Your score is \(score)")
            }
            .padding()
        }
    }
    func appRandomChoiceRockPaperScissors() -> String {
        let randomChoice = Int.random(in: 0...2)
        appChoice = options[randomChoice]
        return appChoice
    }
    func pressedStartAlert() {
        alertTitleStart = "Good luck!"
    }
    func checkResult(){ // good
        if (appChoice == "Rock" &&  userChoice == "Paper") ||
            (appChoice == "Paper" && userChoice == "Scissors") ||
            (appChoice == "Scissors" && userChoice == "Rock") {
            score += 1
            print("User won!")
        } else if (appChoice == "Rock" &&  userChoice == "Rock") ||
                    (appChoice == "Paper" && userChoice == "Paper") ||
                    (appChoice == "Scissors" && userChoice == "Scissors") {
            print("Draw")
        }
        else {
            score -= 1
            print("User lost!")
        }
    }
    func updateUserImageChoice() {
            if userChoice == "Rock" {
                userImageChoice = "mountain.2"
            } else if userChoice == "Paper" {
                userImageChoice = "newspaper"
            } else if userChoice == "Scissors" {
                userImageChoice = "scissors"
            }
    }
    func updateAppImageChoice() {
        if appChoice == "Rock" {
            appImageChoice = "mountain.2"
        } else if appChoice == "Paper" {
            appImageChoice = "newspaper"
        } else if appChoice == "Scissors" {
            appImageChoice = "scissors"
        }
    }
    func checkFinalResult() {
        if score == 5 {
            alertTitleResult = "Congratulations, you won this Game!!!"
        } else if score == -5 {
            alertTitleResult = "Broski, you lost this Game!!!"
        } else {
            return
        }
        
        isAlertFinish = true
    }
}

#Preview {
    ContentView()
}

struct PaperRockScissors: View {
    var userChoiceText: String
    var usChImage: String
    var getAppChoice: () -> String
    var setUserChoice: () -> Void

    var body: some View {
        Button{
            let randomOption = getAppChoice()
            print("User choice is: \(userChoiceText)")
            print("App choice is: \(randomOption)")
            setUserChoice()
        } label: {
            VStack{
                Image(systemName: usChImage)
                Text(userChoiceText)
            }
        }
        .frame(maxWidth: 80, maxHeight: 75)
        .foregroundStyle(.white)
        .font(.title3)
        .bold()
        .padding()
        .background(.secondary)
        .clipShape(.circle)
    }
}



