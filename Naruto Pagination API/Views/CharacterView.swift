//
//  CharacterView.swift
//  Naruto Pagination API
//
//  Created by Jashvant Sewmangal on 11/12/2023.
//

import SwiftUI
import AlertToast

struct CharacterView: View {
	@StateObject private var viewModel = CharacterViewModel(controller: FetchCharacterController())
	
	var body: some View {
		VStack{
			switch(viewModel.status){
				case .initial:
					ProgressView()
						.task {
							await viewModel.getData()
						}
				case .success(let data):
					NavigationView {
						List {
							ForEach(data, id: \.self) { item in
								// Display your item in a list row
								CharacterListView(character: item)
							}
							if viewModel.allowNextPageToLoad {
								ProgressView().task {
									await viewModel.getData()
								}
							}
						}
						.navigationTitle(LocalizedStringKey("characters_label"))
						.task {
							await viewModel.getData()
						}
					}
			}
		}
		.toast(isPresenting: $viewModel.showToast){
			AlertToast(type: .error(Color.red), title: viewModel.errorMessage)
		}
	}
}

#Preview("Light Mode"){
	CharacterView()
}

#Preview("Dark Mode") {
	CharacterView().preferredColorScheme(.dark)
}

