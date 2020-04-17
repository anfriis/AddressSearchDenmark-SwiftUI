//
//  AppButton.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 15/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI

struct AppButton: View {
  
    var title: String
    var action: () -> Void
    var disabled: Bool

    init(_ title: String = "Button", action: @escaping () -> Void = {}, disabled: Bool = false) {
        self.title = title
        self.action = action
        self.disabled = disabled
    }
    
    var body: some View {
        Button(action: !disabled ? action : {}) {
            Text(title).frame(height: 50)
        }
    }
}

struct ButtonStylePrimary: ButtonStyle {
    var disabled = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding(.horizontal, 50)
            .background(disabled ? .gray : configuration.isPressed ? Colors.tintDark : Colors.tint)
            .scaleEffect(configuration.isPressed && !disabled ? 0.95 : 1.0)
            .cornerRadius(14)
    }
}

struct ButtonStyleSecondary: ButtonStyle {
    var disabled = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(disabled ? .gray : configuration.isPressed ? Colors.tintDark : Colors.tint)
            .padding(.horizontal, 50)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(
                        disabled ? .gray : configuration.isPressed ? Colors.tintDark : Colors.tint,
                        lineWidth: configuration.isPressed ? 3 : 2
            ))
            .scaleEffect(configuration.isPressed && !disabled ? 0.95 : 1.0)
        
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AppButton("Button", action: {

            }).buttonStyle(ButtonStylePrimary())
                .padding(.bottom, 30)
            
            AppButton("Second button", action: {
                
            }).buttonStyle(ButtonStyleSecondary())
        }
        .previewLayout(.sizeThatFits)
        .padding(.all, 20)
    }
}
