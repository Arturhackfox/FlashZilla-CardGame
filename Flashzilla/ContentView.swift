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
    
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                Text("\(vm.timeRemaining)")
                    .padding()
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .font(.title2)
                    .clipShape(Capsule())
                
                ZStack{
                    ForEach(0..<cards.count - 1, id: \.self) { index in
                        CardView(card: cards[index]) {
                            withAnimation {
                                removeCard(at: index)}
                        }
                        .stacked(at: index, total: cards.count)
                    }
                }
            }
        }
        .onReceive(vm.timer) { time in
            guard vm.isActive else { return }
            
            if vm.timeRemaining > 0 {
                vm.timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newScene in
            if newScene == .active  {
                vm.isActive = true
            } else {
                vm.isActive = false
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
