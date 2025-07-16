//
//  SingleWordView.swift
//  Wordle
//
//  Created by Pyotr on 15.07.25.
//

import SwiftUI

struct SingleWordView: View {
    @State var suggestedWord: String = ""
    @State var wordOfTheDay: String = ""
    @EnvironmentObject var engine: GameEngine

    var body: some View {
        HStack(alignment: .top) {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(lineWidth: 3).background(
                        getColor(
                            currentWord: suggestedWord.uppercased(),
                            wordOfTheDay: wordOfTheDay.uppercased(),
                            index: 0
                        )
                    )
                Text(suggestedWord.split(separator: "")[0].uppercased())
            }
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(lineWidth: 3).background(
                        getColor(
                            currentWord: suggestedWord.uppercased(),
                            wordOfTheDay: wordOfTheDay.uppercased(),
                            index: 1
                        )
                    )
                Text(suggestedWord.split(separator: "")[1].uppercased())
            }
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(lineWidth: 3).background(
                        getColor(
                            currentWord: suggestedWord.uppercased(),
                            wordOfTheDay: wordOfTheDay.uppercased(),
                            index: 2
                        )
                    )
                Text(suggestedWord.split(separator: "")[2].uppercased())
            }
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(lineWidth: 3).background(
                        getColor(
                            currentWord: suggestedWord.uppercased(),
                            wordOfTheDay: wordOfTheDay.uppercased(),
                            index: 3
                        )
                    )
                Text(suggestedWord.split(separator: "")[3].uppercased())
            }
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(lineWidth: 3).background(
                        getColor(
                            currentWord: suggestedWord.uppercased(),
                            wordOfTheDay: wordOfTheDay.uppercased(),
                            index: 4
                        )
                    )
                Text(suggestedWord.split(separator: "")[4].uppercased())
            }
        }.frame(height: 70).padding(20).onReceive(
            engine.$wordOfTheDay,
            perform: { word in
                self.wordOfTheDay = word
            }
        )
    }
}

func getColor(currentWord: String, wordOfTheDay: String, index: Int) -> Color {
    if wordOfTheDay == "" || currentWord == "" {
        return Color.gray
    }

    let currentLetter = currentWord.split(separator: "")[index].uppercased()
    let wordOfTheDayLetter = wordOfTheDay.split(separator: "")[index].uppercased()

    if currentLetter == wordOfTheDayLetter {
        return Color.green
    }
    
    if wordOfTheDay.contains(currentLetter) {
        return Color.orange
    }
    
    return Color.gray
}

#Preview {
    SingleWordView(suggestedWord: "testi").environmentObject(GameEngine())
}
