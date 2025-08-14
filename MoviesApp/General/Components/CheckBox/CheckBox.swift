//
//  CheckBox.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 25/07/25.
//


import SwiftUI

struct CheckBox: View {
    
    @Binding private var checked: Bool
    private var text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: Spacing._none) {
            self.boxView
            TextLabel(text: self.text)
            Spacer()
        }
    }
    
    init(checked: Binding<Bool>, text: String) {
        _checked = checked
        self.text = text
    }
    
    private var boxView: some View {
        Button {
            self.checked.toggle()
        } label: {
            Image(systemName: self.checked ? "checkmark.square.fill" : "checkmark.square")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.trailing, Spacing._sm)
                .foregroundStyle(.primary800)
        }
    }
}

#Preview {
    CheckBox(checked: .constant(true), text: "hola soy un  texto")
}

