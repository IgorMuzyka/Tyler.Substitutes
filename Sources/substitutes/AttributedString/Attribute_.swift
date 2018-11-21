
extension AttributedString {

    public enum Attribute {

        case font(Font)
        case paragraphStyle(ParagraphStyle)
        case foregroundColor(Color)
        case backgroundColor(Color)
        case ligature(Ligature)
        case kern(Double)
        case strikethrough(UnderlineStyle, Color)
        case underline(UnderlineStyle, Color)
        case stroke(Color, Double)
        case shadow(Shadow)
        case link(String)
        case baselineOffset(Double)
        case writingDirection(WritingDirection)

//        case verticalGlyphForm
//        case textEffect
//        case attachment
//        case obliqueness
//        case expansion
    }
}

extension AttributedString.Attribute: Codable {

    private enum CodingKeys: String, CodingKey {

        case font
        case paragraphStyle
        case foregroundColor
        case backgroundColor
        case ligature
        case kern
        case strikethroughStyle
        case strikethroughColor
        case underlineStyle
        case underlineColor
        case strokeColor
        case strokeWidth
        case shadow
        case link
        case baselineOffset
        case writingDirection
    }

    public enum AttributedStringAttributeError: Error {
        case decoding(String)
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        if let font = try? values.decode(Font.self, forKey: .font) {
            self = .font(font)
        } else if let style = try? values.decode(AttributedString.ParagraphStyle.self, forKey: .paragraphStyle) {
            self = .paragraphStyle(style)
        } else if let color = try? values.decode(Color.self, forKey: .foregroundColor) {
            self = .foregroundColor(color)
        } else if let color = try? values.decode(Color.self, forKey: .backgroundColor) {
            self = .backgroundColor(color)
        } else if let ligature = try? values.decode(AttributedString.Ligature.self, forKey: .ligature) {
            self = .ligature(ligature)
        } else if let kern = try? values.decode(Double.self, forKey: .kern) {
            self = .kern(kern)
        } else if
            let style = try? values.decode(AttributedString.UnderlineStyle.self, forKey: .strikethroughStyle),
            let color = try? values.decode(Color.self, forKey: .strikethroughColor)
        {
            self = .strikethrough(style, color)
        } else if
            let style = try? values.decode(AttributedString.UnderlineStyle.self, forKey: .underlineStyle),
            let color = try? values.decode(Color.self, forKey: .underlineColor)
        {
            self = .underline(style, color)
        } else if
            let color = try? values.decode(Color.self, forKey: .strokeColor),
            let width = try? values.decode(Double.self, forKey: .strokeWidth)
        {
            self = .stroke(color, width)
        } else if let shadow = try? values.decode(AttributedString.Shadow.self, forKey: .shadow) {
            self = .shadow(shadow)
        } else if let link = try? values.decode(String.self, forKey: .link) {
            self = .link(link)
        } else if let offset = try? values.decode(Double.self, forKey: .baselineOffset) {
            self = .baselineOffset(offset)
        } else if let direction = try? values.decode(AttributedString.WritingDirection.self, forKey: .writingDirection) {
            self = .writingDirection(direction)
        } else {
            throw AttributedStringAttributeError.decoding("\(dump(values))")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .font(let font): try container.encode(font, forKey: .font)
        case .paragraphStyle(let style): try container.encode(style, forKey: .paragraphStyle)
        case .foregroundColor(let color): try container.encode(color, forKey: .foregroundColor)
        case .backgroundColor(let color): try container.encode(color, forKey: .backgroundColor)
        case .ligature(let ligature): try container.encode(ligature, forKey: .ligature)
        case .kern(let kern): try container.encode(kern, forKey: .kern)
        case .strikethrough(let style, let color):
            try container.encode(style, forKey: .strikethroughStyle)
            try container.encode(color, forKey: .strikethroughColor)
        case .underline(let style, let color):
            try container.encode(style, forKey: .underlineStyle)
            try container.encode(color, forKey: .underlineColor)
        case .stroke(let color, let width):
            try container.encode(color, forKey: .strokeColor)
            try container.encode(width, forKey: .strokeWidth)
        case .shadow(let shadow): try container.encode(shadow, forKey: .shadow)
        case .link(let link): try container.encode(link, forKey: .link)
        case .baselineOffset(let offset): try container.encode(offset, forKey: .baselineOffset)
        case .writingDirection(let direction): try container.encode(direction, forKey: .writingDirection)
        }
    }
}

#if os(iOS) || os(tvOS) || os(macOS)
import Foundation

extension AttributedString.Attribute {

    public func apply(to string: NSMutableAttributedString, at range: CountableClosedRange<Int>) {
        let nsRange = NSRange(range)
        switch self {
        case .font(let font): string.addAttribute(NSAttributedString.Key.font, value: font.native as Any, range: nsRange)
        case .paragraphStyle(let style): string.addAttribute(NSAttributedString.Key.paragraphStyle, value: style.native as Any, range: nsRange)
        case .foregroundColor(let color): string.addAttribute(NSAttributedString.Key.foregroundColor, value: color.native as Any, range: nsRange)
        case .backgroundColor(let color): string.addAttribute(NSAttributedString.Key.backgroundColor, value: color.native as Any, range: nsRange)
        case .ligature(let ligature): string.addAttribute(NSAttributedString.Key.ligature, value: ligature.native as Any, range: nsRange)
        case .kern(let kern): string.addAttribute(NSAttributedString.Key.kern, value: kern, range: nsRange)
        case .strikethrough(let style, let color):
            string.addAttribute(NSAttributedString.Key.strikethroughStyle, value: style.native as Any, range: nsRange)
            string.addAttribute(NSAttributedString.Key.strikethroughColor, value: color.native as Any, range: nsRange)
        case .underline(let style, let color):
            string.addAttribute(NSAttributedString.Key.underlineStyle, value: style.native as Any, range: nsRange)
            string.addAttribute(NSAttributedString.Key.underlineColor, value: color.native as Any, range: nsRange)
        case .stroke(let color, let width):
            string.addAttribute(NSAttributedString.Key.strokeColor, value: color.native as Any, range: nsRange)
            string.addAttribute(NSAttributedString.Key.strokeWidth, value: width, range: nsRange)
        case .shadow(let shadow): string.addAttribute(NSAttributedString.Key.shadow, value: shadow.native as Any, range: nsRange)
        case .link(let link): string.addAttribute(NSAttributedString.Key.link, value: URL(string: link)!, range: nsRange)
        case .baselineOffset(let offset): string.addAttribute(NSAttributedString.Key.baselineOffset, value: offset, range: nsRange)
        case .writingDirection(let direction): string.addAttribute(NSAttributedString.Key.writingDirection, value: NSArray(array: [direction.native as Any]), range: nsRange)
        }
    }
}

#endif
