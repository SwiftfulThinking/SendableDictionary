//
//  AnySendable.swift
//  SendableDictionary
//
//  Created by Nick Sarno on 9/25/24.
//



import Foundation

struct AnySendable: Sendable {
    let value: Sendable

    init?(from value: Any) {
        switch value {
        case let value as String:
            self.value = value
        case let value as Int:
            self.value = value
        case let value as Double:
            self.value = value
        case let value as Bool:
            self.value = value
        case let value as Float:
            self.value = value
        case let value as Date:
            self.value = value
        case let value as Data:
            self.value = value
        case let value as [Sendable]:
            self.value = value
        case let value as [String: Sendable]:
            self.value = value
            // Add other types that conform to Sendable as needed
        default:
            return nil
        }
    }

    func toAny() -> Any {
        if let convertedValue = simpleTypeConversion() {
            return convertedValue
        } else if let convertedArray = convertArray(value) {
            return convertedArray
        } else if let convertedDictionary = convertDictionary(value) {
            return convertedDictionary
        } else {
            return value
        }
    }

    private func simpleTypeConversion() -> Any? {
        switch value {
        case let value as String:
            return value
        case let value as Int:
            return value
        case let value as Double:
            return value
        case let value as Bool:
            return value
        case let value as Float:
            return value
        case let value as Date:
            return value
        case let value as Data:
            return value
        default:
            return nil
        }
    }

    private func convertArray(_ value: Any) -> [Any]? {
        guard let array = value as? [Sendable] else { return nil }
        return array.compactMap { AnySendable(from: $0)?.toAny() }
    }

    private func convertDictionary(_ value: Any) -> [String: Any]? {
        guard let dictionary = value as? [String: Sendable] else { return nil }
        var result: [String: Any] = [:]
        for (key, sendableValue) in dictionary {
            if let convertedValue = AnySendable(from: sendableValue)?.toAny() {
                result[key] = convertedValue
            }
        }
        return result
    }
}
