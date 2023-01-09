//
//  ViewModel-ContentView.swift
//  Flashzilla
//
//  Created by Arthur Sh on 09.01.2023.
//

import Foundation
import SwiftUI

extension View {
    func stacked(at position: Int, total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
        
    }
}

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published  var  timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        @Published  var timeRemaining = 100
        
        @Published  var isActive = false
        
        
        
        
    }
    
}
