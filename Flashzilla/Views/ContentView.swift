//
//  ContentView.swift
//  Flashzilla
//
//  Created by Arthur Sh on 08.01.2023.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var vm = ViewModel()
    
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                if vm.timeRemaining > 0 {
                    Text("\(vm.timeRemaining)")
                        .padding()
                        .foregroundColor(.white)
                        .background(.black.opacity(0.75))
                        .font(.title2)
                        .clipShape(Capsule())
                } else {
                    Button("Start Again", action: startAgain)
                        .padding()
                        .foregroundColor(.white)
                        .background(.black)
                        .clipShape(Capsule())
                }
                
                ZStack{
                    ForEach(0..<vm.cards.count, id: \.self) { index in
                        CardView(card: vm.cards[index]) {
                            withAnimation {
                                removeCard(at: index)}
                        }
                        .stacked(at: index, total: vm.cards.count)
                        .allowsHitTesting(index == vm.cards.count - 1)
                    }
                }
                .allowsHitTesting(vm.timeRemaining > 0) // MARK: disabling swipes when time went to 0
                
                if vm.cards.isEmpty {
                    Button("Start Again", action: startAgain)
                        .padding()
                        .foregroundColor(.white)
                        .background(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack{
                HStack{
                    Spacer()
                    Button{
                        vm.isEditViewShowing = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.75))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            
        }
        .onReceive(vm.timer) { time in
            guard vm.isActive else { return }
            
            if vm.timeRemaining > 0 {
                vm.timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newScene in
            if newScene == .active  {
                if vm.cards.isEmpty == false { //MARK: is active only if there are cards
                    vm.isActive = true
                }
            } else {
                vm.isActive = false
            }
        }
        .sheet(isPresented: $vm.isEditViewShowing, content: EditCards.init)
        //MARK: calling view with.init the same as { EditCards() } and it works because it has no custom values in takes no parameters!
        .onAppear(perform: startAgain)
    }
    
    func startAgain() {
        vm.loadData()
        vm.timeRemaining = 100
        vm.isActive = true
    }
    
    func removeCard(at index: Int) {
        vm.cards.remove(at: index)
        
        if vm.cards.isEmpty {
            vm.isActive = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
