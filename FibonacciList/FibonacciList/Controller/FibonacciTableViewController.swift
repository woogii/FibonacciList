//
//  FibonacciTableViewController.swift
//  FibonacciList
//
//  Created by siwook on 2017. 9. 10..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
func memoize<T: Hashable, U>(work: @escaping ((T) -> U, T) -> U) -> (T) -> U {
  var memo = Dictionary<T, U>()
  func wrap(key: T) -> U {
    if let q = memo[key] { return q }
    let r = work(wrap, key)
    memo[key] = r
    return r
  }
  return wrap
}
// MARK : - FibonacciTableViewController: UITableViewController

class FibonacciTableViewController: UITableViewController {

  // MARK : - Property 
  fileprivate var numberOfCell = 100
  private let indicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    return indicator
  }()
  fileprivate var fibonacciList = FibonacciList()
  fileprivate let fibonacci: ((Int) -> NSDecimalNumber) = memoize { (fibonacci: ((Int) -> NSDecimalNumber), n: Int) in
    return (n < 2) ? NSDecimalNumber.init(value: n) : fibonacci(n - 1).adding(fibonacci(n - 2))
  }
  // MARK : - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

// MARK: - FibonacciTableViewController 

extension FibonacciTableViewController {

  // MARK: - Table view data source

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numberOfCell
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIDs.FibonacciCell, for: indexPath)
    cell.textLabel?.text = ""
    let number = indexPath.row
    
    let value = fibonacci(number)
    guard value.compare(NSNumber(value: Int64.max)) == .orderedAscending else {
      return UITableViewCell()
    }
    setLabelTextInCell(cell: cell, indexPath: indexPath, value:value)
    return cell
  }
  // MARK : - Set Text in FibonacciTableViewCell
  private func setLabelTextInCell(cell: UITableViewCell, indexPath: IndexPath, value: NSDecimalNumber) {
    cell.textLabel?.text = Constant.FibonacciInfoPrefix + " \(indexPath.row) : \(value)"
  }
}
