//
//  TextTitle.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 15/07/25.
//

import SwiftUI

struct TextTitle: View {
    var text: String
    var type: Style = .small
    var color: Color = .neutral1000
    var aligment: TextAlignment = .leading
    
    var body: some View {
        Text(self.text)
            .font(self.type.font)
            .foregroundStyle(self.color)
            .lineLimit(nil)
            .lineSpacing(3)
            .multilineTextAlignment(self.aligment)
        
    }
}
extension TextTitle {
    enum Style {
        case small
        case medium
        case large
        
        var font: Font {
            switch self {
            case .small: Fonts.title_sm
            case .medium: Fonts.title_md
            case .large: Fonts.title_lg
            }
        }
    }
}

