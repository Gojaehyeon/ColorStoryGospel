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
    
    var body: some View {
        ZStack {
            ColorGradientView(colorName: slide.colorName)
                .ignoresSafeArea()
            
            if settings.showText {
                Text(slide.localizedDescription(language: settings.selectedLanguage))
                    .font(.system(size: 26, weight: .bold))
                    .padding()
                    .foregroundColor(slide.colorName == "검정색" ? .white : .black)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    StoryView(slide: colorSlides[0])
        .environmentObject(SettingsViewModel())
}
