//
//  CharacterViewModel.swift
//  Naruto Pagination API
//
//  Created by Jashvant Sewmangal on 11/12/2023.
//

import Foundation

@MainActor class CharacterViewModel: ObservableObject{
		
	//Status-properties
	@Published private(set) var status: CharacterStatus = .initial
	@Published private(set) var isLoading: Bool = false
	
	//Error-properties
	@Published var showToast: Bool = false
	@Published var errorMessage: String = ""

	//Pagination-properties
	private var nextPage = 1
	@Published private(set) var allowNextPageToLoad = true
	
	//Private set to add what is loaded
	private var allCharacters: Set<Character> = []
	
	//Controller
	private let characterController: FetchCharacterController
	
	init(controller: FetchCharacterController){
		//Initialise properties
		self.characterController = controller
	}
	
	func getData() async{
		//Return if already loading
		guard !isLoading else { return }

		//Notify that it's loading
		isLoading = true
		
		do {
			//Load characters and add to set
			let apiCharacters = try await characterController.fetchCharacters(from: nextPage)
			allCharacters.formUnion(apiCharacters.characters ?? [])
			
			//Sort this set/convert to array. Give this sorted array to status
			let sortedArray = allCharacters.sorted{ $0.id < $1.id }
			status = .success(data: sortedArray)
			
			//Update error and loading properties
			showToast = false
			isLoading = false
			
			//Update pagination properties
			nextPage = apiCharacters.currentPage + 1
			allowNextPageToLoad = (apiCharacters.currentPage + 1) <= apiCharacters.totalPages()
		} catch{
			//Notify loading and error-properties
			isLoading = false
			showToast = true
			errorMessage = error.localizedDescription
		}
	}
}
