
import Style

public struct Point: Codable {

	public let x: Number
	public let y: Number

	public init(x: Number, y: Number) {
		self.x = x
		self.y = y
	}
}

extension Point {

    public static var zero: Point {
        return Point(x: 0, y: 0)
    }
}

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

#if os(iOS) || os(tvOS) || os(macOS)

extension Point: NativeConvertible {

	public var native: CGPoint {
		return CGPoint(x: x.native, y: y.native)
	}
}

extension Point {

    public init(_ point: CGPoint) {
        self.x = Number(Double(point.x))
        self.y = Number(Double(point.y))
    }
}

#endif
