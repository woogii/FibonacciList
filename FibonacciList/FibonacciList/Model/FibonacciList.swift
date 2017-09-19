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

  var numbersDict = [Int: NSDecimalNumber]()

  // MARK : - Perform Fibonacci Calculations
  /// Calculate fibonacci numbers with Memoization
  /// - Parameter number: Integer
  /// - Returns: Fibonacci number : NSDecimalNumber

  func fibonacciWithMemoization(number: Int) -> NSDecimalNumber {

    if number < 2 {

      let fibonacciValue = NSDecimalNumber.init(value: number)
      numbersDict[number] = fibonacciValue
      return fibonacciValue

    } else {

      var fibonacciValue: NSDecimalNumber!

      // If the fibonacci number does not exist
      if numbersDict[number] == nil {

        // Calculate Fibonacci number
        fibonacciValue = fibonacciWithMemoization(number:number-1).adding(fibonacciWithMemoization(number: number-2))

        numbersDict[number] = fibonacciValue
      } else {
        // Use the existing fibonacci number
        fibonacciValue = numbersDict[number]
      }
      return NSDecimalNumber(decimal: fibonacciValue.decimalValue)
    }
  }

}
