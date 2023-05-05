//
//  ShoppingListIView.swift
//  Coredata-intro
//
//  Created by Kanyaton Somjit on 2023-04-26.
//

import SwiftUI

struct ShoppingListIView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        //        predicate: NSPredicate(format: "done == %d", false),
//        //        predicate: NSPredicate(format: "name BEGINSWITH %@", "G"),
//        animation: .default)
    
    @FetchRequest
    private var items: FetchedResults<Item>
    
    init(filter: String) {
        if filter == "" {
            _items = FetchRequest<Item>(
                sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)]
                )
        } else {
            _items = FetchRequest<Item>(
                sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
                predicate: NSPredicate(format: "name BEGINSWITH[c] %@", filter)
            )
        }
    }
    
    var body: some View {
        List {
            ForEach(items) { item in
                HStack{
                    if let name = item.name {
                        Text(name)
                    }
                    Spacer()
                    Button(action: {
                        
                    }){
                        Image(systemName: item.done ? "checkmark.square" : "square")
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
    
//    struct ShoppingListIView_Previews: PreviewProvider {
//        static var previews: some View {
//            ShoppingListIView()
//        }
//    }

