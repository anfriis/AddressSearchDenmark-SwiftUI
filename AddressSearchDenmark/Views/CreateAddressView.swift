//
//  CreateAddressView.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 15/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI

struct CreateAddressView: View {
    
    @EnvironmentObject var viewModel: CreateAddressViewModel
    @Binding var isPresented: Bool
    
    enum TextFieldTag: Int {
        case title, subtitle
    }
    
    @State var activeTextField: TextFieldTag?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create Address")
                .font(.headline)
            
            HStack(alignment: .center, spacing: 10) {
                FormTextField(
                    placeholder: "Address title",
                    text: $viewModel.title,
                    returnKey: ReturnKey(
                        type: .next,
                        shouldResignFirstResponder: false,
                        handler: {
                            self.activeTextField = TextFieldTag.subtitle
                    }
                    ),
                    maxTextLength: 18,
                    responder: TextFieldTag.title.rawValue == self.activeTextField?.rawValue ? .active : .inactive,
                    onEditingChanged: { isEditing in
                        if isEditing { self.activeTextField = nil }
                }
                )
                    .tag(TextFieldTag.title.rawValue)
                
                ValidationView(validation: viewModel.titleValidation)
            }
            
            HStack(alignment: .center, spacing: 10) {
                FormTextField(
                    placeholder: "Address subtitle",
                    text: $viewModel.subtitle,
                    returnKey: ReturnKey(
                        type: .done,
                        shouldResignFirstResponder: true,
                        handler: { self.activeTextField = nil }
                    ),
                    maxTextLength: 18,
                    responder: TextFieldTag.subtitle.rawValue == self.activeTextField?.rawValue ? .active : .inactive,
                    onEditingChanged: { isEditing in
                        if isEditing { self.activeTextField = nil }
                }
                )
                    .tag(TextFieldTag.subtitle.rawValue)
                
                ValidationView(validation: viewModel.subtitleValidation)
            }
            
            AppButton("Create", action: {
                self.viewModel.createAddress()
                self.isPresented = false
            }, disabled: self.viewModel.validationResult != .valid)
                .buttonStyle(ButtonStylePrimary())
            
            ValidationView(validation: viewModel.validationResult)
            
            Spacer()
        }
        .onAppear(perform: {
            // Wait till this view has appeared and transitioned modally, to avoid crashing when setting first responder
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.activeTextField = .title
            }
        })
            .padding(50)
    }
    
    struct ValidationView: View {
        var validation: InputValidation
        
        var body: some View {
            Group {
                if validation == .pending {
                    Rectangle()
                        .frame(width: 10, height: 1)
                        .foregroundColor(Colors.tint)
                } else if validation == .error {
                    Image(systemName: "multiply").foregroundColor(Color.red)
                } else if validation == .valid {
                    Image(systemName: "checkmark").foregroundColor(Color.green)
                }
            }
            .frame(width: 10)
        }
    }
}


struct CreateAddressView_Previews: PreviewProvider {
    @State static var isPresented = true
    
    static var previews: some View {
        ViewFactory.default.makeCreateAddressView(isPresented: $isPresented)
    }
}
