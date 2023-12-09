//
//  ContentView.swift
//  Naruto Pagination API
//
//  Created by Jashvant Sewmangal on 06/12/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		TabView{
			Text("Character View")
				.tabItem {
					Label(LocalizedStringKey("characters_label"), systemImage: "person")
				}
				.tag(0)
			
			Text("Clans View")
				.tabItem {
					Label(LocalizedStringKey("clans_label"), systemImage: "person.3")
				}
				.tag(1)
		}
		.onAppear{
			UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
		}
    }
}

#Preview("Light Mode"){
	ContentView()
}

#Preview("Dark Mode") {
	ContentView().preferredColorScheme(.dark)
}
