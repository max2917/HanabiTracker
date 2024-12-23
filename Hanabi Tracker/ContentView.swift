//
//  ContentView.swift
//  Hanabi Tracker
//
//  Created by Max Stephenson on 12/19/24.
//

import SwiftUI

// Possible card attribute states
let NOINFO = 0
let KNOWN = 1
let NEGATIVE = 2

// Card attributes
let RED = 0
let YELLOW = 1
let GREEN = 2
let BLUE = 3
let TEAL = 4
let WHITE = 5
let ONE = 6
let TWO = 7
let THREE = 8
let FOUR = 9
let FIVE = 10


class Card: Identifiable {
    let id = UUID() // Unique identifier
    
    // Card states
    @State var red = NOINFO
    @State var yellow = NOINFO
    @State var green = NOINFO
    @State var blue = NOINFO
    @State var teal = NOINFO
    @State var white = NOINFO
    
    @State var one = NOINFO
    @State var two = NOINFO
    @State var three = NOINFO
    @State var four = NOINFO
    @State var five = NOINFO
}

struct ContentView: View {
    @State var cards = [
        Card(),
        Card(),
        Card(),
        Card(),
        Card(),
    ]
    
    var body: some View {
        List {
//            HStack {
//                ForEach(0..<5) { index in
//                    Button("", systemImage: "arrow.triangle.left.fill", action: { MassApplyClue(cards: cards) })
//                }
//            }
            ForEach($cards) { card in
                CardRowView(card: card) // Make a row for each card
            }
            .onDelete(perform: delete)
        }
    }
    
    // Swipe delete row function
    func delete(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)    // Remove the old card
        cards.append(Card())                // Append a new one to the front of the hand
    }
}


// Build the cell row for the card
struct CardRowView: View {
    @Binding var card: Card // The card this row represents
    @State private var redState:Int     = NOINFO
    @State private var yellowState:Int  = NOINFO
    @State private var greenState:Int   = NOINFO
    @State private var blueState:Int    = NOINFO
    @State private var tealState:Int    = NOINFO
    @State private var whiteState:Int   = NOINFO
    @State private var oneState:Int     = NOINFO
    @State private var twoState:Int     = NOINFO
    @State private var threeState:Int   = NOINFO
    @State private var fourState:Int    = NOINFO
    @State private var fiveState:Int    = NOINFO
    let SYMBOLSIZE:CGFloat = 40
    
    // Iterate the attribute state
    func stateUpdator(state: inout Int) {
        switch state {
        case NOINFO:
            state = KNOWN; break
        case KNOWN:
            state = NEGATIVE; break
        default:
            state = NOINFO
        }
    }
    
    // Return the approriate foreground color for the new state of teh attribute
    func symbolForeground(state: Int, color: Color) -> Color {
        return state == NEGATIVE ? .gray : color
    }
    
    // Return the approriate systemName for the state
    func symbolName(state: Int) -> String {
        return state == KNOWN ? "app.fill" : "app"
    }
    
    // Return the appropriate foreground color for the new state of the attribute
    func numForeground(state: Int) -> Color {
        return state == NEGATIVE ? .gray : .primary
    }
    
    // Return the appropriate opacity for the NEGATIVE state
    func attributeOpacity(state: Int) -> Double {
        return state == NEGATIVE ? 0.1 : 1.0
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                Button(action: { stateUpdator(state: &greenState) }) { label: do { Image(systemName: symbolName(state: greenState)) } }
                    .buttonStyle(PlainButtonStyle())
                    .font(.system(size: SYMBOLSIZE))
                    .foregroundStyle(symbolForeground(state: greenState, color: .green))
                    .opacity(attributeOpacity(state: greenState))
                Button(action: { stateUpdator(state: &yellowState) })  { label: do { Image(systemName: symbolName(state: yellowState)) } }
                    .buttonStyle(PlainButtonStyle()) // for tappability reasons
                    .font(.system(size: SYMBOLSIZE))
                    .foregroundStyle(symbolForeground(state: yellowState, color: .yellow))
                    .opacity(attributeOpacity(state: yellowState))
                Button(action: { stateUpdator(state: &redState) }) { label: do { Image(systemName: symbolName(state: redState)) } }
                    .buttonStyle(PlainButtonStyle())
                    .font(.system(size: SYMBOLSIZE))
                    .foregroundStyle(symbolForeground(state: redState, color: .red))
                    .opacity(attributeOpacity(state: redState))
            }
            VStack {
                Button(action: { stateUpdator(state: &whiteState) }) { label: do { Image(systemName: symbolName(state: whiteState)) } }
                    .buttonStyle(PlainButtonStyle())
                    .font(.system(size: SYMBOLSIZE))
                    .foregroundStyle(symbolForeground(state: whiteState, color: .gray))
                    .opacity(attributeOpacity(state: whiteState))
                Button(action: { stateUpdator(state: &tealState) }) { label: do { Image(systemName: symbolName(state: tealState)) } }
                    .buttonStyle(PlainButtonStyle())
                    .font(.system(size: SYMBOLSIZE))
                    .foregroundStyle(symbolForeground(state: tealState, color: .teal))
                    .opacity(attributeOpacity(state: tealState))
                Button(action: { stateUpdator(state: &blueState) }) { label: do { Image(systemName: symbolName(state: blueState)) } }
                    .buttonStyle(PlainButtonStyle())
                    .font(.system(size: SYMBOLSIZE))
                    .foregroundStyle(symbolForeground(state: blueState, color: .blue))
                    .opacity(attributeOpacity(state: blueState))
            }
            Spacer()
            HStack(spacing: 13) {
                Button(action: { stateUpdator(state: &oneState)}) { label: do { Image(systemName: oneState == KNOWN ? "1.circle.fill" : "1.circle") } }
                    .buttonStyle(PlainButtonStyle())
                    .font(.title)
                    .rotationEffect(Angle(degrees: -90))
                    .foregroundStyle(numForeground(state: oneState))
                    .opacity(attributeOpacity(state: oneState))
                Button(action: { stateUpdator(state: &twoState) }) { label: do { Image(systemName: twoState == KNOWN ? "2.circle.fill" : "2.circle") } }
                    .buttonStyle(PlainButtonStyle())
                    .font(.title)
                    .rotationEffect(Angle(degrees: -90))
                    .foregroundStyle(numForeground(state: twoState))
                    .opacity(attributeOpacity(state: twoState))
                Button(action: { stateUpdator(state: &threeState) }) { label: do { Image(systemName: threeState == KNOWN ? "3.circle.fill" : "3.circle") } }
                    .buttonStyle(PlainButtonStyle())
                    .font(.title)
                    .rotationEffect(Angle(degrees: -90))
                    .foregroundStyle(numForeground(state: threeState))
                    .opacity(attributeOpacity(state: threeState))
                Button(action: { stateUpdator(state: &fourState) }) { label: do { Image(systemName: fourState == KNOWN ? "4.circle.fill" : "4.circle") } }
                    .buttonStyle(PlainButtonStyle())
                    .font(.title)
                    .rotationEffect(Angle(degrees: -90))
                    .foregroundStyle(numForeground(state: fourState))
                    .opacity(attributeOpacity(state: fourState))
                Button(action: { stateUpdator(state: &fiveState) }) { label: do { Image(systemName: fiveState == KNOWN ? "5.circle.fill" : "5.circle") } }
                    .buttonStyle(PlainButtonStyle())
                    .font(.title)
                    .rotationEffect(Angle(degrees: -90))
                    .foregroundStyle(numForeground(state: fiveState))
                    .opacity(attributeOpacity(state: fiveState))
            }
        }
    }
}

func MassApplyClue(cards: [Card])
{
    
}

#Preview {
    ContentView()
}
