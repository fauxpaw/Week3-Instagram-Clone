////: Playground - noun: a place where people can play
//
import UIKit

//for testing purposes, my magic numbers are small. Practically these would be much larger of course

let queueMax = 2 //max size of our dictionaries
var randomRange = 3 //random number from 0-1000000 which becomes our new URL
var dict = [Int: (String, Int)]()
var usedRandoms = [Int: Bool]()
var queueArray = [[Int:(String, Int)]]()

func shorten(url: String) {
    
    func populateCollections(url: String){
        print("adding item")
        var random = Int(arc4random() % UInt32(randomRange))
        
        print(usedRandoms[random])
        while usedRandoms[random] != nil {
            print(random)
            print("value exists: \(random)")
            random = Int(arc4random() % UInt32(randomRange))
            print("new random value is: \(random)")
        }
        
        dict[url.hashValue] = (url, random)
        let qItem = dict[url.hashValue]
        queueArray.append([url.hashValue : (url, random)])
        usedRandoms[random] = true
    }

    
    if dict[url.hashValue] != nil { //URL is already in dictionary
        print("item exists")
        let value = dict[url.hashValue]
        print("your url is: \(value?.1)")
    }
        
    else {
        if dict.count == queueMax {
            print("at capacity")
            //remove from 3 collections
            let popped = queueArray[0].popFirst()
            dict.removeValueForKey((popped?.0)!)
            usedRandoms.removeValueForKey((popped?.1.1)!)
            queueArray.removeAtIndex(0)
            print(popped)
            populateCollections(url)
            
        }
        else {
            populateCollections(url)
        }
        
    }
}


//comment these out to see step by step how the  are ccollections change
shorten("github.com")
shorten("twitter.com")
shorten("twitter.com")
shorten("amazon.com")
shorten("overload.org")

//comment these out
print(dict)
print(queueArray)
print(usedRandoms)

