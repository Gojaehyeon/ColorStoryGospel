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
