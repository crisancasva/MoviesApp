//
//  NavigatorBarStyle.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 9/08/25.
//
import SwiftUI

struct NavigatorActionButton {
    let title: String
    let action: (()-> Void)?
}

struct NavigatorBarTitleWithBackAndAction: ViewModifier {
    private let title: String
    private let trailingAction: NavigatorActionButton
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal){
                    HStack(spacing: Spacing._xs){
                        
                        TextLabel(text: self.title, color: .neutral500)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.trailingAction.action?()
                    } label: {
                        TextLabel(text: self.trailingAction.title)
                    }
                }
            }
        
    }
    
    init(title: String, trailingAction: NavigatorActionButton) {
        self.title = title
        self.trailingAction = trailingAction
    }
}
    
struct NavigatorBarTitleWithBack: ViewModifier {
    private let title: String
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    HStack(spacing: Spacing._xs){
                        Button {
                            NavigatorViewManager.shared.pop()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.neutral500)
                            
                        }
                        TextLabel(text: self.title, color: .neutral500)
                    }
                }
            }
        
    }
    init(title: String) {
        self.title = title
    }
}

struct NavigatorBarHidden: ViewModifier{
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    EmptyView()
                }
                ToolbarItem(placement: .principal) {
                    EmptyView()
                }
            }
    }
}

struct NavigationBarModifier: ViewModifier {
    private let navBody: (AnyView) -> AnyView
    
    init<Modifier: ViewModifier>(modifier: Modifier) {
        self.navBody = { content in
            AnyView(content.modifier(modifier))
        }
    }
    
    func body(content: Content) -> some View {
        self.navBody(AnyView(content))
    }
}

enum NavigatorBarStyle {
    case hidden
    case titleWithBack(String)
    case titleBackAndAction(String, NavigatorActionButton)
    
    var modifier: NavigationBarModifier {
        switch self {
        case .hidden:
            NavigationBarModifier(modifier: NavigatorBarHidden())
        case .titleWithBack(let title):
            NavigationBarModifier(modifier: NavigatorBarTitleWithBack(title: title))
        case .titleBackAndAction(let title, let action): NavigationBarModifier(modifier: NavigatorBarTitleWithBackAndAction(title: title, trailingAction: action))
        }
    }
}

extension View {
    func navigatorBarStyle(_ style: NavigatorBarStyle) -> some View {
        self.modifier(style.modifier)
    }
}
