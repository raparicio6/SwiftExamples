#!/usr/bin/env swift

func someThrowingFunction() throws -> Int {
// ...
}

let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}
