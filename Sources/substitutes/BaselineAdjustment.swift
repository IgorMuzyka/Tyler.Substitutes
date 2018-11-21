
import Style

public enum BaselineAdjustment: IntegerLiteralType, StyleValueLiteral {

	case alignBaselines
	case alignCenters
	case none
}

#if os(iOS) || os(tvOS)
import UIKit

extension BaselineAdjustment: NativeConvertible {

    public var native: UIBaselineAdjustment? {
        return UIBaselineAdjustment(rawValue: rawValue)
    }
}

#endif
