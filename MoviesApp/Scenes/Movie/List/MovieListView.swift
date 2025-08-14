//
//  CarListView.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 24/07/25.
//

import SwiftUI


struct MovieListView : View {
    @ObservedObject private var viewModel: MovieListViewModel
   
    var body: some View {
        self.contentView {
            self.searchView
            
            GenericList(status: self.viewModel.status) { DetailViewCell(movie: $0)}
            .loadingView{ContentLoadingView()}
            .emptyView{ MovieListFeedbackView(message: $0, cases: .warning)}
            .errorView{ MovieListFeedbackView(message: $0, cases: .error)}
            .isRefreshable {self.viewModel.onAppear()}
            .onCellSelected { self.viewModel.onSelectMovie($0) }
            .onAppear{self.viewModel.onAppear()}
        }
      
    }
    
    fileprivate init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }
}

extension MovieListView {
    private func contentView(@ViewBuilder view: @escaping () -> some View) -> some View {
        VStack { view()}
            .background(.neutral0)
    }
    private var searchView: some View {
        HStack{
            FollowTextField(text: self.$viewModel.searchText)
                .padding(Spacing._md)
        }
    }
}
  
extension MovieListView {
    static func build() -> some View {
        let interactor = MovieInteractor.build(.real)
        let viewModel = MovieListViewModel(interactor: interactor)
        return MovieListView(viewModel: viewModel)
            
    }
    static func buildMock() -> some View{
        let interactor = MovieInteractor.build(.mock)
        let viewModel = MovieListViewModel(interactor: interactor)
        let view = MovieListView(viewModel: viewModel)
        return view
    }
    
}

#Preview {
    MovieListView.buildMock()
}
