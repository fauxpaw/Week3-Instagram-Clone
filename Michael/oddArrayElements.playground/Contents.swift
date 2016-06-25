//: Playground - noun: a place where people can play

import UIKit

//return all the odd elements in an array
//[1,2,3,4,5] -> [1,3,5]

let myArray = [1,2,3,4,5]
var otherArray = [ "the", "quick", "brown", "fox", "jumps","over", "the", "lazy", "dog"]

func returnOddIndexes(input: [AnyObject]) -> [AnyObject]{
    
    var newArray = [AnyObject]()
    for (index, value) in input.enumerate() {
        if index % 2 != 0 {
            newArray.append(value)
        }
    }
    return newArray
}

returnOddIndexes(myArray)
returnOddIndexes(otherArray)
