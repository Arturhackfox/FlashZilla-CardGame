//
//  ContentView.swift
//  Flashzilla
//
//  Created by Arthur Sh on 08.01.2023.
//

import SwiftUI


struct ContentView: View {
    @State private var cards = Array<Card>(repeatElement(Card.example, count: 12))
    @StateObject private var vm = ViewModel()
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                ZStack{
                    ForEach(0..<cards.count - 1, id: \.self) { index in
                        CardView(card: cards[index]) { removeCard(at: index)}
                            .stacked(at: index, total: cards.count)
                    }
                }
            }
        }
    }
    
    func removeCard(at index: Int) {
        cards.remove(at: index)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
