import Foundation
import AVFoundation

class AudioManager: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    @Published var isPlaying: Bool = false
    
    init() {
        setupAudio()
    }
    
    private func setupAudio() {
        guard let url = Bundle.main.url(forResource: "music", withExtension: "mp3") else {
            print("음악 파일을 찾을 수 없습니다.")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // 무한 반복
            audioPlayer?.prepareToPlay()
        } catch {
            print("오디오 플레이어 초기화 실패: \(error.localizedDescription)")
        }
    }
    
    func togglePlayback() {
        if isPlaying {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
        isPlaying.toggle()
    }
    
    func stop() {
        audioPlayer?.stop()
        isPlaying = false
    }
} 