//
//  MainView.swift
//  ColorStory
//
//  Created by 고재현 on 5/15/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var settings = SettingsViewModel()
    @State private var showSettings = false
    
    var body: some View {
        ZStack {
            TabView {
                ForEach(colorSlides) { slide in
                    StoryView(slide: slide)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .environmentObject(settings)
    }
}

#Preview {
    MainView()
}
