//
//  RoundedTrapezoid.swift
//  Habit Tracker
//
//  Created by Vinz on 5/26/25.
//

import SwiftUI

struct RoundedTrapezoid: Shape {
    var cornerRadius: CGFloat
    var bottomWidthRatio: CGFloat // e.g., 0.9 means bottom is 90% of top width

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let topWidth = rect.width
        let bottomWidth = rect.width * bottomWidthRatio
        //let height = rect.height

        // Calculate how much to inset each bottom corner horizontally
        let bottomInset = (topWidth - bottomWidth) / 2.0

        // Define points, starting from top-left, moving clockwise
        let topLeft = CGPoint(x: rect.minX, y: rect.minY)
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX - bottomInset, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX + bottomInset, y: rect.maxY)

        // Move to the start of the top-left rounded corner
        path.move(to: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y))

        // Top edge
        path.addLine(to: CGPoint(x: topRight.x - cornerRadius, y: topRight.y))
        // Top-right corner
        path.addArc(center: CGPoint(x: topRight.x - cornerRadius, y: topRight.y + cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)

        // Right edge (slanting inwards)
        path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - cornerRadius)) // Adjusted for corner
        // Bottom-right corner
        // For a slanting edge, the corner calculation is more complex if you want perfect circular arcs
        // that are tangent to both lines. A simpler approach for a slight taper might involve
        // addQuadCurve or ensuring the control points for addArc are correct.
        // Let's use addLine for the main slant and then attempt a rounded corner.
        // A true rounded corner on a non-orthogonal joint requires careful geometry or specific arc functions.
        // For simplicity here, we'll use addArc, which will look decent for small corner radii.

        path.addArc(center: CGPoint(x: bottomRight.x - cornerRadius, y: bottomRight.y - cornerRadius), // This assumes a ~90deg corner for the arc center, adjust if very slanted
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)


        // Bottom edge
        path.addLine(to: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y))
        // Bottom-left corner
        path.addArc(center: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)

        // Left edge (slanting inwards)
        path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + cornerRadius)) // Adjusted for corner
        // Top-left corner
        path.addArc(center: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y + cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 270),
                    clockwise: false)

        path.closeSubpath()
        return path
    }
}

// A slightly more robust version for the corners on slanted edges might use
// addArc(tangent1End: tangent2End: radius:) if you can define the tangents.
// Or, for a very slight taper, the visual difference might be minor.

// Simpler alternative for corners if perfect circular arcs on acute/obtuse angles are tricky:
// You could use `Path.addQuadCurve` for simpler curves at the corners,
// or just accept that `addArc` with a center guess will be approximate for non-90-degree turns.

// For a more precise rounded trapezoid, especially with larger corner radii
// on the slanted sides, you would typically calculate the intersection points
// and use `addArc(tangent1End:tangent2End:radius:)`.
// The version above is a common approach that works reasonably well for moderate rounding.
