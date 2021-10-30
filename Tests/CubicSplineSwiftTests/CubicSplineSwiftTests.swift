import XCTest
@testable import CubicSplineSwift

final class CubicSplineSwiftTests: XCTestCase {
  func testExample() throws {
    let points = [
      Point(x: 0, y: 30),
      Point(x: 0.1, y: 130),
      Point(x: 0.2, y: 150),
      Point(x: 0.3, y: 150),
      Point(x: 0.4, y: 170),
      Point(x: 0.5, y: 200),
      Point(x: 0.6, y: 270),
      Point(x: 0.7, y: 370),
      Point(x: 0.8, y: 170),
      Point(x: 0.9, y: 190),
      Point(x: 1.0, y: 100),
    ]
    let spline = ConstrainedCubicSpline(points: points)
    let result = spline.createSpline(values: 1001)
    result.forEach { print($0.y) }
    XCTAssertTrue(true)
  }
}
