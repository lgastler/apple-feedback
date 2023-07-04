//
//  ContentView.swift
//  SwiftDataEmptyCrash
//
//  Created by Lennart Gastler on 04.07.23.
//

import SwiftUI
import SwiftData

@Model
class Contact {
    var name: String
    var messages: [Message]
    
    init(name: String) {
        self.name = name
    }
}

@Model
class Message {
    var content: String
    
    init(content: String) {
        self.content = content
    }
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var contacts: [Contact]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(contacts) { contact in
                    NavigationLink(value: contact) {
                        Text(contact.name)
                    }
                }
            }
            .navigationDestination(for: Contact.self) { contact in
                List {
                    ForEach(contact.messages) { message in
                        Text(message.content)
                    }
                    .onDelete { indexSet in
                        for item in indexSet {
                            let object = contact.messages[item]
                            modelContext.delete(object)
                        }
                    }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                Button(action: createContact, label: {
                    Label("Create Contact", systemImage: "plus")
                })
            }
        }
    }
    
    func createContact() {
        let name = "\(contacts.count + 1)"
        let newContact = Contact(name: name)
        let messages = [
            Message(content: "Message One"),
            Message(content: "Message Two"),
            Message(content: "Message Three")
        ]
        newContact.messages = messages
        modelContext.insert(newContact)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Contact.self, inMemory: true)
}
