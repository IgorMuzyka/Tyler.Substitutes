
import Style

extension AttributedString {

    public class ParagraphStyle: Codable {

        public var lineSpacing: Number = 0
        public var paragraphSpacing: Number = 0
        public var alignment: TextAlignment = .natural
        public var headIdent: Number = 0
        public var tailIdent: Number = 0
        public var firstLineHeadIndent: Number = 0
        public var minimumLineHeight: Number = 0
        public var maximumLineHeight: Number = 0
        public var lineBreakMode: LineBreakMode = .byWordWrapping
        public var baseWritingDirection: WritingDirection = .natural
        public var lineHeightMultiple: Number = 0
        public var paragraphSpacingBefore: Number = 0
        public var hyphenationFactor: Float = 0
        //        public let tabStops: NSTextTab
        public var defaultTabInterval: Number = 0
        public var allowsDefaultTighteningForTruncation: Bool = false

        public init() {}

        public static var `default`: ParagraphStyle {
            return ParagraphStyle()
        }

        public static func subDefault(_ configuration: (ParagraphStyle) -> Void) -> ParagraphStyle {
            let paragraphStyle: ParagraphStyle = .default
            configuration(paragraphStyle)
            return paragraphStyle
        }
    }
}

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

#if os(iOS) || os(tvOS) || os(macOS)

extension AttributedString.ParagraphStyle: NativeConvertible {

    public var native: NSParagraphStyle? {
        let style = NSMutableParagraphStyle()

        style.lineSpacing = lineSpacing.native
        style.paragraphSpacing = paragraphSpacing.native
        style.alignment = alignment.native!
        style.headIndent = headIdent.native
        style.tailIndent = tailIdent.native
        style.firstLineHeadIndent = firstLineHeadIndent.native
        style.minimumLineHeight = minimumLineHeight.native
        style.maximumLineHeight = maximumLineHeight.native
        style.lineBreakMode = lineBreakMode.native!
        style.baseWritingDirection = baseWritingDirection.native!
        style.lineHeightMultiple = lineHeightMultiple.native
        style.paragraphSpacingBefore = paragraphSpacingBefore.native
        style.hyphenationFactor = hyphenationFactor
        style.defaultTabInterval = defaultTabInterval.native
        style.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation

        return style
    }
}

#endif
