//
//  EditCards.swift
//  Flashzilla
//
//  Created by Arthur Sh on 09.01.2023.
//

//4 swipe to delite cards
//5 section to add new card promt and naswer
//6 method load and save from userdefaukts

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State var allCards = [Card]()
    
    @State var name = ""
    @State var prompt = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("add new card"){
                    TextField("Prompt", text: $prompt)
                    TextField("Answer", text: $name)
                    Button("Add card", action: addNewCard)
                }
                ForEach(0..<allCards.count, id: \.self) { index in
                    VStack(alignment: .leading){
                        Text(allCards[index].prompt)
                            .font(.headline)
                        Text(allCards[index].name)
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: deleteRow)
              
            }
            .toolbar {
                Button("Done") { dismiss() }
            }
            .onAppear(perform: loadData)
        }
    }
    
    func addNewCard() {
        let newCard = Card(name: name, prompt: prompt)
        allCards.insert(newCard, at: 0)
        name = ""
        prompt = ""
        save()
    }
    
    func loadData() {
        do{
            if let data = UserDefaults.standard.data(forKey: "Cards") {
                allCards = try JSONDecoder().decode([Card].self, from: data)
            }
        } catch {
            print("failed to load the data.")
        }
    }
    
    func save() {
        do {
            let encoded = try JSONEncoder().encode(allCards)
             UserDefaults.standard.set(encoded, forKey: "Cards")
        } catch {
            print("failed to save the data.")
        }
    }
    
    func deleteRow (at offset: IndexSet) {
        allCards.remove(atOffsets: offset)
        save()
    }
    
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
