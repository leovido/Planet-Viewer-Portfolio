import SwiftUI

public struct PlanetDetailView: View {
	@ObservedObject var viewModel: SWPlanetDetailViewModel
	@State private var showingMoreInfo = true
	
	init(viewModel: SWPlanetDetailViewModel, showingMoreInfo: Bool = true) {
		self.viewModel = viewModel
		self.showingMoreInfo = showingMoreInfo
	}
	
	public var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 20) {
				HStack {
					Text(viewModel.planetName)
						.font(.largeTitle)
						.fontWeight(.bold)
						.foregroundStyle(.primary)
						.accessibilityAddTraits(.isHeader)
					
					Spacer()
				}
				
				VStack(alignment: .leading, spacing: 15) {
					infoRow(label: "Climate", value: viewModel.climate.capitalized)
					infoRow(label: "Terrain", value: viewModel.terrain.capitalized)
					infoRow(label: "Population", value: viewModel.population)
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
							infoRow(label: "Diameter", value: "\(viewModel.diameter) km")
							infoRow(label: "Gravity", value: viewModel.gravity)
						}
						.padding(.top, 10)
					},
					label: {
						Text("Planetary Specifications")
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
			.navigationTitle(viewModel.planetName)
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
