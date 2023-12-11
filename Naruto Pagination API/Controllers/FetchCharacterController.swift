//
//  FetchController.swift
//  Naruto Pagination API
//
//  Created by Jashvant Sewmangal on 10/12/2023.
//

import Foundation

struct FetchCharacterController {
	private let baseURL = URL(string: "https://narutodb.xyz/api/character")!
	private let limit = 8
	
	func fetchCharacters(from page: Int) async throws -> Characters{
		// Create URL components
		var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
		
		// Add query items
		let pageQueryItem = URLQueryItem(name: "page", value: "\(page)")
		let limitQueryItem = URLQueryItem(name: "limit", value: "\(limit)")
		components?.queryItems = [pageQueryItem, limitQueryItem]
		
		// Check if URL is valid
		guard let fetchURL = components?.url else {
			throw NetworkError.badURL
		}
		
		// Get response
		let (data, response) = try await URLSession.shared.data(from: fetchURL)
		
		// Check if response is valid
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw NetworkError.badResponse
		}
		
		// Decode response
		let characters = try JSONDecoder().decode(Characters.self, from: data)
		
		// Return response
		return characters
	}
}
