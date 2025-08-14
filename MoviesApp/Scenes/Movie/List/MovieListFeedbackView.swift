//
//  MovieListFeedback.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 31/07/25.
//

import SwiftUI


struct MovieListFeedbackView: View {
    private let message: String
    private let cases: MovieListFeedbackView.Cases
    
    var body: some View {
        HStack{
            Spacer()
            VStack(alignment: .center, spacing: Spacing._xl){
                Spacer()
                self.cases.format.image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(self.cases.format.color)
                TextLabel(text: self.message, aligment: .center)
                Spacer()
            }
            .padding(Spacing._xl)
            Spacer()
        }
    }
    init(message: String, cases: MovieListFeedbackView.Cases) {
        self.message = message
        self.cases = cases
    }
}
extension MovieListFeedbackView {
    enum Cases {
        case warning
        case error
        
        var format: (image: Image,color:  Color){
            switch self {
            case .warning: (Image(systemName: "exclamationmark.transmission"), .warning300)
            case .error: (Image(systemName: "xmark.circle"), .error700)
                
            }
        }
    }
}
#Preview {
    MovieListFeedbackView(message: "Mensaje de prueba", cases: .error)
}
