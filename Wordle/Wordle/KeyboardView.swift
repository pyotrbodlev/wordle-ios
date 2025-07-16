//
//  KeyboardView.swift
//  Wordle
//
//  Created by Pyotr on 15.07.25.
//

import SwiftUI

struct KeyboardView: View {
    @State var suggestion: String = ""
    @State var showingAler: Bool = false
    @State var alertMessage: LocalizedStringKey = ""
    @State var fullList: [String] = []
    @State var gameOver: Bool = false
    @EnvironmentObject var engine: GameEngine

    var body: some View {
        if gameOver {
            VStack {
                Button(
                    "New game",
                    action: {
                        engine.clearCache()
                        gameOver = false
                    }
                ).buttonStyle(.bordered)
            }
        } else {
            VStack(alignment: .center, spacing: 40) {
                TextField("Enter your suggestion", text: $suggestion)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(20)
                Button(
                    "Submit",
                    action: {
                        if suggestion.count != 5 {
                            alertMessage = "Word must be 5 letter"
                            showingAler = true
                            suggestion = ""
                            return
                        }

                        if wordDoNotExist(
                            suggestion: suggestion,
                            fullList: engine.fullList
                        ) {
                            alertMessage = "Wrong word"
                            showingAler = true
                            suggestion = ""
                            return
                        }

                        engine.addWord(newWord: suggestion)
                        suggestion = ""
                    }
                ).alert(
                    alertMessage,
                    isPresented: $showingAler,
                    actions: {
                        Button("OK") {}
                    }
                ).buttonStyle(
                    .bordered
                )

            }.onReceive(
                engine.$fullList,
                perform: { data in
                    fullList = data
                }
            ).onReceive(
                engine.$gameOver,
                perform: { isOver in
                    gameOver = isOver
                }
            )
        }
    }
}

func wordDoNotExist(suggestion: String, fullList: [String]) -> Bool {
    return !fullList.contains(suggestion.uppercased())
}

#Preview {
    KeyboardView().environmentObject(GameEngine())
}
