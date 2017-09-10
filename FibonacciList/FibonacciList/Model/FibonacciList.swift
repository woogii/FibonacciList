//
//  FibonacciList.swift
//  FibonacciList
//
//  Created by siwook on 2017. 9. 10..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation


// MARK : - FibonacciList 

class FibonacciList {

  // MARK : - Property 
  
  var numbersDict = [Int:NSDecimalNumber]()
  var sequence = 0
  
  // MARK : - Get Fibonacci Numbers
  
  func getFibonacciNumbers(_ updateUIOnMain:@escaping ()->Void) {
    
    let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
    queue.async {
      
      while true {
        
        let fibonacciNumber = self.fibonacciWithMemoization(number : self.sequence)
        
        if fibonacciNumber.int64Value < 0 {
          DispatchQueue.main.async {
            updateUIOnMain()
          }
          break
        }
        self.sequence += 1
      }
    }
    
  }
  
  // MARK : - Perform Fibonacci Calculations
  
  func fibonacciWithMemoization(number:Int)->NSDecimalNumber {
    
    if (number < 2) {
      
      let fibonacciValue = NSDecimalNumber.init(value: number)
      numbersDict[number] = fibonacciValue
      return fibonacciValue
      
    } else {
      
      var fibonacciValue: NSDecimalNumber!
      
      if (numbersDict[number] == nil) {
        
        
        fibonacciValue = fibonacciWithMemoization(number:number-1).adding(fibonacciWithMemoization(number: number-2))
        
        // Check whether overflow occured
        if fibonacciValue.int64Value > 0 {
          numbersDict[number] = fibonacciValue
        } else {
          return NSDecimalNumber(decimal: fibonacciValue.decimalValue)
        }
      } else {
        fibonacciValue = numbersDict[number]
      }
      return NSDecimalNumber(decimal: fibonacciValue.decimalValue)
    }
  }
  
}
