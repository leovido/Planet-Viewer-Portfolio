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
	}
}

//#Preview {
//	FilmView()
//}
