//
//  MovieStoryMemo.swift
//  MovieDiary
//
//  Created by David Goggins on 2023/05/28.
//

import SwiftUI

// 1. 모델 생성
struct MovieStoryMemo: Identifiable {
    let id = UUID()
    var title: String
    var content: String
}

// 2. 리스트 뷰 생성
struct MovieStoryMemoView: View {
    @State private var movieStoryMemos: [MovieStoryMemo] = []
    @State private var movieStoryMemo: MovieStoryMemo = MovieStoryMemo(title: "", content: "")
    
    var body: some View {
        NavigationView {
            List {
                ForEach($movieStoryMemos) { $memo in // 여기서는 $를 붙여주는 것이 핵심
                    NavigationLink(destination: MovieMemoDetailView(memo: $memo)) {
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
            .navigationTitle("MovieStory")
            .navigationBarItems(trailing:
                NavigationLink(destination: MovieMemoEditView(movieStoryMemos: $movieStoryMemos)) {
                    Image(systemName: "plus") // 클릭시 MovieMemoEditView로 이동해서 movieStoryMemos 배열을 전달하는 역할
                }
            ) //MovieMemoEditView로 이동할 때 movieStoryMemos 배열을 전달하는 역할을 합니다. $movieStoryMemos는 @State 속성 래퍼로 선언된 movieStoryMemos 배열을 바인딩합니다. 따라서 MovieMemoEditView에서 배열을 수정하면 해당 변경 사항이 MovieStoryMemoView에서도 반영됩니다.
        }
    }
}

// 3. 메모 클릭시, 상세 정보를 표시하는 뷰를 생성
struct MovieMemoDetailView: View {
    @Binding var memo: MovieStoryMemo
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            TextField("Title", text: self.$memo.title)
                .font(.headline)
                .padding(.vertical, 8)
            Divider()
            TextEditor(text: self.$memo.content)
                .font(.subheadline)
        }
        .padding()
    }
}

// 4. 추가/수정 뷰 생성
struct MovieMemoEditView: View {
    @Binding var movieStoryMemos: [MovieStoryMemo]
    @State var movieStoryMemo: MovieStoryMemo = MovieStoryMemo(title: "", content: "")
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("Titile", text: $movieStoryMemo.title)
                .font(.headline)
                .padding(.vertical, 8)
            Divider()
            TextEditor(text: $movieStoryMemo.content)
                .font(.subheadline)
        }
        .padding()
        .navigationBarTitle("New Movie Memo")
        .navigationBarItems(trailing: Button("Save") {
            movieStoryMemos.append(movieStoryMemo)
            presentationMode.wrappedValue.dismiss()
        }
        .disabled(movieStoryMemo.title.isEmpty || movieStoryMemo.content.isEmpty)
        //조건 중 하나라도 true이면, 즉 제목이나 내용 중 하나라도 비어있는 경우, .disabled(true)가 적용되어 버튼이 비활성화됩니다.
        )
    }
}



struct MovieStoryMemo_Previews: PreviewProvider {
    static var previews: some View {
        MovieStoryMemoView()
    }
}
