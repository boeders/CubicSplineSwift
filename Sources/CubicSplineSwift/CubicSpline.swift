//
//  CubicSpline.swift
//  CubicSplineSwift
//
//  Created by Pascal Schwinte on 29.10.21.
//  Copyright 2021 Pascal Schwinte. All rights reserved.
//

public protocol CubicSpline {
  init(x: [Double], y: [Double])
  init(points: [Point])
  func createSpline(values: Int) -> [Point]
}

/// Convenience method to calculate an exponential value without depending on Foundation
func exp(_ number: Double, _ exp: Int) -> Double {
  var result: Double = number
  guard exp > 1 else { return result }
  for _ in 1..<exp {
    result *= number
  }
  return result
}
