//
//  ClanView.swift
//  Naruto Pagination API
//
//  Created by Jashvant Sewmangal on 11/12/2023.
//

import SwiftUI
import AlertToast

struct ClanView: View {
	@StateObject private var viewModel = ClanViewModel(controller: FetchClanController())

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
								let clanname = item.name ?? ""
								
								NavigationLink(destination: ClanMembersView(clanName: clanname, clanMembers: item.characters ?? [])){
									Text(clanname)
								}
							}
							if viewModel.allowNextPageToLoad {
								ProgressView().task {
									await viewModel.getData()
								}
							}
						}
						.navigationTitle(LocalizedStringKey("clans_label"))
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

#Preview {
    ClanView()
}
