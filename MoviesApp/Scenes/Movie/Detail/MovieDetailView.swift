//
//  DetailView.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 5/08/25.
//
import SwiftUI


struct DetailView: View {
    
    @ObservedObject private var viewModel: MovieDetailViewModel
    
    var body: some View{
        GenericScroll(status: self.viewModel.status) {self.movieDetailContent($0)}
        .loadingView {ContentLoadingView()}
        .errorView{MovieListFeedbackView(message: $0, cases: .error)}
        .isRefreshable{self.viewModel.onPullToRefresh()}
        .onAppear{ self.viewModel.onAppear()}
    }
    fileprivate init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
    }
}

extension DetailView {

    func movieDetailContent(_ movie: DetailMovie) -> some View {
        self.contentView{
                self.movieInfoView {
                    
                        AsyncImage(url: movie.urlBackdrop_path) { image in
                            image
                                .resizable()
                                .frame(width: 300, height: 200)
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        
                        .clipped()
                        .cornerRadius(15)
                        VStack(alignment: .leading){
                            TextTitle(text: movie.original_title, type: .small)
                            TextBody(text: movie.overview, color: .neutral1000)
                            TextLabel(text: "Fecha Lanzamiento")
                            TextLabel(text: movie.releaseDateShortFormat)
                            TextLabel(text: "Votos promedio: \(movie.voteAverageFormat)")
                            let votes = Int((movie.vote_average / 1.0).rounded())
                            
                            HStack{
                                ForEach(1..<10) { index in
                                    Image(systemName: index < votes ? "star.fill" : "star")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.yellow)
                                }
                            }
                        
                            .padding()
                        }
                    }
                    Spacer()
                    
        }
    }
    private func contentView(@ViewBuilder view:@escaping () -> some View) -> some View {
        HStack(alignment: .top, spacing: Spacing._sm){
            view()
        }
        .padding(Spacing._md)
        .background(.neutral50)
        .cornerRadius(15)
    }
    private func movieInfoView(@ViewBuilder view: @escaping () -> some View) -> some View {
        VStack(alignment: .leading, spacing: Spacing._xs) {
            view()
        }
    }
    
}

extension DetailView {
    static func build(_ movieId: Int) -> NavigatorScreen {
        let interactor = MovieInteractor.build(.real)
        let viewModel = MovieDetailViewModel(movieId: movieId, interactor: interactor)
        let view = DetailView(viewModel: viewModel)
            .navigatorBarStyle(.titleWithBack("DEtalle Pelicula"))
        return NavigatorScreen(view: view)
    }
    static func buildMock(_ movieId: Int) -> some View {
        let interactor = MovieInteractor.build(.mock)
        let viewModel = MovieDetailViewModel(movieId: movieId, interactor: interactor)
        let view = DetailView(viewModel: viewModel)
        return view
    }
}

#Preview {
    DetailView.buildMock(803796)
}
