# FibonacciList

This is a simple demo application that shows a list of fibonacci numbers. The application calculates  fibonacci numbers of Integer type that are lower than the upper limit value, `Int64.max`. Then, it immediately displays the whole numbers as you scroll through the list.

## Challenges

* Calculating Fibonacci numbers in a recursive manner 
* Performing the calculation in background mode 
* Checking Integer overflow while calculating

## How to solve 

* Once the app launches, the program calculates all fibonacci numbers less than `Int64.max` and saves the results on a Dictionary variable. 
* Memoization technique is used to do the fibonacci calculation more effectively. The result of the calculations are stored and then returned when needed, rather than calling a recursive function repeatedly.
* `dispatch_queue` is used to execute fibonacci calculations in background mode. 
* A [NSDecimalNumber](https://developer.apple.com/documentation/foundation/nsdecimalnumber) variable saves the results of the fibonacci calculation to prevent a run-time error caused by the overflow. The application checks whether or not there is an overflow by examining the value of the `NSDecimalNumber` variable.


 
## Design decision 

This application follows the MVC (Model-View-Controller) pattern. 

* Model Layer - FibonacciList class is defined with member variables and member functions. Member functions perform fibonacci calculations in background mode and save the results on the member variables. 
  
* Controller Layer - FibonacciListTableViewController holds the FibonacciList class variable and uses it as a datasource of `UITableView` to populate fibonacci numbers.

* View Layer - FibonacciTableViewCell is responsible for displaying contents, in this case fibonacci numbers. 

## Further Improvement 

* If there is a large number of fibonacci numbers on the list, we can call the fibonacci calculation function in UITableView's datasoure method and load more values accordingly when more numbers are requested. Moreover, we have to consider replacing `NSDecimalNumber` with our owned-library that works like Java's `BigInteger` to represent large numbers.  



# How to build 

1) Clone the repository 

```
$ git clone https://github.com/woogii/FibonacciList.git
$ cd FibonacciList
```
2) Open the workspace in XCode 

```
$ open FibonacciList.xcodeproj/
```
