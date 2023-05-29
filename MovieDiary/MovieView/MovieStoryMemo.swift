//
//  MovieStoryMemo.swift
//  MovieDiary
//
//  Created by David Goggins on 2023/05/28.
//

import SwiftUI

// 1. 모델 생성
struct MovieStoryMemo: Identifiable { //MovieStoryMemo 구조체는 Identifiable 프로토콜을 채택하고 있습니다
    let id = UUID()
    var title: String
    var content: String
}

// 2. 리스트 뷰 생성
struct MovieStoryMemoView: View {
    @State var movieStoryMemos: [MovieStoryMemo] = [] //movieStoryMemos 배열을 사용하여 영화 메모를 보여주는 리스트 뷰를 구성할 수 있습니다
    @State var movieStoryMemo: MovieStoryMemo = MovieStoryMemo(title: "", content: "")
    // 즉, 위의 코드는 MovieStoryMemo 구조체를 사용하여 영화 메모를 저장하고, movieStoryMemos 배열을 사용하여 영화 메모를 보여주는 리스트 뷰를 생성하는 SwiftUI 코드
    
    var body: some View {
        NavigationView {
            List { // List가 없다면, 화면에 그려지지 않을까? -> 그냥 포문으로만 그려진다. 하지만 리스트를 사용하면 리스트 안에 그려주게 됨.
                ForEach($movieStoryMemos) { $memo in //movieStoryMemos 각 배열의 요소 하나하나를 memo라 하겠다.
                    NavigationLink(destination: MovieMemoDetailView(memo: $memo)) { // 차례대로 클릭시 해당 디테일 뷰로 이동
                        VStack(alignment: .leading) {
                            Text(memo.title) // 각각 해당 디테일뷰의 제목을 보여줌
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
struct MovieMemoDetailView: View { //movieStoryMemo에는 2. 에서 movieStoryMemos 배열의 요소 하나하나가 들어가게 된다.
    @Binding var memo: MovieStoryMemo
//    @Binding var movieStoryMemos: [MovieStoryMemo]
    @Environment(\.presentationMode) var presentationMode // 현재 뷰의 표시 모드를 나타내는 환경 변수입니다. 이를 사용하여 뷰를 닫거나 이동하기 위해 필요한 기능을 수행할 수 있습니다.

    
    var body: some View {
        VStack{
            TextEditor(text: self.$memo.title) // 이렇게 요소 하나하나를 화면에 보여줌과 동시에, 추가적인 채팅으로 바꾸는 것 또한 가능.
                .font(.headline)
                .padding(.vertical, 8)
            Divider()
            TextEditor(text: self.$memo.content)
                .font(.subheadline)
        }
        .padding()
//        .navigationBarItems(trailing: Button("Save") {
//            // 현재 자리에 있는 것을 빼고 현재 자리에 추가해 줘야 함. -> 내 자리를 알아야 함.내 자리를 지우고, 내 자리에 추가해주기.
////            movieStoryMemos.removeLast() // 이 한줄이 추가 됨으로써 업데이트가 가능해짐. 추가 안될 시, 기존에 써놓았던 양식이 복사됨
//            presentationMode.wrappedValue.dismiss()
//        }
//            .disabled(self.memo.title.isEmpty || self.memo.content.isEmpty)
//        //조건 중 하나라도 true이면, 즉 제목이나 내용 중 하나라도 비어있는 경우, .disabled(true)가 적용되어 버튼이 비활성화됩니다.
//        )
    }
}

// 4. 추가/수정 뷰 생성
struct MovieMemoEditView: View {
    @Binding var movieStoryMemos: [MovieStoryMemo]
    @State var movieStoryMemo: MovieStoryMemo = MovieStoryMemo(title: "", content: "") // 메모장을 새로 만들 때, 해당 변수는 항상 값을 초기화하고 값이 넣어지고 savee되면서 movieStoryMemos배열에 값이 넣어지면서 끝이난다.
    @Environment(\.presentationMode) var presentationMode // 현재 뷰의 표시 모드를 나타내는 환경 변수입니다. 이를 사용하여 뷰를 닫거나 이동하기 위해 필요한 기능을 수행할 수 있습니다.
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
