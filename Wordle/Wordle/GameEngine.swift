//
//  WordUtils.swift
//  Wordle
//
//  Created by Pyotr on 15.07.25.
//

import Foundation
import SwiftUICore

class GameEngine: ObservableObject {
    @Published var wordList: [String] = []
    @Published var wordOfTheDay: String
    @Published var expireDate: Date = Date()
    private let currentDate: Date = Date()
    private let wordOfTheDayKey = "WORD_OF_THE_DAY"
    private let wordListKey = "WORD_LIST"
    private let expireDateKey = "EXPIRE_DATE"
    private var resetCache = false

    init() {
        if let expireDateStr = UserDefaults.standard.value(
            forKey: expireDateKey
        ) {
            if let expireDate = decodeDate(dateStr: expireDateStr as! String) {
                if currentDate > expireDate {
                    let expireDate = getNewDate().toString()
                    UserDefaults.standard
                        .set(expireDate, forKey: expireDateKey)
                    resetCache = true

                }
            } else {
                let expireDate = getNewDate().toString()
                UserDefaults.standard
                    .set(expireDate, forKey: expireDateKey)
                resetCache = true

            }

        } else {
            let expireDate = getNewDate().toString()
            UserDefaults.standard
                .set(expireDate, forKey: expireDateKey)
            resetCache = true

        }

        if !resetCache {
            let decoder = JSONDecoder()

            if let word = UserDefaults.standard.value(forKey: wordOfTheDayKey) {
                do {
                    let wordStr = try decoder.decode(
                        String.self,
                        from: word as! Data
                    )

                    
                    self.wordOfTheDay = wordStr
                } catch {
                    self.wordOfTheDay = ""
                    
                }
            } else {
                self.wordOfTheDay = ""
                
            }

            if let wordListJSON = UserDefaults.standard.value(
                forKey: wordListKey
            ) {

                do {
                    let wordList = try decoder.decode(
                        Array<String>.self,
                        from: wordListJSON as! Data
                    )
                   
                    self.wordList = wordList
                } catch {
                    self.wordList = []
                    
                }
            } else {
                self.wordList = []
                
            }

        } else {
            self.wordList = []
            self.wordOfTheDay = ""
            let expireDate = getNewDate().toString()
            UserDefaults.standard
                .set(expireDate, forKey: expireDateKey)
            UserDefaults.standard.removeObject(forKey: wordOfTheDayKey)
            UserDefaults.standard.removeObject(forKey: wordListKey)
        }
    }

    func save(newWordOfTheDay: String) {
        do {
            
            let encoder = JSONEncoder()
            let encodedValue = try encoder.encode(newWordOfTheDay)
            UserDefaults.standard.set(encodedValue, forKey: wordOfTheDayKey)
            self.wordOfTheDay = newWordOfTheDay
        } catch {
            print("Error during encoding word")
        }
    }

    func saveWordList(newWordList: [String]) {
        do {
            let encoder = JSONEncoder()
            let encodedValue = try encoder.encode(newWordList)
            UserDefaults.standard.set(encodedValue, forKey: wordListKey)
        } catch {
            print("Error during encoding word list")
        }
    }

    func addWord(newWord: String) {
        self.wordList.append(newWord)
        saveWordList(newWordList: self.wordList)
    }

    func clearCache() {
        UserDefaults.standard.removeObject(forKey: expireDateKey)
        UserDefaults.standard.removeObject(forKey: wordOfTheDayKey)
        UserDefaults.standard.removeObject(forKey: wordListKey)

        self.wordList = []
        self.wordOfTheDay = ""
    }
}

func getNewDate() -> Date {
    let currentDate = Date()
    var dateComponents = DateComponents()
    dateComponents.minute = 1
    dateComponents.month = 0
    dateComponents.day = 0
    dateComponents.year = 0
    let futureDate = Calendar.current.date(
        byAdding: dateComponents,
        to: currentDate
    )
    return futureDate!
}

func decodeDate(dateStr: String) -> Date? {
    return dateStr.toDate()
}

extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Europe/London")
        dateFormatter.locale = Locale(identifier: "en-EN")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}

extension Date {

    func toString(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en-EN")
        dateFormatter.timeZone = TimeZone(identifier: "Europe/London")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }
}
