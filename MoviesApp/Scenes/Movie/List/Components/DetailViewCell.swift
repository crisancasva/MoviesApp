//
//  MovieViewCell.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 27/07/25.
//
import SwiftUI

struct DetailViewCell<Movie: MovieEntity>: View {
    var movie: Results
    
    var body: some View {
        self.contentView {
            self.movieInfotView {
            }
            Spacer()
        }
        .padding([.leading, .trailing], 16)
    }
    
    private func contentView(@ViewBuilder view: @escaping () -> some View) -> some View {
        HStack(alignment: .top, spacing: Spacing._sm){ view() }
            .background(Color.neutral0)
            .cornerRadius(15)
            .shadow(color: Color.neutral200, radius: 5, x: 1, y: 1)
            .frame(maxHeight: 200)
        }
    
    private func movieInfotView(@ViewBuilder view: @escaping () -> some View) -> some View {
        HStack(alignment: .top, spacing: Spacing._xs){
            self.imagePoster
            VStack(alignment: .leading){
                self.titleLabel
                self.releaseDate
                self.dateLabel
                self.votes
            }
        }
    }
    
    private var titleLabel: some View {
        
        TextTitle(text: self.movie.original_title, type: .small)
            .foregroundColor(Color.neutral1000)
            .padding(.top)
        
    }
    private var dateLabel: some View {
        TextLabel(text: self.movie.releaseDateShortFormat)
            .font(.subheadline)
            .foregroundColor(Color.neutral300)
        
    }
    private var releaseDate: some View{
        TextLabel(text: "Fecha de Lanzamiento")
            .font(.subheadline)
            .padding(.top, 0.5)
            .foregroundColor(Color.neutral300)
            
    }
    private var imagePoster: some View {
        AsyncImage(url: movie.urlPoster_path) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 130, height: 180)
                .clipped()
        } placeholder: {
            Color.neutral200
                .frame(width: 130, height: 180)
        }
    }
    
    private var votes: some View {
        let votes = Int((self.movie.vote_average / 1.0).rounded())
        
        return HStack{
            ForEach(1..<10) { index in
                Image(systemName: index < votes ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.yellow)
            }
        }
    }
}

#Preview {
    DetailViewCell<Results>(movie: Results(dto: .mock))
}
