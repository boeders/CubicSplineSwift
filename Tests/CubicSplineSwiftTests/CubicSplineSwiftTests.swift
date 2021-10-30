import XCTest
@testable import CubicSplineSwift

final class CubicSplineSwiftTests: XCTestCase {
  func testExample() throws {
    let points = [
      Point(x: 0, y: 300),
      Point(x: 1, y: 350),
      Point(x: 2, y: 370),
      Point(x: 3, y: 450),
      Point(x: 4, y: 600),
      Point(x: 5, y: 480),
      Point(x: 6, y: 400),
      Point(x: 7, y: 500),
      Point(x: 8, y: 400),
      Point(x: 9, y: 350),
      Point(x: 10, y: 400),
      Point(x: 11, y: 600),
      Point(x: 12, y: 450),
    ]
    let max =  points.max { $0.y < $1.y }!.y
    let normalizedPoints = points.map { value in
      Point(x: value.x / (Double(points.count) - Double(1)), y: value.y / max )
    }
    let normalizedSpline = ConstrainedCubicSpline(points: normalizedPoints)
    let normalizedResult = normalizedSpline.createSpline(values: 1001)
  }
}
