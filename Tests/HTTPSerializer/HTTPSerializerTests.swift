import XCTest
@testable import HTTPSerializer

class HTTPSerializerTests: XCTestCase {
    func testReality() {
        XCTAssert(2 + 2 == 4, "Something is severely wrong here.")
    }
}

extension HTTPSerializerTests {
    static var allTests: [(String, (HTTPSerializerTests) -> () throws -> Void)] {
        return [
           ("testReality", testReality),
        ]
    }
}
