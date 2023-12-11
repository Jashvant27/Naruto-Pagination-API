//
//  Characters.swift
//  Naruto Pagination API
//
//  Created by Jashvant Sewmangal on 09/12/2023.
//

import Foundation

struct Characters : Codable {
	let characters : [Character]?
	let currentPage : Int
	let pageSize : Int
	let totalCharacters : Int

	private enum CodingKeys: String, CodingKey {
		case characters
		case currentPage
		case pageSize
		case totalCharacters
	}
	
	func totalPages() -> Int {
		let result = self.totalCharacters / self.pageSize
		let remainder = self.totalCharacters % self.pageSize
		
		// If there's a remainder, round up
		return remainder == 0 ? result : result + 1
	}
}

struct Character: Codable, Identifiable, Hashable, Equatable {
	let id: Int
	let name: String?
	let images: [URL]?
	
	// Custom hash(into:) implementation
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case images
	}
	
}

func sampleCharacter() -> Character {
	return Character(id: 1310, name: "Shisui Uchiha", images: [URL(string: "https://static.wikia.nocookie.net/naruto/images/4/4c/Shisui_Uchiha.png")!])
}

enum CharacterStatus {
	case initial
	case success(data: [Character])
	}
