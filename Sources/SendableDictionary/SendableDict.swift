//
//  SendableDict.swift
//  SendableDictionary
//
//  Created by Nick Sarno on 9/25/24.
//


public struct SendableDict: Sendable {
    private let localDict: [String: AnySendable]

    public var dict: [String: Any] {
        localDict.asAny()
    }

    public init(dict: [String: Any]) {
        self.localDict = dict.asAnySendable()
    }
}

public extension Dictionary where Key == String, Value == Any {
    func sendable() -> SendableDict {
        SendableDict(dict: self)
    }
}

fileprivate extension Dictionary {
    func asAnySendable() -> [Key: AnySendable] {
        self.compactMapValues({ AnySendable(from: $0) })
    }
}

fileprivate extension Dictionary where Value == AnySendable {
    func asAny() -> [Key: Any] {
        self.compactMapValues({ $0.toAny() })
    }
}
