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
	
	func totalPages() -> Int {
		let result = self.totalCharacters / self.pageSize
		let remainder = self.totalCharacters % self.pageSize
		
		// If there's a remainder, round up
		return remainder == 0 ? result : result + 1
	}
}

struct Character : Codable, Identifiable {
	let id : Int
	let name: String?
	let images: [URL]?
	let jutsu: [String]?
	let natureType: [String]?
	let personal: Personal?
}

struct Personal: Codable{
	let birthday: String?
	let sex: String?
	let affiliation: [String]?
	let team: [String]?
	let clan: String?
}
