//
//  ContentView.swift
//  fetchrequest-bug
//
//  Created by Benjamin Kindle on 9/20/25.
//

import CoreData
import SwiftUI

/// 1. Launching the app for the first time, then creating an item, then pressing the 'add' button __works as expected__.
/// 2. re-launching (build in xcode or kill and re-launch) the app,, and pressing the "add" button on any item works only once, then __does not show changes__.
/// 3. If you add a new item, things __work as expected again__: New item is shown, all changes already made are shown, and any further changes with 'add' work.
/// The behavior is the same on a real iPhone 16 with iOS 26, iPhone 16 simulator with iOS 26, and an iPhone 16 simulator with iOS 18

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
    sortDescriptors: [
      NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)
    ],
    animation: .default
  )
  private var items: FetchedResults<Item>

  var body: some View {
    NavigationView {
      List {
        ForEach(items) { item in
          NavigationLink {
            VStack {
              Text("Item \(item.name ?? "unnamed") at \(item.timestamp!, formatter: itemFormatter)")
              Button("Add '?'") {
                item.name = (item.name ?? "") + "?"
                try? PersistenceController.shared.container.viewContext.save()
              }
            }
          } label: {
            Text(item.name ?? "unnamed")
            Text(item.timestamp!, formatter: itemFormatter)
          }
        }
        .onDelete(perform: deleteItems)
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
        ToolbarItem {
          Button(action: addItem) {
            Label("Add Item", systemImage: "plus")
          }
        }
      }
      Text("Select an item")
    }
  }

  private func addItem() {
    withAnimation {
      let newItem = Item(context: viewContext)
      newItem.timestamp = Date()
      newItem.name = "Test Name"

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

private let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

#Preview {
  ContentView().environment(
    \.managedObjectContext,
    PersistenceController.preview.container.viewContext
  )
}
