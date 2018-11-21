
import Style

public enum TextBorderStyle: IntegerLiteralType, StyleValueLiteral {

	case none
	case line
	case bezel
	case roundedRect
}

#if os(iOS) || os(tvOS)
import UIKit

extension TextBorderStyle: NativeConvertible {

    public var native: UITextField.BorderStyle? {
        return UITextField.BorderStyle(rawValue: rawValue)
    }
}

#endif
