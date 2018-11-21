
import Style

public enum TextFieldViewMode: IntegerLiteralType, StyleValueLiteral {

	case never
	case whileEditing
	case unlessEditing
	case always
}

#if os(iOS) || os(tvOS)
import UIKit

extension TextFieldViewMode: NativeConvertible {

    public var native: UITextField.ViewMode? {
        return UITextField.ViewMode(rawValue: rawValue)
    }
}

#endif
