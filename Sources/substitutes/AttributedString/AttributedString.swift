
import Tag
import Style

public class AttributedString: ExpressibleByStringLiteral, Codable {

    internal var styles = [Style]()
    public let string: String
    public var tags: [Tag] = []

    public init(_ value: String) {
        string = value
    }

    public convenience required init(unicodeScalarLiteral value: String) {
        self.init(value)
    }

    public convenience required init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }

    public convenience required init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
}

extension AttributedString {

    internal class Style: Codable, Taggable {

        let lowerBound: Int
        let upperBound: Int
        let attribute: Attribute
        var tags: [Tag] = []

		internal init(attribute: Attribute, range: CountableClosedRange<Int>, tags: [Tag] = []) {
            self.attribute = attribute
            lowerBound = range.lowerBound
            upperBound = range.upperBound
			self.tags = tags
        }

        internal func shift(_ shift: Int) -> Style {
            return Style(
                attribute: attribute,
                range: (lowerBound + shift) ... (upperBound + shift),
				tags: tags
            )
        }

        internal var range: CountableClosedRange<Int> {
            return lowerBound...upperBound
        }
    }

    public typealias StyleTuple = (attribute: Attribute, range: CountableClosedRange<Int>?, tags: [Tag])

    internal convenience init(_ value: String, configurations: [Style]) {
        self.init(value)
        self.styles = configurations
    }

    @discardableResult
    public func add(_ styles: [StyleTuple]) -> AttributedString {
        return styles.reduce(self) { this, style in this.add(style) }
    }

    @discardableResult
    public func add(_ style: StyleTuple) -> AttributedString {
        return add(style.attribute, for: style.range, tags: style.tags)
    }

    @discardableResult
    public func add(_ attribute: Attribute, for providedRange: CountableClosedRange<Int>? = nil, tags: [Tag] = []) -> AttributedString {
        let range = (providedRange == nil) ? 0...(string.count - 1) : providedRange!
		let style = Style(attribute: attribute, range: range, tags: tags)

        styles.append(style)

        return self
    }

    public func nonAttributedRanges() -> [CountableClosedRange<Int>] {
        let set = IndexSet(0..<string.count)

        return Array(styles.map { IndexSet($0.range) }.reduce(set) { result, current in
            return result.subtracting(current)
        }).ranges()
    }
}

public func + (left: AttributedString, right: AttributedString) -> AttributedString {
    return AttributedString(
        left.string + right.string,
        configurations: left.styles + right.styles.shift(left.string.count)
    )
}

public func + (left: AttributedString, right: String) -> AttributedString {
    return AttributedString(left.string + right, configurations: left.styles)
}

public func + (left: String, right: AttributedString) -> AttributedString {
    return AttributedString(
        left + right.string,
        configurations: right.styles.shift(left.count)
    )
}

extension Array where Element == AttributedString.Style {

    internal func shift(_ shift: Int) -> [AttributedString.Style] {
        return map { $0.shift(shift) }
    }
}

extension Array where Element == Int {

	private func rangeBreak() -> Int? {
		guard let first = first else { return nil }

		for (offset, index) in enumerated() {
			if offset + first != index {
				return offset
			} else if offset == count - 1 {
				return offset + 1
			}
		}

		return nil
	}

	fileprivate func ranges() -> [CountableClosedRange<Int>] {
		guard let rangeBreak = rangeBreak() else { return [] }

		let head = self.prefix(rangeBreak)
		let tail = Array(self.suffix(from: rangeBreak))

		guard let first = head.first, let last = head.last else {
			return tail.ranges()
		}

		let range = first...last

		guard tail.count >= 2 else {
			return [range]
		}

		return [range] + tail.ranges()
	}
}

extension String {

    public func attributed() -> AttributedString {
        return AttributedString(self)
    }
}

#if os(iOS) || os(tvOS) || os(macOS)
import Foundation

extension AttributedString: NativeConvertible {

    public var native: NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: string))

        tags.match(styles).forEach { configuration in
			configuration.attribute.apply(to: attributedString, at: configuration.range)
		}

        return attributedString
    }
}

#endif
