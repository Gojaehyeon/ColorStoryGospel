import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("표시 설정")) {
                        Toggle("텍스트 표시", isOn: $settings.showText)
                        Toggle("음악 재생", isOn: $settings.playMusic)
                    }
                    Section(header: Text("언어 설정")) {
                        Picker("언어", selection: $settings.selectedLanguage) {
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
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("닫기") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
} 
