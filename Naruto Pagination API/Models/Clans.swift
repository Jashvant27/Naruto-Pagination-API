//
//  Clans.swift
//  Naruto Pagination API
//
//  Created by Jashvant Sewmangal on 09/12/2023.
//

struct Clans : Codable{
	let clans : [Clan]?
	let currentPage : Int
	let pageSize : Int
	let totalClans : Int
	
	func totalPages() -> Int {
		let result = self.totalClans / self.pageSize
		let remainder = self.totalClans % self.pageSize
		
		// If there's a remainder, round up
		return remainder == 0 ? result : result + 1
	}
}

struct Clan: Codable, Identifiable, Hashable{
	let id: Int
	let name: String?
	let characters: [Character]?
}

enum ClanStatus {
	case initial
	case success(data: [Clan])
	}
