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
        
        
        
        
    }

}
