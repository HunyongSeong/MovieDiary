//
//  Memotest.swift
//  MovieDiary
//
//  Created by David Goggins on 2023/05/29.
//

import SwiftUI

struct Memo: Identifiable {
    let id = UUID()
    var title: String
    var content: String
}

struct MemoListrView: View {
    @State var memos: [Memo] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(memos) { memo in
                    NavigationLink(destination: MemoDetailView(memo: memo)) {
                        VStack(alignment: .leading) {
                            Text(memo.title)
                                .font(.headline)
                            Text(memo.content)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Memo")
            .navigationBarItems(trailing:
                NavigationLink(destination: MemoEditView(memos: $memos)) {
                    Image(systemName: "plus")
                }
            )
        }
    }
}

struct MemoDetailView: View {
    @State var memo: Memo
    
    var body: some View {
        VStack {
            TextEditor(text: $memo.title)
                .font(.headline)
                .padding(.vertical, 8)
            Divider()
            TextEditor(text: $memo.content)
                .font(.subheadline)
        }
        .padding()
    }
}

struct MemoEditView: View {
    @Binding var memos: [Memo]
    @State var memo: Memo = Memo(title: "", content: "")
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("Title", text: $memo.title)
                .font(.headline)
                .padding(.vertical, 8)
            Divider()
            TextEditor(text: $memo.content)
                .font(.subheadline)
        }
        .padding()
        .navigationBarTitle("New Memo")
        .navigationBarItems(trailing:
                   Button("Save") {
            memos.append(memo)
            presentationMode.wrappedValue.dismiss()
        }
        .disabled(memo.title.isEmpty || memo.content.isEmpty)
        )
    }
}

