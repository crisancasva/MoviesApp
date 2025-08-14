//
//  TapBarViewApp.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 11/08/25.
//

import SwiftUI

struct TabBarViewApp: View {
    @State private var selectedIndex: Int = 0
    private var items: [TabBarViewApp.Item]
    
    var body: some View {
        VStack(spacing: Spacing._none){
            TabView(selection: self.$selectedIndex) {
                ForEach(self.items.indices, id: \.self){ index in
                    self.items[index]
                        .view
                        .tag(index)
                }
            }
            TabBarViewApp.TabBar(selectedIndex: self.$selectedIndex, items: self.items)
        }
    }
    init(items: [TabBarViewApp.Item]) {
        self.items = items
        UITabBar.appearance().isHidden = true
    }
}
extension TabBarViewApp {
    private struct TabBar: View {
        @Binding var selectedIndex: Int
        private var items: [TabBarViewApp.Item]
     
        var body: some View {
            HStack{
                ForEach(self.items.indices, id: \.self) { index in
                    TabItem(item: self.items[index], index: index, selectedIndex:  self.$selectedIndex)
                }
            }
        }
        init(selectedIndex: Binding<Int>, items: [TabBarViewApp.Item]) {
            self._selectedIndex = selectedIndex
            self.items = items
        }
    }
    private struct TabItem: View {
        
        var item: TabBarViewApp.Item
        var index: Int
        @Binding var selectedIndex: Int
        
        var body: some View {
            VStack(spacing: Spacing._xs){
                self.item.icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundStyle(self.index == self.selectedIndex ? self.item.selectedColor : self.item.unSelectedcolor)
                TextLabel(text: self.item.title, color: self.index == self.selectedIndex ? self.item.selectedColor : self.item.unSelectedcolor)
                    
            }
            .frame(maxWidth: .infinity)
            .padding(Spacing._md)
            .onTapGesture {
                self.selectedIndex = self.index
            }
            
        }
    }
    struct Item: Identifiable {
        let id = UUID()
        let icon: Image
        let title: String
        let selectedColor: Color
        let unSelectedcolor: Color
        let view: AnyView
        
        init(view: AnyView, icon: Image, title: String, selectedColor: Color = .primary900 , unSelectedcolor: Color = .neutral300) {
            self.view = view
            self.icon = icon
            self.title = title
            self.selectedColor = selectedColor
            self.unSelectedcolor = unSelectedcolor
        }
    }
}

#Preview {TabBarViewApp(items:
    [
    TabBarViewApp.Item(view: AnyView(MovieListView.buildMock()), icon: Image(systemName: "list.bullet"), title: "Todos"),
    TabBarViewApp.Item(view: AnyView(MovieListView.buildMock()), icon: Image(systemName: "richtext.page.fill"), title: "Detalle")
])
}
