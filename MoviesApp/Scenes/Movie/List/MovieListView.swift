//
//  CarListView.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 24/07/25.
//
//
//import SwiftUI
//
//
//struct MovieListView : View {
//    @ObservedObject private var viewModel: MovieListViewModel
//    private let columns = 1
//    var body: some View {
//        self.contentView {
//            self.searchView
//            
//            GenericList(status: self.viewModel.status, columns: self.columns){
//                DetailViewCell(movie: $0)}
//            .loadingView{ContentLoadingView()}
//            .emptyView{ MovieListFeedbackView(message: $0, cases: .warning)}
//            .errorView{ MovieListFeedbackView(message: $0, cases: .error)}
//            .isRefreshable {self.viewModel.onAppear()}
//            .onCellSelected { self.viewModel.onSelectMovie($0) }
//            .onAppear{self.viewModel.onAppear()}
//        }
//      
//    }
//    
//    fileprivate init(viewModel: MovieListViewModel) {
//        self.viewModel = viewModel
//    }
//}
//
//extension MovieListView {
//    private func contentView(@ViewBuilder view: @escaping () -> some View) -> some View {
//        VStack { view()}
//            .background(.neutral0)
//    }
//    private var searchView: some View {
//        HStack{
//            FollowTextField(text: self.$viewModel.searchText)
//                .padding(Spacing._md)
//        }
//    }
//}
//  
//extension MovieListView {
//    static func build() -> some View {
//        let interactor = MovieInteractor.build(.real)
//        let searchInteractor = SearchInteractor.build(.real)
//        let viewModel = MovieListViewModel(interactor: interactor, searchInteractor: searchInteractor)
//        return MovieListView(viewModel: viewModel)
//            
//    }
//    static func buildMock() -> some View{
//        let interactor = MovieInteractor.build(.real)
//        let searchInteractor = SearchInteractor.build(.real)
//        let viewModel = MovieListViewModel(interactor: interactor, searchInteractor: searchInteractor)
//        let view = MovieListView(viewModel: viewModel)
//        return view
//    }
//    
//}
//
//#Preview {
//    MovieListView.buildMock()
//}
