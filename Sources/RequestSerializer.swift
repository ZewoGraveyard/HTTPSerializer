// RequestSerializer.swift
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

@_exported import S4
@_exported import Data

public struct RequestSerializer: S4.RequestSerializer {
    public init() {}

    public func serialize(request: Request, to stream: Stream) throws {
        let newLine: Data = [13, 10]

        try stream.send("\(request.method) \(request.uri) HTTP/\(request.version.major).\(request.version.minor)".data)
        try stream.send(newLine)

        for (name, values) in request.headers.headers {
            for value in values.values {
                try stream.send("\(name): \(value)".data)
                try stream.send(newLine)
            }
        }

        try stream.send(newLine)

        switch request.body {
        case .buffer(let data):
            try stream.send(data)
        case .receiver(let bodyStream):
            for data in StreamSequence(for: bodyStream) {
                try stream.send(String(data.count, radix: 16).data)
                try stream.send(newLine)
                try stream.send(data)
                try stream.send(newLine)
            }

            try stream.send("0".data)
            try stream.send(newLine)
            try stream.send(newLine)
        default:
            break
        }
    }
}
