import SwiftUI

struct StarWarsCrawlView: View {
	@State private var crawlOffset: CGFloat = 300
	
	var body: some View {
		ZStack {
			Color.black.edgesIgnoringSafeArea(.all)
			
			VStack {
				Spacer()
				Text("A long time ago in a galaxy far, far away...")
					.font(.custom("Inter", size: 24))
					.foregroundColor(.blue)
					.multilineTextAlignment(.center)
					.offset(y: crawlOffset)
					.onAppear {
						withAnimation(.easeInOut(duration: 6.0)) {
							crawlOffset = -300
						}
					}
				Spacer()
			}
		}
	}
}

#Preview {
	StarWarsCrawlView()
}
