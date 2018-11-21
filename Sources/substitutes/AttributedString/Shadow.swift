
import Style

extension AttributedString {

    public struct Shadow: Codable {

        public let offset: Size
        public let blurRadius: Number
        public let color: Color

        public init(offset: Size, blurRadius: Number, color: Color) {
            self.offset = offset
            self.blurRadius = blurRadius
            self.color = color
        }
    }
}

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

#if os(iOS) || os(tvOS) || os(macOS)

extension AttributedString.Shadow: NativeConvertible {

    public var native: NSShadow {
        let shadow = NSShadow()

        shadow.shadowOffset = offset.native
        shadow.shadowBlurRadius = blurRadius.native
        shadow.shadowColor = color.native

        return shadow
    }
}

#endif
