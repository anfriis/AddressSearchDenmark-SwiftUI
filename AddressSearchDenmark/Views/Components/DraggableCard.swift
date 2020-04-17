//
//  DraggableCardView.swift
//  AddressSearchDenmark
//
//  Created by Anders Friis on 14/04/2020.
//  Copyright © 2020 Anders Friis. All rights reserved.
//

import SwiftUI

struct DraggableCard<Content: View>: View {
    
    var content: () -> Content
    
    @State var position: CardPosition = .bottom
    @GestureState private var dragState = DragState.none
    
    var drag: some Gesture {
        DragGesture()
            .updating($dragState) { drag, state, transaction in
                state = .dragging(translation: drag.translation)
        }
        .onEnded(self.dragEnded)
    }
    
    var body: some View {
        VStack {
            Handle()
                .padding(.top, 20)
            self.content()
        }
        .frame(
            width: UIScreen.main.bounds.width - (self.dragState.isDragging == false && self.position == .bottom ? 30 : 0),
            height: UIScreen.main.bounds.height
        )
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .foregroundColor(.primary)
            .shadow(radius: 4)
            .offset(y: self.position.offset + self.dragState.translation.height)
            .animation(self.dragState.isDragging ? nil : .interpolatingSpring(stiffness: 200, damping: 30, initialVelocity: 10))
            .gesture(self.drag)
    }
    
    private func dragEnded(gesture: DragGesture.Value) {
        let verticalDirection = gesture.predictedEndLocation.y - gesture.location.y
        let cardTopEdgeLocation = self.position.offset + gesture.translation.height
        let positionAbove: CardPosition
        let positionBelow: CardPosition
        let closestPosition: CardPosition
        if cardTopEdgeLocation <= CardPosition.middle.offset {
            positionAbove = .top
            positionBelow = .middle
        } else {
            positionAbove = .middle
            positionBelow = .bottom
        }
        if (cardTopEdgeLocation - positionAbove.offset) < (positionBelow.offset - cardTopEdgeLocation) {
            closestPosition = positionAbove
        } else {
            closestPosition = positionBelow
        }
        if verticalDirection > 0 {
            self.position = positionBelow
        } else if verticalDirection < 0 {
            self.position = positionAbove
        } else {
            self.position = closestPosition
        }
    }
}

enum CardPosition: Double {
    case top = 0.95
    case middle = 0.5
    case bottom = 0.3
    
    var offset: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight - (screenHeight * CGFloat(self.rawValue))
    }
    
    var coveringPortionOfScreen: Double {
        return self.rawValue
    }
}

enum DragState {
    case none
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .none:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .none: return false
        case .dragging: return true
        }
    }
}

struct DraggableCard_Previews: PreviewProvider {
    static var previews: some View {
        DraggableCard() {
            Text("Hello")
        }
    }
}
