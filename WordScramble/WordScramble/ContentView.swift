//
//  ContentView.swift
//  WordScramble
//
//  Created by @binoooh on 5/2/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var rootWord = ""
    @State private var answerWord = ""
    
    @State private var score = 0 // Day 31 Challenge
    @State private var timeRemaining = 60 // Initial Time
    @State private var isRunning = true
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false
    @State private var resetGame = false // Day 31 Challenge
    
    @FocusState private var isTextFieldFocused: Bool
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        NavigationStack {
            // Implemented Countdown Timer
            VStack {
                Section {
                    Text("\(timeRemaining)")
                        .font(.system(size: 30, design: .monospaced))
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .onReceive(timer) { _ in
                            if isRunning && !resetGame && timeRemaining > 0 {
                                timeRemaining -= 1
                            } else if timeRemaining == 0 && isRunning {
                                isRunning = false
                                resetGame = true
                            }
                        }
                }
            }
            .padding()
            .navigationBarTitle("Time".uppercased(), displayMode: .inline)
            
            HStack {
                // Adds the rootword
                Text(rootWord)
                    .font(.largeTitle.bold())
                Spacer()
                Button {
                    resetGame = true
                } label: {
                    Image(systemName: "gamecontroller").foregroundStyle(.black)
                    Text("Play Again")
                }
                .buttonStyle(.bordered)
            }
            .padding(30)
        
            VStack {
                List {
                    Section {
                        TextField(
                            "Enter your word",
                            text: $newWord
                        )
                        .focused($isTextFieldFocused)
                        .textInputAutocapitalization(
                            .never
                        )
                    }
                    
                    Section {
                        ForEach(
                            usedWords,
                            id: \.self
                        ) { word in
                            HStack {
                                Image(
                                    systemName: "\(word.count).circle"
                                )
                                Text(
                                    word
                                )
                                .font(.title2.bold())
                            }
                        }
                    }
                }
                // This adds a new word to the list
                // when the player presses enter on the keyboard
                .onSubmit(
                    addNewWord
                )
                // This initializes the game
                // with a new word from start.txt
                .onAppear(
                    perform: startGame
                )
                
            }
            VStack {
                // Day 31 Challenge
                Section {
                    VStack {
                        Text("Your Score")
                            .font(.title3.bold())
                            .foregroundStyle(.blue)
                        Text("\(score)")
                            .font(.system(size: 60, weight: .bold))
                            .padding(5)
                    }
                    .padding(30)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .alert(errorTitle, isPresented: $showError) {
            Button {
                newWord = ""
                // Refocus the TextField
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isTextFieldFocused = true
                }
            } label: {
                Text("OK")
            }
        } message: {
            Text(errorMessage)
        }
        .alert("Start a New Game?", isPresented: $resetGame) {
            Button {
                playAgain()
            } label: {
                Text("Yes")
            }
            Button { } label: {
                Text("No")
            }
        }
        
    }
    
    // Day 31 Challenge - Add a way to play again
    func playAgain() {
        // Reset Timer
        timeRemaining = 60
        // Reset List
        usedWords.removeAll()
        // Reset score
        score = 0
        // Reset isRunning flag
        isRunning = true
        // Start a new game
        startGame()
    }
    
    // Day 31 Challenge - Add scoring system
    func getScore(word: String) -> Int {
        
        switch(word.count) {
        case 1...2:
            return 0
        case 3...5:
            return 2
        case 6...7:
            return 5
        default:
            return 8
        }
    }
    
    func addNewWord() {
        
        let answer = newWord.lowercased().trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        // Check if answer is greater than 2 characters
        // Day 31 Challenge
        guard isValidCount(word: answer) else {
            wordError(title: "Word is too short", message: "Make it longer!")
            return
        }
        // Check if answer is not the same with the root word
        // Day 31 Challenge
        guard isNotOriginal(word: answer) else {
            wordError(title: "Word is the same as '\(rootWord)'", message: "You can't use that word, try again!")
            return
        }
        // Check if answer was not used already used
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        // Check if answer has a correct spelling
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'")
            return
        }
        // Check if answer is a valid word
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords
                .insert(
                    answer,
                    at: 0
                )
        }
        
        // Day 31 Challenge - Add Scoring system
        withAnimation(.easeIn(duration: 0.5)) {
            score += getScore(word: answer)
        }
        
        // Refocus the TextField
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isTextFieldFocused = true
        }
        
        newWord = ""
    }
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(
            forResource: "start",
            withExtension: "txt"
        ) {
            // 2. Load start.txt into a string
            if let startWords = try? String(
                contentsOf: startWordsURL,
                encoding: .ascii
            ) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(
                    separatedBy: "\n"
                )
                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                // If we are here everything has worked, so we can exit
                return
            }
        }
        
        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError(
            "Could not load start.txt from bundle."
        )
    }
    
    // Day 31 Challenge - Disallow if answers shorter < 2 chars
    func isValidCount(word: String) -> Bool {
        guard word.count > 2 else {
            return false
        }
        return true
    }
    // Day 31 Challenge - Disallow if answer is the same with the rootWord
    func isNotOriginal(word: String) -> Bool {
        guard rootWord != word else {
            return false
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(
            location: 0,
            length: word.count
        )
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showError = true
    }
    
}

#Preview {
    ContentView()
}
