import SwiftUI

struct SettingsView: View {
    var body: some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                SettingsContentView()
            } else {
                NavigationView {
                    SettingsContentView()
                }
            }
        }
    }
}

struct SettingsContentView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Form {
                Section(header: Text(settings.selectedLanguage == "ko" ? "표시 설정" : "Display Settings")) {
                    Toggle(settings.selectedLanguage == "ko" ? "텍스트 표시" : "Show Text", isOn: $settings.showText)
                    Toggle(settings.selectedLanguage == "ko" ? "음악 재생" : "Play Music", isOn: $settings.playMusic)
                }
                Section(header: Text(settings.selectedLanguage == "ko" ? "언어 설정" : "Language Settings")) {
                    Picker(settings.selectedLanguage == "ko" ? "언어" : "Language", selection: $settings.selectedLanguage) {
                        Text("한국어").tag("ko")
                        Text("English").tag("en")
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            
            VStack {
                Spacer()
                Text("Made by Gojaehyun, who loves Jesus")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
            }
        }
        .navigationTitle(settings.selectedLanguage == "ko" ? "설정" : "Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
} 
