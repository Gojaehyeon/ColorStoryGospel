import SwiftUI

struct ColorSlideView: View {
    let slide: ColorSlide
    @EnvironmentObject var settings: SettingsViewModel

    var body: some View {
        Text(slide.localizedDescription(language: settings.selectedLanguage))
            .font(.title2)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .padding()
    }
} 