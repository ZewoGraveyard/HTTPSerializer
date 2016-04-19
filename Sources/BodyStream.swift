// BodyStream.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Zewo
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

final class BodyStream: Stream {
    var closed = false
    let transport: Stream

    init(_ transport: Stream) {
        self.transport = transport
    }

    func close() {
        closed = true
    }

    func receive(upTo byteCount: Int, timingOut deadline: Double = .never) throws -> Data {
        enum Error: ErrorProtocol {
            case receiveUnsupported
        }
        throw Error.receiveUnsupported
    }

    func send(_ data: Data, timingOut deadline: Double = .never) throws {
        if closed {
            throw StreamError.closedStream(data: data)
        }
        let newLine: Data = [13, 10]
        try transport.send(String(data.count, radix: 16).data)
        try transport.send(newLine)
        try transport.send(data)
        try transport.send(newLine)
    }

    func flush(timingOut deadline: Double = .never) throws {
        try transport.flush()
    }
}
