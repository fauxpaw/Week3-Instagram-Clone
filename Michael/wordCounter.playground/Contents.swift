//: Playground - noun: a place where people can play

import UIKit

let mySentence = "Hi, how are you?"
let otherSentence = "This is suspiciously easy..."


mySentence.characters.count

//space is a char
// , is a char
// ? is a char


func countDemWords(sentence: String){
    var wordCount = 1
    
    for char in sentence.characters
    {
        if char == " " {
            print("New word")
            wordCount += 1
        }
    }
    print("There are \(wordCount) words in your sentence")
}

countDemWords(mySentence)
countDemWords(otherSentence)


//let alphaNumerical = "a"
//let regex = try (pattern: " ", options: .CaseInsensitive)
//


let startLowerCase = "a".unicodeScalars
let endLowerCase = "z".unicodeScalars

//whiteboard space
//attention to words
//implementation

"a".utf16
let char = "a"

//lowercase 97-122
//uppercase 65-90


let mystring = "abcdefghijklmnopqrstuvwxyz"
for u in mystring.utf16{
        print(u)
}

let otherString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

for u in otherString.utf16 {
    print(u)
}




