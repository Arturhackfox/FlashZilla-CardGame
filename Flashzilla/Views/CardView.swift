//
//  CardView.swift
//  Flashzilla
//
//  Created by Arthur Sh on 09.01.2023.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: (() -> Void)? = nil
    
    @State var isAnswerShowng = false
    @State var offset = CGSize.zero
    
    @State var haptics = UINotificationFeedbackGenerator()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.white.opacity(1 - Double(abs(offset.width / 50))))
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(offset.width > 0 ? .green : .red)
                )
                .shadow(radius: 20)
            
            VStack {
                Text(card.prompt)
                    .foregroundColor(.black)
                    .font(.largeTitle)
                
                if isAnswerShowng {
                    Text(card.name)
                        .foregroundColor(.gray)
                        .font(.title)
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5 , y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
        DragGesture()
            .onChanged { change in
                offset = change.translation
                haptics.prepare() //MARK: Prepering before buzzing
            }
            .onEnded { _ in
                //MARK: Haptics if error buzz
                if offset.width < 0 {
                    haptics.notificationOccurred(.error)
                }
                //MARK: remove closure takes func anytime it goes beyond 100 left or right
                if abs(offset.width) > 100 {
                    removal?()
                }
                else {
                    offset = .zero
                }
            }
        )
        .onTapGesture {
            isAnswerShowng.toggle()
        }
        .animation(.spring(), value: offset) //MARK:  card goes back in deck with animation
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
