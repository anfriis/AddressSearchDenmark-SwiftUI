//
//  SearchBar.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 08/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isLoading: Bool
    
    @State private var showCancelButton: Bool = false
    
    var onCommit: () -> Void = {}
    
    var body: some View {
        // Search view
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                RespondingTextField(
                    placeholder: "Search",
                    text: $searchText,
                    returnKey: ReturnKey(
                        type: .search,
                        shouldResignFirstResponder: true,
                        handler: onCommit
                    ),
                    onEditingChanged: { isEditing in
                        self.showCancelButton = isEditing
                }
                )
                    .frame(height: 25)
                
                ActivityIndicator(isAnimating: $isLoading, style: .medium)
                
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
            
            if self.showCancelButton  {
                Button("Cancel") {
                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                    self.searchText = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
            .navigationBarHidden(self.showCancelButton) // .animation(.default) // animation does not work properly
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant("Test"), isLoading: .constant(false))
    }
}
