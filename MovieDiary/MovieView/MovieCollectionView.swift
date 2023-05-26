//
//  MovieCollectionView.swift
//  MovieDiary
//
//  Created by David Goggins on 2023/05/27.
//

import SwiftUI

struct MovieCollectionView: View {
    
    @Binding var MovieTitleName: String
    
    var body: some View {
        VStack {
            Text("MovieCollectionView")
            Image("가디언즈")
                .resizable()
                .foregroundColor(.accentColor)
                .frame(width: 420*0.3, height: 694*0.3)
            VStack(alignment: .leading) {
                HStack {
                    Text(MovieTitleName)
                        .font(.title3)
                        .foregroundColor(.red)
                }
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
}

struct MovieCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCollectionView(MovieTitleName: .constant("sample"))
    }
}
