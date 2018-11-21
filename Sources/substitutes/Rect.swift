
import Style

public struct Rect: Codable {

    public let origin: Point
    public let size: Size

    public init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
}

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

#if os(iOS) || os(tvOS) || os(macOS)

extension Rect: NativeConvertible {

    public var native: CGRect {
        return CGRect(origin: origin.native, size: size.native)
    }
}

#endif
