
import Style

public enum ViewTintAdjustmentMode: IntegerLiteralType, StyleValueLiteral {

	case automatic
	case normal
	case dimmed
}

#if os(iOS) || os(tvOS)
import UIKit

extension ViewTintAdjustmentMode: NativeConvertible {

	public var native: UIView.TintAdjustmentMode? {
		return UIView.TintAdjustmentMode(rawValue: rawValue)
	}
}

#endif
