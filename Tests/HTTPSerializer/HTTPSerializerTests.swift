import XCTest
@testable import HTTPSerializer

class StringStream: Stream {
    let input: String
    var output = ""
    var receivedText = false

    init(input: String? = nil) {
        self.input = input ?? ""
    }

    var closed: Bool { return false }
    func close() throws {}
    func flush(timingOut deadline: Double) throws {}

    func send(_ data: Data, timingOut deadline: Double) throws {
        self.output += String(data)
    }

    func receive(upTo byteCount: Int, timingOut deadline: Double) throws -> Data {
        guard self.receivedText else {
            self.receivedText = true
            return Data(self.input)
        }
        return Data()
    }
}

class HTTPSerializerTests: XCTestCase {
    func testSerializeStream() {
        let inStream = StringStream(input: "text")
        let outStream = StringStream()
        let serializer = ResponseSerializer()
        let response = Response(body: inStream)

        try! serializer.serialize(response, to: outStream)
        XCTAssertEqual(outStream.output, "HTTP/1.1 200 OK\r\nTransfer-Encoding: chunked\r\n\r\n4\r\ntext\r\n0\r\n\r\n")
    }
}

extension HTTPSerializerTests {
    static var allTests: [(String, (HTTPSerializerTests) -> () throws -> Void)] {
        return [
           ("testSerializeStream", testSerializeStream),
        ]
    }
}
