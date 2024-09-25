//
//  SendableDictTests.swift
//  SendableDictionary
//
//  Created by Nick Sarno on 9/25/24.
//
import Testing
import Foundation
@testable import SendableDictionary

struct SendableDictTests {

    @Test("SendableDict initializes correctly from a dictionary and retrieves values with random values")
    func testInitializationAndRetrieval() throws {
        // Given
        let randomInt = Int.random(in: 0...100)
        let randomDouble = Double.random(in: 0...100)
        let randomBool = Bool.random()
        let randomString = UUID().uuidString

        let originalDict: [String: Any] = [
            "stringKey": randomString,
            "intKey": randomInt,
            "doubleKey": randomDouble,
            "boolKey": randomBool
        ]
        let sendableDict = SendableDict(dict: originalDict)

        // When
        let convertedDict = sendableDict.dict

        // Then
        #expect(convertedDict["stringKey"] as? String == randomString)
        #expect(convertedDict["intKey"] as? Int == randomInt)
        #expect(convertedDict["doubleKey"] as? Double == randomDouble)
        #expect(convertedDict["boolKey"] as? Bool == randomBool)
    }

    @Test("SendableDict handles nested dictionaries with random values")
    func testNestedDictionaryConversion() throws {
        // Given
        let randomInt = Int.random(in: 0...100)
        let randomString = UUID().uuidString

        let originalDict: [String: Any] = [
            "nestedDict": [
                "nestedKey1": randomString,
                "nestedKey2": randomInt
            ],
            "topLevelKey": randomString
        ]
        let sendableDict = SendableDict(dict: originalDict)

        // When
        let convertedDict = sendableDict.dict

        // Then
        let nestedDict = convertedDict["nestedDict"] as? [String: Any]
        #expect(nestedDict?["nestedKey1"] as? String == randomString)
        #expect(nestedDict?["nestedKey2"] as? Int == randomInt)
        #expect(convertedDict["topLevelKey"] as? String == randomString)
    }

    @Test("SendableDict handles empty dictionary")
    func testEmptyDictionary() throws {
        // Given
        let originalDict: [String: Any] = [:]
        let sendableDict = SendableDict(dict: originalDict)

        // When
        let convertedDict = sendableDict.dict

        // Then
        #expect(convertedDict.isEmpty)
    }

    @Test("SendableDict handles unsupported types gracefully with random supported value")
    func testUnsupportedTypeHandling() throws {
        // Given
        let randomString = UUID().uuidString
        let originalDict: [String: Any] = [
            "unsupportedKey": URL(string: "https://example.com")!,
            "supportedKey": randomString
        ]
        let sendableDict = SendableDict(dict: originalDict)

        // When
        let convertedDict = sendableDict.dict

        // Then
        #expect(convertedDict["unsupportedKey"] == nil)
        #expect(convertedDict["supportedKey"] as? String == randomString)
    }

    @Test("Dictionary extension correctly converts to SendableDict with random values")
    func testDictionaryExtension() throws {
        // Given
        let randomInt = Int.random(in: 0...100)
        let randomString = UUID().uuidString

        let originalDict: [String: Any] = [
            "key1": randomString,
            "key2": randomInt
        ]

        // When
        let sendableDict = originalDict.sendable()

        // Then
        let convertedDict = sendableDict.dict
        #expect(convertedDict["key1"] as? String == randomString)
        #expect(convertedDict["key2"] as? Int == randomInt)
    }

    @Test("SendableDict maintains integrity after multiple conversions with random values")
    func testMultipleConversions() throws {
        // Given
        let randomInt = Int.random(in: 0...100)
        let randomDouble = Double.random(in: 0...100)
        let randomString = UUID().uuidString

        let originalDict: [String: Any] = [
            "key1": randomString,
            "key2": randomInt,
            "key3": ["nestedKey": randomDouble]
        ]

        // When
        let sendableDict = originalDict.sendable()
        let finalDict = sendableDict.dict

        // Then
        #expect(finalDict["key1"] as? String == randomString)
        #expect(finalDict["key2"] as? Int == randomInt)

        let nestedDict = finalDict["key3"] as? [String: Any]
        #expect(nestedDict?["nestedKey"] as? Double == randomDouble)
    }
}
