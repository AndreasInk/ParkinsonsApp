//
//  Keyboard.swift
//  Keyboard
//
//  Created by Andreas on 4/23/21.
//

import SwiftUI

struct Keyboard: View {
   
    var viewController: KeyboardViewController
    
    @State var row1 = [Key(id: UUID(), key: "q", sens: 8), Key(id: UUID(), key: "w", sens: 8), Key(id: UUID(), key: "e", sens: 8),Key(id: UUID(), key: "r", sens: 8), Key(id: UUID(), key: "t", sens: 8), Key(id: UUID(), key: "y", sens: 8), Key(id: UUID(), key: "u", sens: 8), Key(id: UUID(), key: "i", sens: 8), Key(id: UUID(), key: "o", sens: 8), Key(id: UUID(), key: "p", sens: 8),]
    
    @State var row2 = [Key(id: UUID(), key: "a", sens: 8), Key(id: UUID(), key: "s", sens: 8), Key(id: UUID(), key: "d", sens: 8),Key(id: UUID(), key: "f", sens: 8), Key(id: UUID(), key: "g", sens: 8), Key(id: UUID(), key: "h", sens: 8), Key(id: UUID(), key: "j", sens: 8), Key(id: UUID(), key: "k", sens: 8), Key(id: UUID(), key: "l", sens: 8)]
    
    @State var row3 = [Key(id: UUID(), key: "z", sens: 8), Key(id: UUID(), key: "x", sens: 8), Key(id: UUID(), key: "c", sens: 8),Key(id: UUID(), key: "v", sens: 8), Key(id: UUID(), key: "b", sens: 8), Key(id: UUID(), key: "n", sens: 8), Key(id: UUID(), key: "m", sens: 8)]
    
    @State var section1 = ["q", "w", "e", "a", "s", "d", "z", "x"]
    @State var section2 = ["d", "x", "r", "t", "y", "u", "f", "g", "h", "c", "v", "b"]
    @State var section3 = ["i", "o", "p", "j", "k", "l", "n", "m"]
    @State var section4 = ["j", "n", "p", "k", "l", "m"]
    @State var pressedKey = ""
    @State var zoom = false
    @State var uppercase = false
    @State var uppercaseDoubleTap = false
    @State var zoomSection = [String]()
    @State var predictedKey: String = ""
    @State var text = ""
    
    @State var predictions = [String]()
    
    @State var sensedKeys = [String]()
    var body: some View {
        GeometryReader { geo in
        ZStack {
            HStack(spacing: 0) {
            ForEach(0 ..< 3) { i in
                Color(.tertiarySystemFill)
               
                .ignoresSafeArea()
                .onTapGesture {
                   
                    if i == 0 {
                       zoomSection = section1
                    }
                    if i == 1 {
                       zoomSection = section2
                    }
                    if i == 2 {
                       zoomSection = section3
                    }
//                    if i == 3 {
//                       zoomSection = section4
//                    }
                    zoom = true
               }
                Divider()
              
            }
            }
        VStack {
          // Spacer(minLength: 200)
//            TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $text)
//                .font(.title)
//                .disabled(true)
//                .foregroundColor(.white)
//                .padding()
//            HStack {
//            ForEach(predictions, id: \.self) { p in
//                Button(action: {
//                    //pressedKey = p
//                    for i in text.indices {
//                        viewController.textDocumentProxy.deleteBackward()
//                    }
//                    viewController.textDocumentProxy.insertText(text.replacingOccurrences(of: text, with: p))
//                    text = ""
//
//                }) {
//
//                Text(p)
//                    .font(.headline)
//                    .padding(8)
//                    .background(RoundedRectangle(cornerRadius: 28.0).foregroundColor(.white))
//                Divider()
//                }
//            }
//
//            }
            HStack(spacing: 4) {
                ForEach(row1.indices, id: \.self) { i in
                    KeyView(pressedKey: $pressedKey, zoom: $zoom, key: $row1[i], zoomSection: $zoomSection, predictedKey: $predictedKey, uppercase: $uppercase, uppercaseDoubleTap: $uppercaseDoubleTap)
                    .frame(width: geo.size.width/12, height: geo.size.width/9)
                
            }
            } .padding(.top, 3)
            HStack(spacing: 4) {
                ForEach(row2.indices, id: \.self) { i in
                    KeyView(pressedKey: $pressedKey, zoom: $zoom, key: $row2[i], zoomSection: $zoomSection, predictedKey: $predictedKey, uppercase: $uppercase, uppercaseDoubleTap: $uppercaseDoubleTap)
                        .frame(width: geo.size.width/12, height: geo.size.width/9)
                }
            }.padding(.top, 3)
            HStack(spacing: 8) {
                
               
                Button(action: {
                    uppercase.toggle()
                }) {
                   
                   Image(systemName: "arrow.up")
                        .font(.headline)
                        .foregroundColor(.black)
                    .padding(8)
                    
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color(.white))
                    )
                }
                 .padding(.top, 3)
                    .onLongPressGesture(minimumDuration: 0.25) {
                                                           uppercaseDoubleTap = true
                                                       }
                ForEach(row3.indices, id: \.self) { i in
                    KeyView(pressedKey: $pressedKey, zoom: $zoom, key: $row3[i], zoomSection: $zoomSection, predictedKey: $predictedKey, uppercase: $uppercase, uppercaseDoubleTap: $uppercaseDoubleTap)
                        .frame(width: geo.size.width/12, height: geo.size.width/9)
                        .disabled(zoom)
                }
                
                Button(action: {
                    if viewController.textDocumentProxy.hasText {
                        viewController.textDocumentProxy.deleteBackward()
                        if !text.isEmpty {
                        text.removeLast()
                        }
                    }
                }) {
                    
               
                   
                   Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundColor(.black)
                    .padding(8)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color(.white))
                    )
                }
                
            } 
            HStack(spacing: 8) {
            Button(action: {
                pressedKey = " "
                text = ""
            }) {
                
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color(.white))
                    .frame(height: geo.size.width/9)
                Text("Space")
                    .bold()
                    .font(.headline)
                    .foregroundColor(.black)
            
        } .padding(5)
            
            }
                Button(action: {
                    viewController.dismissKeyboard()
                }) {
                    
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color(.white))
                        .frame(width:  geo.size.width/7, height: geo.size.width/9)
                    Text("Enter")
                        .bold()
                        .font(.headline)
                        .foregroundColor(.black)
                
            } .padding(5)
                    
                }
            }
        }.onChange(of: pressedKey, perform: { value in
            
            viewController.textDocumentProxy.insertText(pressedKey)
            text = text + pressedKey
            pressedKey = ""
           
            predictions =  (autoSuggest(text) ?? [])
            if predictions.count > 7 {
            predictions.removeLast(predictions.count - 3)
            } else {
                if !predictions.isEmpty {
                predictions.removeLast()
                }
            }
            for i in predictions.indices {
                for i2 in 0...text.count {
                    
                    if text[i2] == predictions[i][i2] {
                        //print(i2)
                       // print(sensedKeys)
                        if !sensedKeys.contains(predictions[i][i2]) {
                        for i3 in row1.indices {
                           // row1[i3].sens = 8
                            if row1[i3].key.lowercased() ==   predictions[i][i2+1] {
                                print("change")
                                sensedKeys.append(row1[i3].key)
                                row1[i3].sens = 13
                                
                             //   print(row1[i3])
                            } else {
                               // row1[i3].sens = 8
                            }
                        }
                        for i3 in row2.indices {
                            //row2[i3].sens = 8
                            if row2[i3].key.lowercased() ==  predictions[i][i2+1] {
                                row2[i3].sens = 13
                                print("change")
                                sensedKeys.append(row2[i3].key)
                               // print(row2[i3])
                            } else {
                               // row2[i3].sens = 8
                            }
                        }
                        for i3 in row3.indices {
                            //row3[i3].sens = 8
                          
                            if row3[i3].key.lowercased() ==  predictions[i][i2+1] {
                                row3[i3].sens = 13
                               // print(row3[i3])
                                sensedKeys.append(row3[i3].key)
                                print("change")
                            } else {
                                //row3[i3].sens = 8
                            }
                        }
                       
                    } else {
                        for i3 in row1.indices {
                            row1[i3].sens = 8.0
                        }
                        
                        for i3 in row2.indices {
                            row2[i3].sens = 8.0
                        }
                        
                        for i3 in row3.indices {
                            row3[i3].sens = 8.0
                        }
                    }
                    }
                }
                
            }
            print(predictions)
        })
            
            if zoom {
                Color(.lightGray)
                    .ignoresSafeArea()
                    .onTapGesture {
                        zoom = false
                    }
                ZoomView(zoom: $zoom, zoomSection: zoomSection, pressedKey: $pressedKey, predictedKey: $predictedKey)
            }
        }
    }
}
    func autoSuggest(_ word: String) -> [String]? {
        let textChecker = UITextChecker()
        let availableLangueages = UITextChecker.availableLanguages
        let preferredLanguage = (availableLangueages.count > 0 ? availableLangueages[0] : "en-US");

        let completions = textChecker.completions(forPartialWordRange: NSRange(0..<word.utf8.count), in: word, language: preferredLanguage)

        return completions
       }
}
extension String {
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()

        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }

        return results.map { String($0) }
    }
}
extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
