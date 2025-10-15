import SwiftUI

public struct PersonDetailView: View {
	@ObservedObject var viewModel: SWPersonDetailViewModel
	@State private var showingMoreInfo = true
	
	public init(viewModel: SWPersonDetailViewModel, showingMoreInfo: Bool = true) {
		self.viewModel = viewModel
		self.showingMoreInfo = showingMoreInfo
	}
	
	public var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 20) {
				HStack {
					Text(viewModel.name)
						.font(.largeTitle)
						.fontWeight(.bold)
						.foregroundStyle(.primary)
						.accessibilityAddTraits(.isHeader)
					
					Spacer()
				}
				
				VStack(alignment: .leading, spacing: 15) {
					infoRow(label: "Hair color", value: viewModel.hairColor.capitalized)
					infoRow(label: "Skin color", value: viewModel.skinColor.capitalized)
					infoRow(label: "Gender", value: viewModel.gender)
				}
				.padding()
				.background {
					RoundedRectangle(cornerRadius: 12)
						.fill(Color(UIColor.secondarySystemBackground))
				}
				
				DisclosureGroup(
					isExpanded: $showingMoreInfo,
					content: {
						VStack(alignment: .leading, spacing: 15) {
							infoRow(label: "Height", value: "\(viewModel.height) m")
							infoRow(label: "Mass", value: viewModel.mass)
						}
						.padding(.top, 10)
					},
					label: {
						Text("Person Specs")
							.font(.headline)
							.fontWeight(.semibold)
					}
				)
				.padding()
				.background {
					RoundedRectangle(cornerRadius: 12)
						.fill(Color(UIColor.secondarySystemBackground))
				}
				.accessibilityElement(children: .contain)
				.accessibilityLabel("Planetary Specifications")
				.accessibilityHint("Tap to expand for more technical details")
			}
			.padding()
			.navigationTitle(viewModel.name)
			.navigationBarTitleDisplayMode(.inline)
		}
		.background(Color(UIColor.systemBackground))
	}
	
	private func infoRow(label: String, value: String) -> some View {
		HStack(alignment: .firstTextBaseline) {
			Text(label + ":")
				.font(.headline)
				.foregroundStyle(.secondary)
				.frame(width: 120, alignment: .leading)
				.accessibilitySortPriority(1)
			
			Spacer(minLength: 10)
			
			Text(value.isEmpty || value == "unknown" ? "Unknown" : value)
				.font(.body)
				.foregroundStyle(.primary)
				.multilineTextAlignment(.trailing)
				.accessibilitySortPriority(2)
		}
		.accessibilityElement(children: .combine)
		.accessibilityLabel("\(label): \(value.isEmpty || value == "unknown" ? "Unknown" : value)")
	}
}

#Preview {
	NavigationStack {
		PlanetDetailView(viewModel: SWPlanetDetailViewModel(planet: .default))
			.preferredColorScheme(.dark)
	}
}
