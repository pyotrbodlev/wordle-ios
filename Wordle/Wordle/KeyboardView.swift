//
//  KeyboardView.swift
//  Wordle
//
//  Created by Pyotr on 15.07.25.
//

import SwiftUI

struct KeyboardView: View {
    @State var suggestion: String = ""
    @EnvironmentObject var engine: GameEngine
    
    var body: some View {
        TextField("Enter your suggestion", text: $suggestion);
        Button("Submit", action: {
            if (suggestion.count != 5) {
                return
            }
            engine.addWord(newWord: suggestion)
            suggestion = ""
        })
        Button("Clear cache", action: {
            engine.clearCache()
        })
    }
}

#Preview {
    KeyboardView()
}
