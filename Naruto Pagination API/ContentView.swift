//
//  ContentView.swift
//  Naruto Pagination API
//
//  Created by Jashvant Sewmangal on 06/12/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview("Light Mode"){
	ContentView()
}

#Preview("Dark Mode") {
	ContentView().preferredColorScheme(.dark)
}
