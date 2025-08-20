//
//  MovieView.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 17/08/25.
import SwiftUI

struct MovieView<Strategy: MovieListStrategy>: View {
    
    @ObservedObject private var viewModel: MovieViewModel<Strategy>

    
    init(strategy: Strategy) {
        _viewModel = ObservedObject(wrappedValue: MovieViewModel(strategy: strategy))
    }
    
    var body: some View {
        self.contentView {
            self.searchView
            
            GenericList(status: self.viewModel.status, columns: self.viewModel.columns) { movie in
                            Group {
                                if let apiMovie = movie as? Results {
                                    DetailViewCell<Results>(movie: apiMovie)
                                } else if let favoriteMovie = movie as? Favorite {
                                    FavoriteDetailViewCell<Favorite>(movie: favoriteMovie)
                                } else {
                                    Text("Celda no soportada.")
                                }
                            }
                        }
            .loadingView { ContentLoadingView() }
            .emptyView { MovieListFeedbackView(message: $0, cases: .warning) }
            .errorView { MovieListFeedbackView(message: $0, cases: .error) }
            .isRefreshable { self.viewModel.onAppear() }
            .onCellSelected { self.viewModel.onSelectMovie($0) }
            .onAppear { self.viewModel.onAppear() }
        }
    }
    
    private func contentView(@ViewBuilder view: @escaping () -> some View) -> some View {
        VStack { view() }
            .background(Color.gray.opacity(0.1))
    }
    
    private var searchView: some View {
        HStack {
            FollowTextField(text: self.$viewModel.searchText)
                .padding()
        }
    }
}

extension MovieView where Strategy == MovieListFromServiceStrategy {
    static func buildWeb() -> some View {
        let interactor = MovieInteractor.build(.real)
        let searchInteractor = SearchInteractor.build(.real)
        let strategy = MovieListFromServiceStrategy(interactor: interactor, searchInteractor: searchInteractor)
        return MovieView(strategy: strategy)
    }
}

extension MovieView where Strategy == MovieListFromDataBaseStrategy {
    static func buildDB() -> some View {
        let favoriteInteractor = FavoriteInteractor.build(.real)
        let strategy = MovieListFromDataBaseStrategy(favoriteInteractor: favoriteInteractor)
        return MovieView(strategy: strategy)
    }
}


