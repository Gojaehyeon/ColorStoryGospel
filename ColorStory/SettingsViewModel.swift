import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var showText: Bool = true
    @Published var playMusic: Bool = false {
        didSet {
            if playMusic {
                audioManager.togglePlayback()
            } else {
                audioManager.stop()
            }
        }
    }
    @Published var selectedLanguage: String = Locale.current.language.languageCode?.identifier ?? "ko" // "ko" 또는 "en"
    
    let audioManager = AudioManager()
    
    deinit {
        audioManager.stop()
    }
} 