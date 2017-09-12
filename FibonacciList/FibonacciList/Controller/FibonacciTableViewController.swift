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

  // MARK : - Property 

  private var sequence = 0
  private var fibonacciNumber: NSNumber = 0
  private let indicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    return indicator
  }()
  fileprivate var fibonacciList = FibonacciList()

  // MARK : - View Life Cycle 

  override func viewDidLoad() {
    super.viewDidLoad()

    configureActivityIndicator()
    requestCalcFibonacci()
  }

  // MARK : - Configure ActivityIndicator 

  private func configureActivityIndicator() {
    self.view.addSubview(indicator)
    indicator.center = self.view.center
  }

  // MARK : - Remove ActivityIndicator

  private func removeActivityIndicator() {
    indicator.stopAnimating()
    indicator.removeFromSuperview()
  }

  // MARK : - Display ActivityIndicator

  private func displayActivityIndicator() {
    indicator.startAnimating()
    UIApplication.shared.beginIgnoringInteractionEvents()
  }

  // MARK : - Request Fibonacci Calculation

  private func requestCalcFibonacci() {
    displayActivityIndicator()
    fibonacciList.getFibonacciNumbers {  [weak self] in
      self?.updateUI()
    }
  }

  // MARK : - Update UI

  private func updateUI() {
    removeActivityIndicator()
    UIApplication.shared.endIgnoringInteractionEvents()
    tableView.reloadData()
  }

}

// MARK: - FibonacciTableViewController 

extension FibonacciTableViewController {

  // MARK: - Table view data source

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fibonacciList.numbersDict.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIDs.FibonacciCell, for: indexPath)
    configureCell(cell: cell, indexPath: indexPath)
    return cell
  }

  // MARK : - Configure FibonacciTableViewCell

  private func configureCell(cell: UITableViewCell, indexPath: IndexPath) {
    guard let fibonacciNumber = fibonacciList.numbersDict[indexPath.row] else {
      return
    }
    cell.textLabel?.text = Constant.FibonacciInfoPrefix + " \(indexPath.row) : \(fibonacciNumber.intValue)"
  }

}
