
import Style

public enum ScrollViewKeyboardDismissMode: IntegerLiteralType, StyleValueLiteral {

	case none
	case onDrag
	case interactive
}

#if os(iOS) || os(tvOS)
import UIKit

extension ScrollViewKeyboardDismissMode: NativeConvertible {

	public var native: UIScrollView.KeyboardDismissMode? {
		return UIScrollView.KeyboardDismissMode(rawValue: rawValue)
	}
}

#endif
