//
//  FollowTextField.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 15/07/25.
//

import SwiftUI

struct FollowTextField: View {
    @Binding var text: String
    
    private var onEditingChanged: (() -> Void)?
 
    internal
    var body: some View {
        BaseTextField(text: $text)
            .onEditingChanged(self.onEditingChanged)
            .leftView(AnyView(self.iconButton))
            .backgroundColor(.neutral100)
        
    }
    init(text: Binding<String>) {
        _text = text
    }
    
    func onEditingChanged(_ value: (() -> Void)?) -> Self {
        var view = self
        view.onEditingChanged = value
        return view
    }
    private var iconButton: some View {
        Image(systemName: "magnifyingglass")
           
    }
}

