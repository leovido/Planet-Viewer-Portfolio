import SwiftUI
import StarWarsFeature

struct PlanetDetailView: View {
	let planet: SWPlanet
	@Environment(\.dismiss) private var dismiss
	@Environment(\.dynamicTypeSize) private var dynamicTypeSize
	@State private var showingMoreInfo = false
	@State private var showingSuccessToast = false
	
	private var terrainImage: String {
		switch planet.terrain.lowercased() {
		case _ where planet.terrain.contains("desert"):
			return "sun.max"
		case _ where planet.terrain.contains("forest"):
			return "tree"
		case _ where planet.terrain.contains("mountain"):
			return "mountain.2"
		case _ where planet.terrain.contains("ocean"),
			_ where planet.terrain.contains("water"):
			return "water.waves"
		case _ where planet.terrain.contains("jungle"):
			return "leaf"
		case _ where planet.terrain.contains("swamp"):
			return "sparkles"
		case _ where planet.terrain.contains("city"),
			_ where planet.terrain.contains("urban"):
			return "building.2"
		default:
			return "globe"
		}
	}
	
	private var climateColor: Color {
		switch planet.climate.lowercased() {
		case _ where planet.climate.contains("arid"),
			_ where planet.climate.contains("hot"):
			return .orange
		case _ where planet.climate.contains("temperate"):
			return .green
		case _ where planet.climate.contains("frozen"),
			_ where planet.climate.contains("frigid"):
			return .blue
		case _ where planet.climate.contains("tropical"):
			return .yellow
		default:
			return .gray
		}
	}
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 20) {
				HStack {
					Text(planet.name)
						.font(.largeTitle)
						.fontWeight(.bold)
						.foregroundStyle(.primary)
						.accessibilityAddTraits(.isHeader)
					
					Spacer()
					
					Image(systemName: terrainImage)
						.font(.system(size: 40))
						.foregroundStyle(climateColor)
						.accessibilityHidden(true)
				}
				
				// Main information card
				VStack(alignment: .leading, spacing: 15) {
					infoRow(label: "Climate", value: planet.climate.capitalized)
					infoRow(label: "Terrain", value: planet.terrain.capitalized)
					infoRow(label: "Surface Water", value: "\(planet.surfaceWater)%")
					infoRow(label: "Population", value: formatPopulation(planet.population))
				}
				.padding()
				.background {
					RoundedRectangle(cornerRadius: 12)
						.fill(Color(UIColor.secondarySystemBackground))
				}
				
				// Technical specifications section
				DisclosureGroup(
					isExpanded: $showingMoreInfo,
					content: {
						VStack(alignment: .leading, spacing: 15) {
							infoRow(label: "Diameter", value: "\(planet.diameter) km")
							infoRow(label: "Gravity", value: planet.gravity)
							infoRow(label: "Rotation Period", value: "\(planet.rotationPeriod) hours")
							infoRow(label: "Orbital Period", value: "\(planet.orbitalPeriod) days")
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
			.navigationTitle(planet.name)
			.navigationBarTitleDisplayMode(.inline)
			.alert("Success!", isPresented: $showingSuccessToast) {
				Button("OK", role: .cancel) { }
			} message: {
				Text("Planet data has been saved successfully.")
			}
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button {
						showingSuccessToast = true
					} label: {
						Image(systemName: "star")
							.accessibilityLabel("Favorite this planet")
					}
				}
			}
		}
		.toolbar(.visible, for: .tabBar)
		.background(Color(UIColor.systemBackground))
	}
	
	private func infoRow(label: String, value: String) -> some View {
		HStack(alignment: .firstTextBaseline) {
			Text(label + ":")
				.font(.headline)
				.foregroundStyle(.secondary)
				.frame(width: dynamicTypeSize > .xxLarge ? nil : 120, alignment: .leading)
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
	
	private func formatPopulation(_ population: String) -> String {
		guard let population = Decimal(string: population) else {
			return population
		}
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.maximumFractionDigits = 1
		
		if population >= 1_000_000_000 {
			let billions = population / 1_000_000_000
			return "\(billions.formatted(.number)) billion"
		} else if population >= 1_000_000 {
			let millions = population / 1_000_000
			return "\(millions.formatted(.number)) million"
		} else if population >= 1_000 {
			let thousands = population / 1_000
			return "\(thousands.formatted(.number)) thousand"
		} else {
			return population.formatted(.number)
		}
	}
}

#Preview {
	NavigationStack {
		PlanetDetailView(planet: SWPlanet(
			name: "Tatooine",
			rotationPeriod: "23",
			orbitalPeriod: "304",
			diameter: "10465",
			climate: "arid",
			gravity: "1 standard",
			terrain: "desert",
			surfaceWater: "1",
			population: "200000",
			residents: [],
			films: [],
			created: "2014-12-09T13:50:49.644Z",
			edited: "2014-12-10T13:59:28.459Z",
			url: "https://swapi.dev/api/planets/1/"
		))
	}
}

// Add another preview to show adapting to dynamic type
#Preview("Large Dynamic Type") {
	NavigationStack {
		PlanetDetailView(planet: SWPlanet(
			name: "Naboo",
			rotationPeriod: "26",
			orbitalPeriod: "312",
			diameter: "12120",
			climate: "temperate",
			gravity: "1 standard",
			terrain: "grassy hills, swamps, forests, mountains",
			surfaceWater: "12",
			population: "4500000000",
			residents: [],
			films: [],
			created: "2014-12-09T13:50:49.644Z",
			edited: "2014-12-10T13:59:28.459Z",
			url: "https://swapi.dev/api/planets/8/"
		))
	}
	.environment(\.dynamicTypeSize, .xxxLarge)
}
