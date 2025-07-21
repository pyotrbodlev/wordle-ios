import SwiftUI

class TextFileReaderModel: ObservableObject {
    @Published public var data: String = ""
    
    init(filename: String) { self.load(file: filename) }
    
    func load(file: String) {
        if let filepath = Bundle.main.path(
            forResource: file,
            ofType: "txt",
            inDirectory: ""
        ) {
            do {
                let contents = try String(
                    contentsOfFile: filepath,
                    encoding: .utf8
                )
                DispatchQueue.main.async {
                    self.data = String(contents)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("File not found")
        }
    }
}
