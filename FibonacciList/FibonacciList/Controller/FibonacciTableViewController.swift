//
//  FibonacciTableViewController.swift
//  FibonacciList
//
//  Created by siwook on 2017. 9. 10..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - FibonacciTableViewController: UITableViewController 

class FibonacciTableViewController: UITableViewController {

  fileprivate var fibonacciList = FibonacciList()
  
  // MARK : - View Life Cycle 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    requestCalcFibonacci()
  }
  
  
  private func requestCalcFibonacci() {
    
    fibonacciList.getFibonacciNumbers {
      
      print(self.fibonacciList.numbersDict)
    }
    
  
  }
  
  
}

extension FibonacciTableViewController {
  

  // MARK: - Table view data source

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) 
    
    return cell
  }
  
}
