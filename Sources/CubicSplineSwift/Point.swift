// 
//  Point.swift
//  CubicSplineSwift
//
//  Created by Pascal Schwinte on 30.10.21.
//  Copyright 2021 Pascal Schwinte. All rights reserved.
//

/// A custom point struct to be independent of macOS.
public struct Point: Equatable {
  public let x: Double
  public let y: Double

  public init(x: Double, y: Double) {
    self.x = x
    self.y = y
  }
}
