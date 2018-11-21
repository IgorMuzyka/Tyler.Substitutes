
import Style

public struct DataDetectorTypes: OptionSet, StyleValueLiteral {

    public let rawValue: UInt

    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
}

extension DataDetectorTypes {

    public static var phoneNumber: DataDetectorTypes { return DataDetectorTypes(rawValue: 1) }
    public static var link: DataDetectorTypes { return DataDetectorTypes(rawValue: 2) }
    public static var address: DataDetectorTypes { return DataDetectorTypes(rawValue: 4) }
    public static var calendarEvent: DataDetectorTypes { return DataDetectorTypes(rawValue: 8) }
    public static var shipmentTrackingNumber: DataDetectorTypes { return DataDetectorTypes(rawValue: 16) }
    public static var flightNumber: DataDetectorTypes { return DataDetectorTypes(rawValue: 32) }
    public static var lookupSuggestion: DataDetectorTypes { return DataDetectorTypes(rawValue: 64) }
    public static var all: DataDetectorTypes { return DataDetectorTypes(rawValue: 18446744073709551615) }
}

#if os(iOS) || os(tvOS)
import UIKit

extension DataDetectorTypes: NativeConvertible {

    public var native: UIDataDetectorTypes {
        return UIDataDetectorTypes(rawValue: rawValue)
    }
}

#endif
