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
  fileprivate var numberOfCell = 100
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
    //displayActivityIndicator()
  }

  // MARK : - Update UI

  fileprivate func updateUI() {
    //removeActivityIndicator()
    //UIApplication.shared.endIgnoringInteractionEvents()
    tableView.reloadData()
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
    DispatchQueue.global(qos:.background).async { [weak self] in
      guard let value = self?.fibonacciList.fibonacciWithMemoization(number: number) else {
        return
      }
      DispatchQueue.main.async {
        guard let updateCell = tableView.cellForRow(at: indexPath) else {
          return
        }
        if value.compare(NSNumber(value: Int64.max)).rawValue == 1 {
          return
        }
        self?.setLabelTextInCell(cell: updateCell, indexPath: indexPath, value:value)
      }
    }
    return cell
  }
  // MARK : - Set Text in FibonacciTableViewCell
  private func setLabelTextInCell(cell: UITableViewCell, indexPath: IndexPath, value: NSDecimalNumber) {
    cell.textLabel?.text = Constant.FibonacciInfoPrefix + " \(indexPath.row) : \(value)"
  }
}
