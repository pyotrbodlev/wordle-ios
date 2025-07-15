//
//  WordsView.swift
//  Wordle
//
//  Created by Pyotr on 15.07.25.
//

import SwiftUI

struct WordsView: View {
    @EnvironmentObject var engine: GameEngine
    
    var body: some View {
        ForEach(engine.wordList, id: \.hashValue) { word in
            SingleWordView(suggestedWord: word)
        }
    }
}

#Preview {
    WordsView()
}
