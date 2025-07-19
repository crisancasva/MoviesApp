//
//  PrimaryButton.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 14/07/25.
//

import SwiftUI

struct PrimaryButton: View {
    
    private var state: State = .enable
    private var title: String = ""
    private var onClick: (() -> Void)?
    private var leftIcon: Image?
    private var rightIcon: Image?
    private var size: BaseButton.Size = .full
    
    var body: some View{
        BaseButton(title: self.title)
            .foregroundColor(self.state.style.foregroundColor)
            .backgroundColor(self.state.style.backgroundColor)
            .leftIcon(self.leftIcon)
            .rightIcon(self.rightIcon)
            .onClick(self.state == .enable ? self.onClick : nil)
            .size(self.size)
        
    }
    init(title: String) {
        self.title = title
    }
    
    func leftIcon(_ value: Image?) -> Self {
        var view = self
        view.leftIcon = value
        return view
    }
    
    func rightIcon(_ value: Image?) -> Self {
        var view = self
        view.rightIcon = value
        return view
    }
    
    func state(_ value: State) -> Self {
        var view = self
        view.state = value
        return view
    }
    
    func onClick(_ value: (() -> Void)?) -> Self {
        var view = self
        view.onClick = value
        return view
    }
    
    func size(_ value: BaseButton.Size) -> Self {
        var view = self
        view.size = value
        return view
    }
}

extension PrimaryButton {
    enum State {
        case enable
        case disable
        
        var style: (backgroundColor: Color, foregroundColor: Color) {
            switch self {
            case .enable:
                (Color.primary900, Color.white)
            case .disable:
                (Color.primary800, Color.white)
            }
        }
    }
    
}

#Preview {
    PrimaryButton(title: "prueba 1")
        .onClick{
            print("Hola me tocaron por 1")
        }
        .leftIcon(Image(systemName: "figure.walk.arrival"))
        .rightIcon(Image(systemName: "poweroutlet.type.f.fill"))
        .state(.enable)
    Spacer()
    PrimaryButton(title: "Prueba 2")
        .onClick {
            print("Hola me tocaron por 2")
        }
        .size(.fit)
        .state(.disable)
}
