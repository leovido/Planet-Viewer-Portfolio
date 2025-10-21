import SwiftUI

public struct FilmView: View {
	@StateObject var viewModel: SWFilmViewModel
	
	public init(viewModel: SWFilmViewModel) {
		self._viewModel = StateObject(wrappedValue: viewModel)
	}
	
	public var body: some View {
		NavigationStack {
			ZStack {
				StarfieldBackground()

				ScrollView {
					LazyVStack(spacing: 0) {
						ForEach(viewModel.filmListItems) { film in
							FilmCardView(model: film)
								.padding(.vertical, 4)
						}
					}
				}
				.task {
					await viewModel.dispatch(.onAppear)
				}
				.navigationTitle(Text("Films"))
				.overlay {
					if viewModel.isLoading {
						VStack {
							Spacer()
							ProgressView()
							Spacer()
						}
					}
				}
				.overlay(alignment: .top) {
					if let error = viewModel.error {
						ContentUnavailableView(
							"Film error",
							systemImage: "film",
							description: Text("An error occured: \(error.localizedDescription)"))
					}
				}
			}
		}
		
	}
}

#Preview {
	let viewModel: SWFilmViewModel = .init(
		error: SWError.message("Error"), service: SWService.test
	)
	NavigationStack {
		FilmView(viewModel: viewModel)
			.task {
				do {
					try await viewModel.fetchFilms()
				} catch {
					dump(error)
				}
			}
	}
}

#Preview {
	let viewModel: SWFilmViewModel = .init(
		error: SWError.message("Error"), service: SWService.test
	)
	NavigationStack {
		FilmView(viewModel: viewModel)
	}
	.preferredColorScheme(.dark)
}
