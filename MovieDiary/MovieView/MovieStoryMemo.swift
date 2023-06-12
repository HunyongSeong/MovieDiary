//
//  MovieStoryMemo.swift
//  MovieDiary
//
//  Created by David Goggins on 2023/05/28.
//

import SwiftUI

// 1. 모델 생성
struct MovieStoryMemo: Identifiable {
    let id = UUID() // 이 모든 코드에서 id의 쓰임은 어떠한가? 다 관련이 있는가?
    var title: String
    var content: String
}

// 2. 리스트 뷰 생성
struct MovieStoryMemoView: View {
    @State private var movieStoryMemos: [MovieStoryMemo] = []
//    @State private var movieStoryMemo: MovieStoryMemo = MovieStoryMemo(title: "", content: "") // <- 타입 이름, 타입 식별자
    
    var body: some View {
        NavigationView {
            List { // 아래 디테일뷰에서 내가 문자를 수정할 경우, 현재 ForEach문에서 바로 다시 그려주기 위해서
                ForEach($movieStoryMemos) { $memo in // 여기서는 $를 붙여주는 것이 핵심 <- ($) 이것이 있고 없고의 차이는?
                    // 결국은 $로 바인딩을 계속 받으면서 거슬러 올라가야 부모도 바뀔 수가 있다.
                    NavigationLink(destination: MovieMemoDetailView(memoDetail: $memo)) { // 각각의 메모를 클릭시, 해당 메모의 디테일 뷰로 이동
                        VStack(alignment: .leading) {
                            Text(memo.title) // 이건 그냥 화면에 memo를 보여주는 용도일 뿐. 그래서 $가 없음.
                                .font(.headline)
                            Text(memo.content)
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("MovieStory")
            .navigationBarItems(trailing:
                NavigationLink(destination: MovieMemoEditView(movieStoryMemos: $movieStoryMemos)) { // 위와 같은 이유로, 영화의 내용을 추가하게되면 메인화면에서 추가된 메모가 그려줘야하기 때문에 $로 @State private var movieStoryMemos를 바라보게 한다.
                    Image(systemName: "plus") // 클릭시 MovieMemoEditView로 이동해서 movieStoryMemos 배열을 전달하는 역할
                }
            ) //MovieMemoEditView로 이동할 때 movieStoryMemos 배열을 전달하는 역할을 합니다. $movieStoryMemos는 @State 속성 래퍼로 선언된 movieStoryMemos 배열을 바인딩합니다. 따라서 MovieMemoEditView에서 배열을 수정하면 해당 변경 사항이 MovieStoryMemoView에서도 반영됩니다.
        }
    }
}

// 3. 메모 클릭시, 상세 정보를 표시하는 뷰를 생성
struct MovieMemoDetailView: View {
    @Binding var memoDetail: MovieStoryMemo // 바인딩해서 가져온 이유는 -> 내용을 확인하기 위해서 -> memoDetail은 movieStoryMemos에서 우리가 선택한 하나의 movieStoryMemo
    @Environment(\.presentationMode) var presentationMode // Dismiss를 위해서 존재

    var body: some View {
        VStack{
            TextField("Title", text: self.$memoDetail.title) // 여기서의 self는 없어도 되지만, $memoDetail라는 변수가 현재 뷰 안에 있다는 것을 알려주기 위해서 사용
                .font(.headline)
                .padding(.vertical, 8)
            Divider()
            TextEditor(text: self.$memoDetail.content)
                .font(.subheadline)
            Spacer()
        }
        .padding()
        .navigationBarItems(trailing: Button("Save") {
            presentationMode.wrappedValue.dismiss()
        }
        .disabled(memoDetail.title.isEmpty || memoDetail.content.isEmpty)
        //조건 중 하나라도 true이면, 즉 제목이나 내용 중 하나라도 비어있는 경우, .disabled(true)가 적용되어 버튼이 비활성화됩니다.
        )
    }
}

// 4. 추가/수정 뷰 생성
struct MovieMemoEditView: View {
    @Binding var movieStoryMemos: [MovieStoryMemo]
    @State var movieStoryMemo: MovieStoryMemo = MovieStoryMemo(title: "", content: "")
//    @Binding var movieStoryMemo: MovieStoryMemo

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
            movieStoryMemos.append(movieStoryMemo) // 배열에 집어 넣어주고
            print("저장 되었습니다.")
            presentationMode.wrappedValue.dismiss() // dismiss
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

