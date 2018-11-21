
import Style

public enum ScrollViewIndicatorStyle: IntegerLiteralType, StyleValueLiteral {

	case `default`
	case black
	case white
}

#if os(iOS) || os(tvOS)
import UIKit

extension ScrollViewIndicatorStyle: NativeConvertible {

	public var native: UIScrollView.IndicatorStyle? {
		return UIScrollView.IndicatorStyle(rawValue: rawValue)
	}
}

#endif
