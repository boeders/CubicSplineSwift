[![Build](https://github.com/boeders/CubicSplineSwift/actions/workflows/swift.yml/badge.svg)](https://github.com/boeders/CubicSplineSwift/actions/workflows/swift.yml)

# CubicSplineSwift

An implementation of an constrained cubic spline that should eliminate over and undershoot when handling charts while maintaining a smooth curve.

# Installation
You can use CubicSplineSwift through SPM.

# Example Data
| **X** |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  10  |  11  |  12  |
|-------|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|------|------|------|
| **Y** | 300 | 350 | 370 | 450 | 600 | 480 | 400 | 500 | 400 | 350 | 400  | 600  | 450  | 

The data was normalized to values between 0 and 1 before creating the spline.
<img width="890" alt="image" src="https://user-images.githubusercontent.com/51718801/139538281-15b2e56b-10be-4f85-a025-b9226b3d63c2.png">

# Usage
Initialize the ConstrainedCubicSpline with a list of at least 3 Points.
Alternatively use lists with x and y coordinates which need to be the same length and have at least 3 values each.
Then you can call createSpline which will return an array of points that span the data from start to finish.
This will result in x values from 0.00, 0.01 to 0.99, 1.00 if 101 values would be requested.
# Source
calculation source: https://pages.uoregon.edu/dgavin/software/spline.pdf
# License
CubicSplineSwift is available under MIT License.
