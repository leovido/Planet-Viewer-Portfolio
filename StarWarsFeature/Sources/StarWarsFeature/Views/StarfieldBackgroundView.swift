import SwiftUI

public struct StarfieldBackground: View {
	var speed: Double = 0.02
	var density: Int = 220

	public init(speed: Double, density: Int) {
		self.speed = speed
		self.density = density
	}
	
	public var body: some View {
		GeometryReader { proxy in
			let size = proxy.size

			TimelineView(.periodic(from: .now, by: 1.0 / 60.0)) { (context: TimelineViewDefaultContext) in
				Canvas { ctx, _ in
					let t = context.date.timeIntervalSinceReferenceDate

					// Nebula wash
					let rect = CGRect(origin: .zero, size: size)
					ctx.fill(
						Path(rect),
						with: .linearGradient(
							Gradient(colors: [
								Color(red: 0.20, green: 0.26, blue: 0.60).opacity(0.7),
								Color(red: 0.03, green: 0.04, blue: 0.10).opacity(0.9),
								Color(red: 0.30, green: 0.02, blue: 0.35).opacity(0.6)
							]),
							startPoint: CGPoint(x: 0, y: 0),
							endPoint: CGPoint(x: size.width, y: size.height)
						)
					)

					generateStars(ctx: &ctx, t: t, size: size)
				}
			}
		}
		.ignoresSafeArea()
	}
	
	func fract(_ x: Double) -> Double { x - floor(x) }
	
	func generateStars(ctx: inout GraphicsContext, t: Double, size: CGSize) {
		// Stars
		for i in 0..<density {
			let seed  = Double(i) * 13.37
			let baseX = fract(sin(seed) * 43758.5453123)
			let baseY = fract(sin(seed * 1.7) * 96453.214)

			let x = fract(baseX + speed * t * 0.25)
			let y = baseY

			let pt = CGPoint(x: x * size.width, y: y * size.height)
			let s  = CGFloat(fract(sin(t * 2 + seed) * 99999.0)) * 1.0 + 0.3

			ctx.fill(Path(ellipseIn: CGRect(x: pt.x, y: pt.y, width: s, height: s)),
					 with: .color(.white.opacity(0.9)))
		}
	}
}
