<p align="left">
    <img src="https://github.com/user-attachments/assets/fd26526b-cf33-4b60-8d3d-14f12b3d8e80" alt="Swift Wormhold SendableDict" width="300px" />
</p>

# SendableDict 🛸

A Swift dictionary type that conforms to `Sendable` protocol.

## About

The `Any` type does not conform to `Sendable` and therefore Dictionaries of `[String: Any]` are not `Sendable`.

`SendableDict` is a wrapper around `[String: Any]` that conforms to `Sendable`.



## Implementation

The conversion supports most primitive Swift types and nested Arrays/Dictionaries.
```swift
let dict: [String:Any] = [
  "key1": 1,
  "key2": "Hello",
  "key3": true,
  "key4": ["nestedKey": 2.0]
]
```

#### Convert to Sendable
```swift
let sendableDict: SendableDict = dict.sendable()
// or
let sendableDict: SendableDict = SendableDict(dict: dict)
```

#### Convert back
```swift
// Note: Any value that was not Sendable will be lost.
let anotherDict: [String: Any] = sendableDict.dict
```