//
//  ApplicationContainerView.swift
//  ReactiveSwiftUIRouting
//
//  Created by Viktor Jenei on 2023. 12. 17..
//

import SwiftUI

struct ApplicationContainerView: View {
    var body: some View {
        TabView {
            let items = [
                Item(id: 1, name: "First", description: "This is the first item"),
                Item(id: 2, name: "Second", description: "This is the second item"),
                Item(id: 3, name: "Third", description: "This is the third item"),
                Item(id: 4, name: "Forth", description: "This is the forth item"),
            ]
            let viewModel = ListViewModel(items: items, selectedItem: items[1])
            ListView(viewModel: viewModel)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            ProfileView()
                .tabItem {
                    Label("Settings", systemImage: "person")
                }
        }
    }
}

struct ListView: View {
    @Bindable var viewModel: ListViewModel

    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            List(viewModel.items) { item in
                NavigationLink(item.name, value: item)
            }
            .navigationDestination(for: Item.self) { item in
                ItemView(item: item)
            }
            .navigationTitle("Items")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

@Observable class ListViewModel {
    var items: [Item]
    var navigationPath: NavigationPath

    init(items: [Item], selectedItem: Item? = nil) {
        self.items = items
        self.navigationPath = NavigationPath()
        if let selectedItem {
            self.navigationPath.append(selectedItem)
        }
    }
}

struct Item: Identifiable, Hashable, Equatable {
    let id: Int
    
    let name: String
    let description: String
}

struct ItemView: View {
    let item: Item

    var body: some View {
        VStack{
            Text("Some Item")
            Text(item.name)
            Text(item.description)
        }
        .navigationTitle(item.name)
        .onAppear {
            print("Item: \(item)")
        }
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Hello settings")
    }
}

#Preview {
    ApplicationContainerView()
}
