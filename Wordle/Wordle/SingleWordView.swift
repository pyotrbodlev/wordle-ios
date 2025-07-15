//
//  SingleWordView.swift
//  Wordle
//
//  Created by Pyotr on 15.07.25.
//

import SwiftUI

struct SingleWordView: View {
    @State var suggestedWord: String = ""
    @EnvironmentObject var engine: GameEngine
    
    var body: some View {
        HStack(alignment: .top) {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(lineWidth: 3)
                Text(suggestedWord.split(separator: "")[0].uppercased())
            }
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                        .stroke(lineWidth: 3)
                Text(suggestedWord.split(separator: "")[1].uppercased())
            }
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                        .stroke(lineWidth: 3)
                Text(suggestedWord.split(separator: "")[2].uppercased())
            }
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                        .stroke(lineWidth: 3)
                Text(suggestedWord.split(separator: "")[3].uppercased())
            }
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                        .stroke(lineWidth: 3)
                Text(suggestedWord.split(separator: "")[4].uppercased())
            }
        }.frame(height: 70).padding(20)
    }
}

#Preview {
    SingleWordView(suggestedWord: "testi")
}
