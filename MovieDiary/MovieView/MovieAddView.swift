//
//  MovieAddView.swift
//  MovieDiary
//
//  Created by David Goggins on 2023/05/27.
//

import SwiftUI

struct MovieAddView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var showTextEditor = ""
    @State var textArray: [String] = []
    
    var body: some View {
        VStack {
            Text("MovieAddView")
            Image("가디언즈")
                .resizable()
                .foregroundColor(.accentColor)
                .frame(width: 420*0.3, height: 694*0.3)
            VStack(alignment: .leading) {
                HStack {
                    Text("Title:")
                        .font(.title3)
                        .foregroundColor(.gray)
                    TextEditor(text: $showTextEditor)
                        .font(.title3)
                }
                Button(action: {
                    saveButton()
                }, label: {
                    Text("SAVE")
                })
                HStack() {
                    Text("Date:")
                        .font(.title3)
                        .foregroundColor(.gray)
                    Text("2023.05.27")
                        .font(.title3)
                }
                HStack() {
                    Text("Where:")
                        .font(.title3)
                        .foregroundColor(.gray)
                    Text("CGV 포항")
                        .font(.title3)
                }
                HStack() {
                    Text("With Whom")
                        .font(.title3)
                        .foregroundColor(.gray)
                    Text("환, 가락, 동영이")
                        .font(.title3)
                }
                HStack() {
                    Text("Review")
                        .font(.title3)
                        .foregroundColor(.gray)
                    Text("이 영화의 내용은 정말 재미가 있네요 도대체누가 만든거죠 정말 너무 재미있어서 너무 신아요 너무 힘들어요 다이어티 다이어트 힘들어요")
                        .font(.title3)
                }
            }
        }
    }
    func saveButton() {
        textArray.append(showTextEditor)
        //        showTextEditor = ""
        print(textArray)
        dismiss()
    }
}



struct MovieAddView_Previews: PreviewProvider {
    static var previews: some View {
        MovieAddView()
    }
}
