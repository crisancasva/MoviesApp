//
//  MovieViewCell.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 27/07/25.
//
import SwiftUI

struct DetailViewCell: View {
    var movie: Results
    
    var body: some View {
        self.contentView {
            self.movieInfotView {
            }
            Spacer()
        }
    }
    
    private func contentView(@ViewBuilder view: @escaping () -> some View) -> some View {
        HStack(alignment: .top, spacing: Spacing._sm){ view() }
        .padding(Spacing._md)
        .background(.neutral50)
        .cornerRadius(20)
        }
    
    private func movieInfotView(@ViewBuilder view: @escaping () -> some View) -> some View {
        HStack(alignment: .top, spacing: Spacing._xs){
            self.imagePoster
            VStack(alignment: .leading){
                self.titleLabel
                self.releaseDate
                self.dateLabel
                self.voteAverage
                self.votes
            }
        }.padding(.leading, 20)
    }
    
    private var titleLabel: some View {
        
        TextTitle(text: self.movie.original_title, type: .small)
    }
    private var dateLabel: some View {
        TextLabel(text: self.movie.releaseDateShortFormat)
    }
    private var releaseDate: some View{
        TextLabel(text: "Fecha Lanzamiento")
    }
    private var voteAverage: some View {
        TextLabel(text: "Votos promedio: \(self.movie.voteAverageFormat)")
    }
    private var imagePoster: some View {
        AsyncImage(url: movie.urlPoster_path) { image in
            image
                .resizable()
                .frame(width: 100, height: 200)
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Color.gray.opacity(0.3)
        }
        
        .clipped()
        .cornerRadius(15)
        
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
    
        .padding()
    }
}

#Preview {
    DetailViewCell(movie: Results(dto: .mock))
}
