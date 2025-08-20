//
//  FavoriteListView.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 16/08/25.
//

//
//import SwiftUI
//import CoreData
//
//import SwiftUI
//
//struct FavoriteView: View {
//    @ObservedObject private var viewModel: FavoriteListViewModel
//   
//    var body: some View {
//            self.contentView {
//                self.searchView
//                GenericList(status: self.viewModel.status, columns: 2) { movie in
//                        FavoriteDetailViewCell(movie: movie)
//                }
//                .loadingView { ContentLoadingView() }
//                .errorView { MovieListFeedbackView(message: $0, cases: .error) }
//                .emptyView { MovieListFeedbackView(message: $0, cases: .warning)}
//                .onCellSelected { self.viewModel.onSelectMovie($0) }
//                        .onAppear{self.viewModel.onAppear()}
//                }
//        }
//    }
//    
//
//extension FavoriteView {
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
//extension FavoriteView {
//    static func build() -> some View {
//        let interactor = FavoriteInteractor.build(.real)
//        let viewModel = FavoriteListViewModel(favoriteInteractor: interactor)
//        return FavoriteView(viewModel: viewModel)
//    }
//    static func buildMock() -> some View {
//        let interactor = FavoriteInteractor.build(.mock)
//        let viewModel = FavoriteListViewModel(favoriteInteractor: interactor)
//        return FavoriteView(viewModel: viewModel)
//    }
//}
//
//#Preview {
//    FavoriteView.build()
//}
