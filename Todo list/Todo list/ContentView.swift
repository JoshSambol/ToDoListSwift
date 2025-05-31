//
//  ContentView.swift
//  Todo list
//
//  Created by Joshua Sambol on 5/30/25.
//

import SwiftUI
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
struct Item: Identifiable {
    let id = UUID()
    var item: String
    var done: Bool
}
struct ContentView: View {
    @State private var itemList:[Item] = []
    @State private var newItemName: String = ""
    @State private var showNew = false
    var body: some View {
        VStack {
            ZStack {
                HStack{
                    EditButton()
                    Spacer()
                }
                
                Text("To Do List")
                    .bold()
                    .font(.title)
                
                HStack {
                    Spacer()
                    Button(showNew ? "Cancel" : "New") {
                        showNew.toggle()
                        if !showNew{
                            newItemName = ""
                        }
                    }
                }
                .padding()
            }
            if showNew {
                HStack{
                    TextField("Enter new item", text: $newItemName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    Button("Add") {
                        if !newItemName.isEmpty {
                            let newItem = Item(item: newItemName, done: false)
                            itemList.append(newItem)
                            newItemName = ""
                            showNew = false
                        }
                    }
                }
            }
            List{
                ForEach($itemList) { $item in
                    Toggle(isOn: $item.done){
                        Text(item.item)
                            .strikethrough(item.done)
                            .foregroundStyle(item.done ? Color.gray : .black)
                    }
                }
                .onDelete { indexSet in
                    itemList.remove(atOffsets:indexSet)}
                .padding()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        
    }
}

#Preview {
    ContentView()
}
