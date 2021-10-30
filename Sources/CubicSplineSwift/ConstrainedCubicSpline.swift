//
//  ConstrainedCubicSpline.swift
//  CubicSplineSwift
//
//  Created by Pascal Schwinte on 29.10.21.
//  Copyright 2021 Pascal Schwinte. All rights reserved.
//

public struct ConstrainedCubicSpline: CubicSpline, Equatable {
  private var x: [Double] = []
  private var a: [Double] = []
  private var b: [Double] = []
  private var c: [Double] = []
  private var d: [Double] = []

  /// Creates a new ConstrainedCubicSpline.
  ///
  /// - Parameter points: A list of all points the spline should consider.
  ///
  /// The list needs to contain at least 3 elements.
  public init(points: [Point]) {
    var x = [Double]()
    var y = [Double]()
    for point in points {
      x.append(point.x)
      y.append(point.y)
    }
    self.init(x: x, y: y)
  }

  /// Creates a new ConstrainedCubicSpline.
  ///
  /// - Parameters:
  ///  - x: An array with all x coordinates.
  ///  - y: An array with all y coordinates.
  ///
  /// The x and y arrays need to have the same amount of items with each having at least three.
  ///
  public init (x: [Double], y: [Double]) {
    assert(x.count == y.count, "X and Y array's need to be of equal length")
    assert(x.count >= 3, "There need to be at least 3 values to enable interpolation")

    self.x = x
    let n = x.count - 1
    var dx = [Double](repeating: 0.0, count: n)
    var dy = [Double](repeating: 0.0, count: n)

    for i in 0..<n {
      dx[i] = x[i + 1] - x[i]
      dy[i] = y[i + 1] - y[i]
    }

    var f1 = [Double](repeating: 0.0, count: n + 1)
    for i in 1..<n {
      let slope = dy[i] * dy[i - 1]
      if slope > 0 {
        f1[i] = 2 / (dx[i] / dy[i] + dx[i - 1] / dy[i - 1])
      } else {
        f1[i] = 0
      }
    }
    f1[0] = (3 * dy[0]) / (2 * dx[0]) - f1[1] / 2
    f1[n] = (3 * dy[n - 1]) / (2 * dx[n - 1]) - f1[n - 1] / 2

    self.a = [Double](repeating: 0.0, count: n + 1)
    self.b = [Double](repeating: 0.0, count: n + 1)
    self.c = [Double](repeating: 0.0, count: n + 1)
    self.d = [Double](repeating: 0.0, count: n + 1)
    for i in 1...n {
      let f2a = -2 * (f1[i] + 2 * f1[i - 1]) / dx[i - 1] + 6 * dy[i - 1] / exp(dx[i - 1], 2) // f2x-1
      let f2b = 2 * (2 * f1[i] + f1[i - 1]) / dx[i - 1] - 6 * dy[i - 1] / exp(dx[i - 1], 2) // f2x
      d[i] = (f2b - f2a) / (6 * dx[i - 1])
      c[i] = (x[i] * f2a - x[i - 1] * f2b) / (2 * dx[i - 1])
      let cxexp = c[i] * (exp(x[i], 2) - exp(x[i - 1], 2))
      let dxexp = d[i] * (exp(x[i], 3) - exp(x[i - 1], 3))
      b[i] = (dy[i - 1] - cxexp - dxexp) / dx[i - 1]
      a[i] = y[i - 1] - b[i] * x[i - 1] - c[i] * exp(x[i - 1], 2) - d[i] * exp(x[i - 1], 3)
    }
  }
  
  /// Creates a number of values that are all conforming to the calculated spline.
  ///
  /// If 1001 is given, there will be y and x value for x=0.000,0.001 ... 0.999,1.000.
  ///
  /// - Parameter values: The number of requested values.
  public func createSpline(values: Int) -> [Point] {
    var result: [Point] = []
    let max = x.max()!
    for value in 0..<values {
      let normalized: Double = Double(value) / Double(values)
      var i = 0
      for l in 0..<x.count where x[l] > normalized * Double(max) {
        i = l
        break
      }
      let y = a[i] + b[i] * normalized + c[i] * exp(normalized, 2) + d[i] * exp(normalized, 3)
      result.append(Point(x: normalized, y: y))
    }
    return result
  }
}
