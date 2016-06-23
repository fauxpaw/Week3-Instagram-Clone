//: Playground - noun: a place where people can play

import UIKit

//print the first 100 numbers in the fibonacci sequence

func fibo(number: Int) {
    
    //our starting 2 values. Some debate on whether the spiral starts at 1 or 0. Thus we could choose 1,1 also or any two viable fibo numbers
    
    var a: Double = 0
    var b: Double = 1

    for iteration in 0..<number {
        print("\(iteration):  \(a)")
        
        let temp = a
        a = b
        b = temp + b
    }
}

//this solution is O(n). I had some earlier versions that were  O(n^2). It was very painful.

fibo(100)