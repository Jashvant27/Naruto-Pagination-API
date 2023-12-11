//
//  CharacterListView.swift
//  Naruto Pagination API
//
//  Created by Jashvant Sewmangal on 11/12/2023.
//

import SwiftUI

struct CharacterListView: View {
	let character: Character
	
	var body: some View {
			HStack(){
				//Icon
				if (character.images?.first != nil){
					AsyncImage(url: character.images?.first) { phase in
						switch phase {
							case .empty:
								// Placeholder or loading view
								ProgressView()
							case .success(let image):
								image
									.resizable() // Make the image resizable
									.scaledToFill()
									.frame(width:100.0, height: (UIScreen.main.bounds.width / 4))
									.clipShape(RoundedRectangle(cornerRadius: 10))
							case .failure:
								// Error view
								Image(.listviewFallback)
									.resizable()
									.scaledToFill()
									.frame(width:100.0, height: (UIScreen.main.bounds.width / 4))
									.clipShape(RoundedRectangle(cornerRadius: 10))
							@unknown default:
								Image(.listviewFallback)
									.resizable()
									.scaledToFill()
									.frame(width:100.0, height: (UIScreen.main.bounds.width / 4))
									.clipShape(RoundedRectangle(cornerRadius: 10))
						}
					}
				} else {
					Image(.listviewFallback)
						.resizable()
						.scaledToFill()
						.frame(width:100.0, height: (UIScreen.main.bounds.width / 4))
						.clipShape(RoundedRectangle(cornerRadius: 10))
				}
				
				Spacer()

				VStack(alignment: .trailing, spacing: 5.0){
					//Identity
					Text(character.name ?? "").font(.title2).bold().padding(.bottom, 4.0).multilineTextAlignment(.trailing)
					Text("\(character.id)").padding(.top, 4.0)
				}
			}.padding(.horizontal, 5.0)
		}
//	}
}

#Preview("Light Mode", traits: .sizeThatFitsLayout) {
	CharacterListView(character: sampleCharacter())
}

#Preview("Dark Mode", traits: .sizeThatFitsLayout) {
	CharacterListView(character: sampleCharacter()).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
