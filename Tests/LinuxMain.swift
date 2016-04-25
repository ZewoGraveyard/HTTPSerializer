#if os(Linux)

import XCTest
@testable import HTTPSerializerTestSuite

XCTMain([
    testCase(HTTPSerializerTests.allTests)
])

#endif
