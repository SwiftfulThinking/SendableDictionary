//
//  AnySendableTests.swift
//  SendableDictionary
//
//  Created by Nick Sarno on 9/25/24.
//
import Testing
import Foundation
@testable import SendableDictionary

struct AnySendableTests {

    @Test("AnySendable converts and retrieves String value")
    func testStringConversion() throws {
        // Given
        let originalValue: Any = "Hello, World!"
        let sendable = AnySendable(from: originalValue)

        // Then
        #expect(sendable != nil)
        #expect(sendable?.toAny() as? String == originalValue as? String)
    }

    @Test("AnySendable converts and retrieves Int value")
    func testIntConversion() throws {
        // Given
        let originalValue: Any = 42
        let sendable = AnySendable(from: originalValue)

        // Then
        #expect(sendable != nil)
        #expect(sendable?.toAny() as? Int == originalValue as? Int)
    }

    @Test("AnySendable converts and retrieves Double value")
    func testDoubleConversion() throws {
        // Given
        let originalValue: Any = 3.14159
        let sendable = AnySendable(from: originalValue)

        // Then
        #expect(sendable != nil)
        #expect(sendable?.toAny() as? Double == originalValue as? Double)
    }

    @Test("AnySendable converts and retrieves Bool value")
    func testBoolConversion() throws {
        // Given
        let originalValue: Any = true
        let sendable = AnySendable(from: originalValue)

        // Then
        #expect(sendable != nil)
        #expect(sendable?.toAny() as? Bool == originalValue as? Bool)
    }

    @Test("AnySendable converts and retrieves Float value")
    func testFloatConversion() throws {
        // Given
        let originalValue: Any = Float(1.618)
        let sendable = AnySendable(from: originalValue)

        // Then
        #expect(sendable != nil)
        #expect(sendable?.toAny() as? Float == originalValue as? Float)
    }

    @Test("AnySendable converts and retrieves Date value")
    func testDateConversion() throws {
        // Given
        let originalValue: Any = Date()
        let sendable = AnySendable(from: originalValue)

        // Then
        #expect(sendable != nil)
        #expect(sendable?.toAny() as? Date == originalValue as? Date)
    }

    @Test("AnySendable converts and retrieves Data value")
    func testDataConversion() throws {
        // Given
        let originalValue: Any = "Data".data(using: .utf8)!
        let sendable = AnySendable(from: originalValue)

        // Then
        #expect(sendable != nil)
        #expect(sendable?.toAny() as? Data == originalValue as? Data)
    }

    @Test("AnySendable converts and retrieves Array value")
    func testArrayConversion() throws {
        // Given
        let originalValue: Any = ["Hello", "World", "Array"]
        let sendable = AnySendable(from: originalValue)

        // Then
        #expect(sendable != nil)
        let convertedArray = sendable?.toAny() as? [String]
        #expect(convertedArray != nil)
        #expect(convertedArray == originalValue as? [String])
    }

    @Test("AnySendable converts and retrieves Dictionary value")
    func testDictionaryConversion() throws {
        // Given
        let originalValue: Any = ["key1": "value1", "key2": "value2"]
        let sendable = AnySendable(from: originalValue)

        // Then
        #expect(sendable != nil)
        let convertedDictionary = sendable?.toAny() as? [String: String]
        #expect(convertedDictionary != nil)
        #expect(convertedDictionary?["key1"] == "value1")
        #expect(convertedDictionary?["key2"] == "value2")
    }

    @Test("AnySendable returns nil for unsupported type")
    func testInvalidTypeConversion() throws {
        // Given
        let originalValue: Any = URL(string: "https://example.com")!
        let sendable = AnySendable(from: originalValue)

        // Then
        #expect(sendable == nil)
    }

    @Test("AnySendable converts and retrieves complex nested structure")
    func testComplexNestedStructureConversion() throws {
        // Given
        let originalValue: Any = [
            "key1": ["NestedKey1": "NestedValue1", "NestedKey2": 42],
            "key2": ["AnotherKey1": ["DeepNestedKey": 3.14]]
        ]
        let sendable = AnySendable(from: originalValue)

        // Then
        #expect(sendable != nil)
        let convertedDictionary = sendable?.toAny() as? [String: Any]
        #expect(convertedDictionary != nil)

        let nestedDictionary = convertedDictionary?["key1"] as? [String: Any]
        #expect(nestedDictionary?["NestedKey1"] as? String == "NestedValue1")
        #expect(nestedDictionary?["NestedKey2"] as? Int == 42)

        let deepNestedDictionary = (convertedDictionary?["key2"] as? [String: Any])?["AnotherKey1"] as? [String: Any]
        #expect(deepNestedDictionary?["DeepNestedKey"] as? Double == 3.14)
    }
}
