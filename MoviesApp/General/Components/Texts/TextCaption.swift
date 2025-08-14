//
//  TextCaption.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 9/08/25.
//



import SwiftUI

struct TextCaption: View {
    var text: String
    var color: Color = .neutral500
    var type: Style = .regular
    var body: some View {
        Text(self.text)
            .font(self.type.font)
            .foregroundStyle(self.color)
            .lineLimit(nil)
            .lineSpacing(7)
    }
    
    enum Style {
        case regular
        case bold
        var font: Font {
            switch self {
            case .regular:
                Fonts.caption
            case .bold:
                Fonts.caption_bold
            }
        }
    }
}
