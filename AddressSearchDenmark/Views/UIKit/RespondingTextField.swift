//
//  CustomTextField.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 15/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI
import UIKit

struct RespondingTextField: UIViewRepresentable {
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        var returnKey: ReturnKey?
        var maxTextLength: Int? = nil
        var onEditingChanged: ((Bool) -> Void)?
        
        init(placeholder: String = "", text: Binding<String>) {
            _text = text
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            // We have to listen for text fields becoming active, e.g. if the user presses the text field without using the return key. Notify the parent about this so active text field can be updated.
            
            // Must be run async on the main thread to avoid a state update warning when used:
            // "Modifying state during view update, this will cause undefined behavior."
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.onEditingChanged?(true)
            }
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.onEditingChanged?(false)
            }
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            self.text = textField.text ?? ""
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let maxTextLength = self.maxTextLength else { return true }
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxTextLength
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let returnKey = self.returnKey {
                if returnKey.shouldResignFirstResponder {
                    textField.resignFirstResponder()
                }
                returnKey.handler()
            }
            return true
        }
    }
    
    let placeholder: String
    let placeholderColor: UIColor = .gray
    @Binding var text: String
    var textColor: UIColor? = UIColor.label
    let returnKey: ReturnKey
    var maxTextLength: Int? = nil
    var responder: TextFieldResponderState = .inactive
    var onEditingChanged: (Bool) -> Void = { _ in }
    
    func makeUIView(context: UIViewRepresentableContext<RespondingTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.attributedPlaceholder = NSAttributedString(string: self.placeholder, attributes: [NSAttributedString.Key.foregroundColor: self.placeholderColor])
        textField.textColor = self.textColor
        textField.tintColor = self.textColor
        textField.returnKeyType = self.returnKey.type
        context.coordinator.returnKey = self.returnKey
        context.coordinator.maxTextLength = self.maxTextLength
        context.coordinator.onEditingChanged = self.onEditingChanged
        
        return textField
    }
    
    func makeCoordinator() -> RespondingTextField.Coordinator {
        return Coordinator(text: $text)
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<RespondingTextField>) {
        uiView.text = text
        
        if self.responder == .active {
            uiView.becomeFirstResponder()
        }
    }
    
}

enum TextFieldResponderState {
    case active, inactive
}

struct ReturnKey {
    let type: UIReturnKeyType
    let shouldResignFirstResponder: Bool
    let handler: () -> Void
}

struct RespondingTextFieldView_Previews: PreviewProvider {
    
    static var textField: some View {
        RespondingTextField(placeholder: "Textfield", text: .constant(""), returnKey: ReturnKey(type: .done, shouldResignFirstResponder: true, handler: {}))
    }
    
    static var previews: some View {
        Group {
            VStack {
                self.textField
            }
            .environment(\.colorScheme, .light)
            
            VStack {
                self.textField
            }
            .environment(\.colorScheme, .dark)
        }
        .previewLayout(.fixed(width: 300, height: 50))
        .padding(.all, 20)
    }
    
}
