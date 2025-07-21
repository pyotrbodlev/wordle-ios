//
//  ContentView.swift
//  Wordle
//
//  Created by Pyotr on 11.07.25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: TextFileReaderModel = TextFileReaderModel(
        filename: "words"
    )
    @StateObject var engine = GameEngine()

    var body: some View {
        VStack {
            WordsView()
            Spacer()
            KeyboardView()
        }.onReceive(
            model.$data,
            perform: { data in
                
                if data.count > 0 {
                    let words = data.split(separator: "\n").map({ item in
                        return String(item)
                    })
                    engine.saveAllWords(fullList: words)
                    if engine.wordOfTheDay.isEmpty {
                        engine.generateNewWordOfTheDay()
                    }
                }
            }
        ).environmentObject(engine)
    }
}

#Preview {
    ContentView()
}
