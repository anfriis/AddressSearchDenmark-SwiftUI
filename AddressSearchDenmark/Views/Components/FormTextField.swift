//
//  TextFieldView.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 15/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI

struct FormTextField: View {
    
    let placeholder: String
    let text: Binding<String>
    let returnKey: ReturnKey
    var maxTextLength: Int?
    var responder: TextFieldResponderState
    // Bool: isEditing
    var onEditingChanged: (Bool) -> Void
    
    init(
        placeholder: String = "",
        text: Binding<String>,
        returnKey: ReturnKey = ReturnKey(type: .done, shouldResignFirstResponder: true, handler: {}),
        maxTextLength: Int? = nil,
        responder: TextFieldResponderState = .inactive,
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) {
        self.placeholder = placeholder
        self.text = text
        self.returnKey = returnKey
        self.maxTextLength = maxTextLength
        self.responder = responder
        self.onEditingChanged = onEditingChanged
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14, style: .circular)
                .foregroundColor(Color.white)
                .shadow(radius: 2)
            
            RespondingTextField(
                placeholder: placeholder,
                text: text,
                textColor: .black,
                returnKey: returnKey,
                maxTextLength: maxTextLength,
                responder: responder,
                onEditingChanged: onEditingChanged
            )
                .padding(.horizontal, 14)
            
        }
        .frame(height: 50)
        
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                FormTextField(text: .constant(""))
                FormTextField(placeholder: "Name", text: .constant(""))
            }
            .environment(\.colorScheme, .light)
            
            VStack {
                FormTextField(text: .constant(""))
                FormTextField(placeholder: "Name", text: .constant(""))
            }
            .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
        .padding(.all, 20)
    }
}
