//
//  ClanViewModel.swift
//  Naruto Pagination API
//
//  Created by Jashvant Sewmangal on 11/12/2023.
//

import Foundation

@MainActor class ClanViewModel: ObservableObject{
	//Status-properties
	@Published private(set) var status: ClanStatus = .initial
	@Published private(set) var isLoading: Bool = false
	
	//Error-properties
	@Published var showToast: Bool = false
	@Published var errorMessage: String = ""
	
	//Pagination-properties
	private var nextPage = 1
	@Published private(set) var allowNextPageToLoad = true
	
	//Private set to add what is loaded
	private var allClans: Set<Clan> = []
	
	//Controller
	private let clanController: FetchClanController
	
	init(controller: FetchClanController){
		//Initialise properties
		self.clanController = controller
	}
	
	func getData() async{
		//Return if already loading
		guard !isLoading else { return }
		
		//Notify that it's loading
		isLoading = true
		
		do {
			//Load characters and add to set
			let apiClans = try await clanController.fetchClans(from: nextPage)
			allClans.formUnion(apiClans.clans ?? [])
			
			//Sort this set/convert to array. Give this sorted array to status
			let sortedArray = allClans.sorted{ $0.id < $1.id }
			status = .success(data: sortedArray)
			
			//Update error and loading properties
			showToast = false
			isLoading = false
			
			//Update pagination properties
			nextPage = apiClans.currentPage + 1
			allowNextPageToLoad = (apiClans.currentPage + 1) <= apiClans.totalPages()
		} catch{
			//Notify loading and error-properties
			isLoading = false
			showToast = true
			errorMessage = error.localizedDescription
		}
		
	}
}
