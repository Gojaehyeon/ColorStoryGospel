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
    @State private var showBibleVerse = false
    @State private var currentSlideIndex = 0
    
    var isCoverPage: Bool {
        currentSlideIndex == 0 || currentSlideIndex == colorSlides.count - 1
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $currentSlideIndex) {
                ForEach(0..<colorSlides.count, id: \.self) { index in
                    let slide = colorSlides[index]
                    if index == 0 {
                        StoryView(slide: slide, isFirst: true, onStart: {
                            withAnimation {
                                currentSlideIndex = 1
                            }
                        })
                        .tag(index)
                    } else if index == colorSlides.count - 1 {
                        StoryView(slide: slide, isLast: true, onBackToBeginning: {
                            withAnimation {
                                currentSlideIndex = 0
                            }
                        })
                        .tag(index)
                    } else {
                        StoryView(slide: slide)
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: currentSlideIndex == 0 ? .never : .always))
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    if !isCoverPage {
                        Button(action: {
                            showBibleVerse = true
                        }) {
                            Image(systemName: "book.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .clipShape(Circle())
                        }
                        .padding(.leading, 20)
                        .padding(.bottom, 20)
                    }
                    
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
        .sheet(isPresented: $showBibleVerse) {
            BibleVerseView(slide: colorSlides[currentSlideIndex])
        }
        .environmentObject(settings)
    }
}

#Preview {
    MainView()
}
