
import Style

public enum ViewContentMode: IntegerLiteralType, StyleValueLiteral {

	case scaleToFill
	case scaleAspectFit
	case scaleAspectFill
	case redraw
	case center
	case top
	case bottom
	case left
	case right
	case topLeft
	case topRight
	case bottomLeft
	case bottomRight
}

#if os(iOS) || os(tvOS)
import UIKit

extension ViewContentMode: NativeConvertible {

    public var native: UIView.ContentMode? {
        return UIView.ContentMode(rawValue: rawValue)
    }
}

#endif
