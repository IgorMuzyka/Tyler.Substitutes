
import Style

public struct ControlState: OptionSet, StyleValueLiteral {

    public let rawValue: UInt

    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
}

extension ControlState {

    public static var normal: ControlState { return ControlState(rawValue: 0) }
    public static var highlighted: ControlState { return ControlState(rawValue: 1) }
    public static var disabled: ControlState { return ControlState(rawValue: 2) }
    public static var selected: ControlState { return ControlState(rawValue: 4) }
    public static var focused: ControlState { return ControlState(rawValue: 8) }
}

#if os(iOS) || os(tvOS)
import UIKit

extension ControlState: NativeConvertible {

    public var native: UIControl.State {
        return UIControl.State(rawValue: rawValue)
    }
}

#endif
