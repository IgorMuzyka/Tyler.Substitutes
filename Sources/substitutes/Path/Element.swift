
extension BezierPath {

    public enum Element {

        case moveTo(point: Point)
        case addLineTo(point: Point)
        case addQuadCurveTo(point: Point, controlPoint: Point)
        case addCurveTo(point: Point, firstControlPoint: Point, secondControlPoint: Point)
        case closeSubpath
    }
}

extension BezierPath.Element: Codable {

    public enum CodingKeys: String, CodingKey {

        case moveTo
        case addLineTo
        case addQuadCurveToPoint
        case addQuadCurveToPointControlPoint
        case addCurveToPoint
        case addCurveToPointFirstControlPoint
        case addCurveToPointSecondControlPoint
        case closeSubpath
    }

    public enum PathElementCodingError: Error {
        case decoding(String)
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        if let point = try? values.decode(Point.self, forKey: .moveTo) {
            self = .moveTo(point: point)
        } else if let point = try? values.decode(Point.self, forKey: .addLineTo) {
            self = .addLineTo(point: point)
        } else if
            let point = try? values.decode(Point.self, forKey: .addQuadCurveToPoint),
            let controlPoint = try? values.decode(Point.self, forKey: .addQuadCurveToPointControlPoint)
        {
            self = .addQuadCurveTo(point: point, controlPoint: controlPoint)
        } else if
            let point = try? values.decode(Point.self, forKey: .addCurveToPoint),
            let firstControlPoint = try? values.decode(Point.self, forKey: .addCurveToPointFirstControlPoint),
            let secondControlPoint = try? values.decode(Point.self, forKey: .addCurveToPointSecondControlPoint)
        {
            self = .addCurveTo(point: point, firstControlPoint: firstControlPoint, secondControlPoint: secondControlPoint)
        } else if let _ = try? values.decode(Bool.self, forKey: .closeSubpath) {
            self = .closeSubpath
        } else {
            throw PathElementCodingError.decoding("\(dump(values))")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .moveTo(let point): try container.encode(point, forKey: .moveTo)
        case .addLineTo(let point): try container.encode(point, forKey: .moveTo)
        case .addQuadCurveTo(let point, let controlPoint):
            try container.encode(point, forKey: .addQuadCurveToPoint)
            try container.encode(controlPoint, forKey: .addQuadCurveToPointControlPoint)
        case .addCurveTo(let point, let firstControlPoint, let secondControlPoint):
            try container.encode(point, forKey: .addCurveToPoint)
            try container.encode(firstControlPoint, forKey: .addCurveToPointFirstControlPoint)
            try container.encode(secondControlPoint, forKey: .addCurveToPointSecondControlPoint)
        case .closeSubpath: try container.encode(true, forKey: .closeSubpath)
        }
    }
}

#if os(iOS) || os(tvOS) || os(macOS)
import QuartzCore

extension BezierPath.Element {

    public func apply(to path: CGMutablePath) -> CGMutablePath {
        switch self {
        case .moveTo(let point): path.move(to: point.native)
        case .addLineTo(let point): path.addLine(to: point.native)
        case .addQuadCurveTo(let point, let control): path.addQuadCurve(to: point.native, control: control.native)
        case .addCurveTo(let point, let firstControl, let secondControl): path.addCurve(to: point.native, control1: firstControl.native, control2: secondControl.native)
        case .closeSubpath: path.closeSubpath()
        }
        return path
    }

    internal init(element: CGPathElement) {
        switch element.type {
        case .moveToPoint: self = .moveTo(point: Point(element.points[0]))
        case .addLineToPoint: self = .addLineTo(point: Point(element.points[0]))
        case .addQuadCurveToPoint: self = .addQuadCurveTo(point: Point(element.points[0]), controlPoint: Point(element.points[1]))
        case .addCurveToPoint: self = .addCurveTo(point: Point(element.points[0]), firstControlPoint: Point(element.points[1]), secondControlPoint: Point(element.points[2]))
        case .closeSubpath: self = .closeSubpath
        }
    }
}

#endif
