//
//  ContentView.swift
//  MovieDiary
//
//  Created by David Goggins on 2023/05/27.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Image("가디언즈")
                .resizable()
                .foregroundColor(.accentColor)
                .frame(width: 420*0.4, height: 694*0.4)
            Text("guardians of the galaxy vol 3")
                .font(.title3)
                .foregroundColor(.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
