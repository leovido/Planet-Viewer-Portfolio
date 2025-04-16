import SwiftUI

public struct FilmView: View {
	@ObservedObject var viewModel: SWFilmViewModel
	
	public init(viewModel: SWFilmViewModel) {
		self.viewModel = viewModel
	}
	
	public var body: some View {
		List(viewModel.film.results) { film in
			Text(film.title)
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

#Preview {
	let viewModel: SWFilmViewModel = .init(
		service: SWService.test,
		error: SWError.message("Error")
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
		service: SWService.test,
		error: SWError.message("Error")
	)
	NavigationStack {
		FilmView(viewModel: viewModel)
	}
	.preferredColorScheme(.dark)
}
