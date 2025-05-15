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
    
    let audioManager = AudioManager()
    
    deinit {
        audioManager.stop()
    }
} 