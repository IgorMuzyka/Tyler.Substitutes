
import Style

#warning("there is definitely something wrong here, but i don't really remember what, will fix later")
public struct BezierPath: Codable {

    var elements = [Element]()
}

#if os(iOS) || os(tvOS) || os(macOS)
import QuartzCore

extension BezierPath {

    public var cgPath: CGPath {
        return elements.reduce(CGMutablePath()) { (path, element) in
            element.apply(to: path)
        }
    }

    public init(cgPath: CGPath) {
        var elements = [BezierPath.Element]()

        withUnsafeMutablePointer(to: &elements) { pointer in
            cgPath.apply(info: pointer) { (userInfo, nextElementPointer) in
                let nextElement = BezierPath.Element(element: nextElementPointer.pointee)
                let elementsPointer = userInfo!.assumingMemoryBound(to: [BezierPath.Element].self)
                elementsPointer.pointee.append(nextElement)
            }
        }
        self = BezierPath(elements: elements)
    }
}

#endif

#if os(iOS) || os(tvOS)
import UIKit

extension BezierPath: NativeConvertible {

    public var native: UIBezierPath {
        return UIBezierPath(cgPath: cgPath)
    }
}

#elseif os(macOS)
import AppKit

extension BezierPath: NativeConvertible {

	public var native: NSBezierPath {
		fatalError("not implemented yet")
	}
}

extension NSBezierPath {

	public var cgPath: CGPath {
		fatalError("not implemented yet")
	}
}

#warning("Implement NSBezierPath native variation for Path, maybe check this https://gist.github.com/lukaskubanek/1f3585314903dfc66fc7")
#endif
