//
//  StoryView.swift
//  ColorStory
//
//  Created by 고재현 on 5/15/25.
//

import SwiftUI

struct StoryView: View {
    let slide: ColorSlide
    @EnvironmentObject var settings: SettingsViewModel
    var isLast: Bool = false
    var onBackToBeginning: (() -> Void)? = nil
    var isFirst: Bool = false
    var onStart: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            ColorGradientView(colorName: slide.colorName)
                .ignoresSafeArea()
            
            if isFirst, let onStart = onStart {
                VStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 120)
                        .padding(.bottom, 24)
                    Text(settings.selectedLanguage == "ko" ? "Colorstory: 색으로 전하는 복음" : "Colorstory: Gospel in Color")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.bottom, 32)
                    Button(action: {
                        onStart()
                    }) {
                        Text(settings.selectedLanguage == "ko" ? "시작하기" : "Start")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 18)
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(16)
                    }
                    Spacer()
                }
            } else if isLast, let onBackToBeginning = onBackToBeginning {
                VStack {
                    Spacer()
                    Button(action: {
                        onBackToBeginning()
                    }) {
                        Text(settings.selectedLanguage == "ko" ? "처음으로" : "Back to the Beginning")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 18)
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(16)
                    }
                    Spacer()
                }
            } else if settings.showText {
                Text(slide.localizedDescription(language: settings.selectedLanguage))
                    .font(.system(size: 26, weight: .bold))
                    .padding()
                    .foregroundColor((slide.colorName == "검정색" || slide.colorName == "초록색") ? .white : .black)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    StoryView(slide: colorSlides[0], isFirst: true, onStart: {})
        .environmentObject(SettingsViewModel())
}
