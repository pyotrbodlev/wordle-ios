//
//  WordsView.swift
//  Wordle
//
//  Created by Pyotr on 15.07.25.
//

import SwiftUI

struct WordsView: View {
    @EnvironmentObject var engine: GameEngine
    @State var gameOver: Bool = false
    @State var wordOfTheDay: String = ""
    
    var body: some View {
        VStack {
            ForEach(engine.wordList, id: \.hashValue) { word in
                SingleWordView(suggestedWord: word)
            }
            
            if gameOver {
                Text("Correct word is " + engine.wordOfTheDay)
            }
        }.onReceive(engine.$gameOver, perform: { isOver in
            gameOver = isOver
        }).onReceive(engine.$wordOfTheDay, perform: { word in
            wordOfTheDay = word
        })
        
    }
}

#Preview {
    WordsView()
}
