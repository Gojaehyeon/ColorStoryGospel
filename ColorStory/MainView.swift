//
//  MainView.swift
//  ColorStory
//
//  Created by 고재현 on 5/15/25.
//

import SwiftUI

enum GospelFlowState {
    case start
    case countdown
    case slides
    case complete
}

struct MainView: View {
    @StateObject private var settings = SettingsViewModel()
    @State private var showBibleVerse = false
    @State private var colorStoryIndex = 0
    
    var body: some View {
        TabView {
            ColorStoryTabView()
                .tabItem {
                    Image(systemName: "book.closed.fill")
                    Text(settings.selectedLanguage == "ko" ? "복음" : "Gospel")
                }
            PrayerView()
                .tabItem {
                    Image(systemName: "hands.sparkles.fill")
                    Text(settings.selectedLanguage == "ko" ? "기도제목" : "Prayer")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text(settings.selectedLanguage == "ko" ? "설정" : "Settings")
                }
        }
        .environmentObject(settings)
    }
}

struct ColorStoryTabView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @State private var gospelState: GospelFlowState = .start
    @State private var showSlidesCover: Bool = false
    @State private var showCompleteCover: Bool = false
    
    var body: some View {
        ZStack {
            switch gospelState {
            case .start:
                StartGospelView(onStart: { gospelState = .countdown })
            case .countdown:
                CountdownCoverView(language: settings.selectedLanguage) {
                    gospelState = .slides
                    showSlidesCover = true
                }
            case .slides:
                EmptyView() // 실제 슬라이드는 fullScreenCover로 띄움
            case .complete:
                EmptyView() // 실제 완료는 fullScreenCover로 띄움
            }
        }
        .fullScreenCover(isPresented: $showSlidesCover, onDismiss: {
            gospelState = .complete
            showCompleteCover = true
        }) {
            GospelSlidesCover(onDone: {
                showSlidesCover = false
            })
            .environmentObject(settings)
        }
        .fullScreenCover(isPresented: $showCompleteCover, onDismiss: {
            gospelState = .start
        }) {
            GospelCompleteModal(onDone: {
                showCompleteCover = false
            })
            .environmentObject(settings)
        }
    }
}

struct StartGospelView: View {
    @EnvironmentObject var settings: SettingsViewModel
    private let completedKey = "gospel_completed_count"
    private let recentKey = "gospel_recent_date"
    @State private var completedCount: Int = 0
    @State private var recentDate: Date? = nil
    let onStart: () -> Void
    
    var body: some View {
        ZStack {
            ColorGradientView(colorName: "다크그레이")
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .padding(.bottom, 24)
                Text(settings.selectedLanguage == "ko" ? "Colorstory: 색으로 전하는 복음" : "Colorstory: Gospel in Color")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.bottom, 24)
                // 정보 카드 HStack
                HStack(spacing: 16) {
                    VStack(spacing: 4) {
                        Text(settings.selectedLanguage == "ko" ? "복음 전파" : "Completed")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        HStack(spacing: 2) {
                            Text("\(completedCount)")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.0, green: 0.7, blue: 0.7))
                            Text(settings.selectedLanguage == "ko" ? "회" : "times")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .fixedSize()
                                .lineLimit(1)
                        }
                        .fixedSize()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                    VStack(spacing: 4) {
                        Text(settings.selectedLanguage == "ko" ? "최근" : "Recent")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(recentDateText())
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.green)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
                Spacer()
                // Start 버튼
                HStack {
                    Button(action: {
                        incrementCompleted()
                        onStart()
                    }) {
                        Text(settings.selectedLanguage == "ko" ? "복음 시작" : "Start Gospel")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color(red: 0.4, green: 0.8, blue: 1.0))
                            .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
            .onAppear {
                completedCount = UserDefaults.standard.integer(forKey: completedKey)
                if let date = UserDefaults.standard.object(forKey: recentKey) as? Date {
                    recentDate = date
                }
            }
        }
    }
    
    func incrementCompleted() {
        completedCount += 1
        recentDate = Date()
        UserDefaults.standard.set(completedCount, forKey: completedKey)
        UserDefaults.standard.set(recentDate, forKey: recentKey)
    }
    
    func recentDateText() -> String {
        guard let date = recentDate else {
            return settings.selectedLanguage == "ko" ? "없음" : "None"
        }
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return settings.selectedLanguage == "ko" ? "오늘" : "Today"
        }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: settings.selectedLanguage == "ko" ? "ko_KR" : "en_US")
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

struct GospelCompleteModal: View {
    @EnvironmentObject var settings: SettingsViewModel
    let onDone: () -> Void
    
    private let completedKey = "gospel_completed_count"
    
    var completedCount: Int {
        UserDefaults.standard.integer(forKey: completedKey)
    }
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .fill(Color(red: 0.4, green: 0.8, blue: 1.0).opacity(0.15))
                    .frame(width: 120, height: 120)
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color(red: 0.0, green: 0.7, blue: 0.7))
            }
            .padding(.bottom, 32)
            Text(settings.selectedLanguage == "ko" ? "복음 전파 완료!" : "Gospel Complete!")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 8)
            Text(settings.selectedLanguage == "ko" ? "복음을 성공적으로 전파하셨습니다." : "You have successfully shared the Gospel.")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.bottom, 32)
            HStack {
                VStack(spacing: 8) {
                    Text(settings.selectedLanguage == "ko" ? "총 전파 횟수" : "Total Completed")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack(spacing: 2) {
                        Text("\(completedCount)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.0, green: 0.7, blue: 0.7))
                        Text(settings.selectedLanguage == "ko" ? "회" : "times")
                            .font(.body)
                            .foregroundColor(.gray)
                            .fixedSize()
                            .lineLimit(1)
                    }
                    .fixedSize()
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(Color(.systemGray6))
                .cornerRadius(18)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 40)
            Spacer()
            Button(action: onDone) {
                Text(settings.selectedLanguage == "ko" ? "완료" : "Done")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(Color(red: 0.4, green: 0.8, blue: 1.0))
                    .cornerRadius(16)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background(Color(.systemBackground).ignoresSafeArea())
    }
}

#Preview {
    MainView()
}
