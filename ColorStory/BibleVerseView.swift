import SwiftUI

struct BibleVerseView: View {
    let slide: ColorSlide
    @EnvironmentObject var settings: SettingsViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(slide.localizedDescription(language: settings.selectedLanguage))
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.top)
                    
                    Divider()
                    
                    let verses = settings.selectedLanguage == "ko" ? slide.bibleVerses : slide.bibleVersesEn
                    let refs = settings.selectedLanguage == "ko" ? slide.bibleReferences : slide.bibleReferencesEn
                    ForEach(0..<verses.count, id: \.self) { i in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(verses[i])
                                .font(.body)
                                .padding(.horizontal)
                            if i < refs.count {
                                Text("📖 " + refs[i])
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                            }
                        }
                        if i < verses.count - 1 {
                            Divider()
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(settings.selectedLanguage == "ko" ? "성경 구절" : "Bible Verse")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(settings.selectedLanguage == "ko" ? "닫기" : "Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    BibleVerseView(slide: colorSlides[0])
        .environmentObject(SettingsViewModel())
} 