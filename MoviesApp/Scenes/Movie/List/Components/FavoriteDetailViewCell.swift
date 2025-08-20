//
//  FavoriteDetailViewCell.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 16/08/25.
//
import SwiftUI
import CoreData

struct FavoriteDetailViewCell<Movie: MovieEntity>: View {
    var movie: Movie
    
    var body: some View {
//        self.contentView {
            self.movieInfotView()
//            Spacer()
//        }
//        .frame(height: 250)
            .padding(10)
            .background(Color.neutral50)
            .cornerRadius(15)
                // **Clave**: Define un tamaño de celda fijo para que todas sean iguales
            .frame(width: 150, height: 250)
    }
    
    private func contentView(@ViewBuilder view: @escaping () -> some View) -> some View {
  
        HStack(alignment: .top) {
            view()
        }
        .padding(Spacing._md)
        .background(.neutral50)
        .cornerRadius(20)
        .frame(width: 150)
    }
    
    private func movieInfotView() -> some View {
        VStack(alignment: .leading, spacing: Spacing._sm) {
            self.imagePoster
           
            VStack(alignment: .leading) {
                self.titleLabel
                self.dateLabel
            }
          
//            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var titleLabel: some View {
        TextTitle(text: self.movie.title)
            .font(.system(size: 8))
            .lineLimit(2)
            .minimumScaleFactor(0.7)
    }
    
    private var dateLabel: some View {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let dateString = movie.releaseDate
        
        return TextCaption(text: dateString ?? "Fecha no disponible")
    }
    
    private var imagePoster: some View {
        let baseImageUrl = "https://image.tmdb.org/t/p/w500"
        let posterUrl = URL(string: baseImageUrl + (movie.posterPath ?? ""))
        
        return AsyncImage(url: posterUrl) { image in
            image
                .resizable()
                .frame(width: 150, height: 200)
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Color.gray.opacity(0.3)
                .frame(width: 150, height: 200)
        }
      
        .clipped()
        .cornerRadius(15)
    }
}
