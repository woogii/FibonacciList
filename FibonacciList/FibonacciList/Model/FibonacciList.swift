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
  /// Get Fibonacci numbers that are lower than the upper limit value of Integer type
  /// - Parameter updateUIOnMain: ()->Void
  
  func getFibonacciNumbers(_ updateUIOnMain:@escaping ()->Void) {
    
    let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
    queue.async {
      
      // Repeat operations until the fibonacci numbers are lower than the upper limit value of Integer type
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
  /// Calculate fibonacci numbers with Memoization
  /// - Parameter number: Integer
  /// - Returns: Fibonacci number : NSDecimalNumber
  
  func fibonacciWithMemoization(number:Int)->NSDecimalNumber {
    
    if (number < 2) {
      
      let fibonacciValue = NSDecimalNumber.init(value: number)
      numbersDict[number] = fibonacciValue
      return fibonacciValue
      
    } else {
      
      var fibonacciValue: NSDecimalNumber!
      
      // If the fibonacci number does not exist
      if (numbersDict[number] == nil) {
        
        // Calculate Fibonacci number
        fibonacciValue = fibonacciWithMemoization(number:number-1).adding(fibonacciWithMemoization(number: number-2))
        
        // Get the value of int64 type from the fibonacci calculation result
        if (fibonacciValue.int64Value > 0) {
          numbersDict[number] = fibonacciValue
        } else {
          // If it is a negative value, it means that there was an overflow and we do not save the result 
          return NSDecimalNumber(decimal: fibonacciValue.decimalValue)
        }
      } else {
        // Use the existing fibonacci number
        fibonacciValue = numbersDict[number]
      }
      return NSDecimalNumber(decimal: fibonacciValue.decimalValue)
    }
  }
  
}
