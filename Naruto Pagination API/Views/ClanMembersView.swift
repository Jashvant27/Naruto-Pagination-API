//
//  ClanMembersView.swift
//  Naruto Pagination API
//
//  Created by Jashvant Sewmangal on 11/12/2023.
//

import SwiftUI

struct ClanMembersView: View {
	
	let clanName: String
	let clanMembers : [Character]
	
	var body: some View {
		VStack{
			List {
				ForEach(clanMembers, id: \.self) { item in
					// Display your item in a list row
					CharacterListView(character: item)
				}
			}
			.navigationTitle(clanName)
			.navigationBarTitleDisplayMode(.inline) // change style
		}
	}
}

#Preview {
	ClanMembersView(clanName: "Uchiha", clanMembers: [sampleCharacter()])
}
