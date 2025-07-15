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
            KeyboardView()
        }.onReceive(
            model.$data,
            perform: { data in
                
                if engine.wordOfTheDay.isEmpty {
                    var randomNumber = SystemRandomNumberGenerator()
                    if data.count > 0 {
                        let words = data.split(separator: "\n")
                        let wordsCount = words.count
                        if wordsCount > 0 {
                            let number = randomNumber.next(
                                upperBound: UInt(wordsCount)
                            )

                            let wordOfTheDay = words[Int(number)]
                            engine.save(newWordOfTheDay: String(wordOfTheDay))
                        }

                    }
                }

            }
        ).environmentObject(engine)
    }
}

#Preview {
    ContentView()
}
