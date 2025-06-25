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
    var isLast: Bool = false
    var onBackToBeginning: (() -> Void)? = nil
    var isFirst: Bool = false
    var onStart: (() -> Void)? = nil
    // 풀스크린 슬라이드에서만 사용
    var showBibleButton: Bool = false
    var onShowBible: (() -> Void)? = nil
    var isGreen: Bool = false
    var onFinish: (() -> Void)? = nil
    
    // 복음 전파 횟수/최근 날짜 UserDefaults 키
    private let completedKey = "gospel_completed_count"
    private let recentKey = "gospel_recent_date"
    
    @State private var completedCount: Int = 0
    @State private var recentDate: Date? = nil
    @State private var showCountdownCover: Bool = false
    @State private var showSlidesCover: Bool = false
    
    var body: some View {
        ZStack {
            ColorGradientView(colorName: slide.colorName)
                .ignoresSafeArea()
            
            if isFirst, let onStart = onStart {
                VStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .padding(.bottom, 24)
                    Text(settings.selectedLanguage == "ko" ? "Colorstory: 색으로 전하는 복음" : "Colorstory: Gospel in Color")
                        .font(.title)
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
                            showCountdownCover = true
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
                    .padding(.bottom, 16)
                }
                .onAppear {
                    completedCount = UserDefaults.standard.integer(forKey: completedKey)
                    if let date = UserDefaults.standard.object(forKey: recentKey) as? Date {
                        recentDate = date
                    }
                }
                .fullScreenCover(isPresented: $showCountdownCover) {
                    CountdownCoverView(language: settings.selectedLanguage) {
                        showCountdownCover = false
                        showSlidesCover = true
                    }
                }
                .fullScreenCover(isPresented: $showSlidesCover) {
                    GospelSlidesCover(onDone: {
                        showSlidesCover = false
                        onStart()
                    })
                    .environmentObject(settings)
                }
            } else if isLast, let onBackToBeginning = onBackToBeginning {
                VStack {
                    Spacer()
                    Button(action: {
                        onBackToBeginning()
                    }) {
                        Text(settings.selectedLanguage == "ko" ? "처음으로" : "Back to the Beginning")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 18)
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(16)
                    }
                    Spacer()
                }
            } else if settings.showText {
                Text(slide.localizedDescription(language: settings.selectedLanguage))
                    .font(.system(size: 26, weight: .bold))
                    .padding()
                    .foregroundColor((slide.colorName == "검정색" || slide.colorName == "초록색") ? .white : .black)
                    .multilineTextAlignment(.center)
            }
            // 풀스크린 슬라이드에서만 버튼 표시
            if showBibleButton, let onShowBible = onShowBible {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: onShowBible) {
                            Image(systemName: "book.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
            if isGreen, let onFinish = onFinish {
                VStack {
                    Spacer()
                    Button(action: onFinish) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                            .padding(28)
                            .background(Color(red: 0.4, green: 0.8, blue: 1.0))
                            .clipShape(Circle())
                            .shadow(radius: 8)
                    }
                    .padding(.bottom, 32)
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

struct CountdownCoverView: View {
    let language: String
    let onFinish: () -> Void
    @State private var countdown: Int = 3
    @State private var timer: Timer? = nil
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            VStack {
                Spacer()
                Text(language == "ko" ? "준비하세요" : "Get Ready")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 32)
                ZStack {
                    Circle()
                        .fill(Color(red: 0.4, green: 0.8, blue: 1.0).opacity(0.15))
                        .frame(width: 180, height: 180)
                    Text("\(countdown)")
                        .font(.system(size: 64, weight: .bold))
                        .foregroundColor(Color(red: 0.0, green: 0.7, blue: 0.7))
                }
                .padding(.bottom, 32)
                Text(language == "ko" ? "복음이 온 세상에 퍼지길 기도합니다." : "I pray that the Gospel spreads to the whole world.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.top, 16)
                Spacer()
            }
        }
        .onAppear {
            countdown = 3
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
                if countdown > 1 {
                    countdown -= 1
                } else {
                    t.invalidate()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        onFinish()
                    }
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

struct GospelSlidesCover: View {
    @EnvironmentObject var settings: SettingsViewModel
    let onDone: () -> Void
    @State private var slideIndex: Int = 1 // 첫 슬라이드는 1부터 시작(표지 제외)
    @State private var showComplete: Bool = false
    @State private var showBibleVerse: Bool = false
    
    var gospelSlides: [ColorSlide] {
        colorSlides.filter { $0.colorName != "다크그레이" }
    }
    
    var greenIndex: Int? {
        gospelSlides.firstIndex(where: { $0.colorName == "초록색" })
    }
    
    var body: some View {
        ZStack {
            if showComplete {
                GospelCompleteModal(onDone: onDone)
                    .environmentObject(settings)
            } else {
                TabView(selection: $slideIndex) {
                    ForEach(1..<gospelSlides.count+1, id: \ .self) { idx in
                        let slide = gospelSlides[idx-1]
                        StoryView(
                            slide: slide,
                            showBibleButton: !isGreenSlide(idx: idx),
                            onShowBible: { showBibleVerse = true },
                            isGreen: isGreenSlide(idx: idx),
                            onFinish: {
                                withAnimation {
                                    showComplete = true
                                }
                            }
                        )
                        .tag(idx)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .ignoresSafeArea()
                .onChange(of: slideIndex) { newValue in
                    if newValue == gospelSlides.count + 1 {
                        withAnimation {
                            showComplete = true
                        }
                    }
                }
                .sheet(isPresented: $showBibleVerse) {
                    if slideIndex > 0 && slideIndex <= gospelSlides.count {
                        BibleVerseView(slide: gospelSlides[slideIndex-1])
                    }
                }
            }
        }
        .background(Color(.systemBackground).ignoresSafeArea())
    }
    
    func isGreenSlide(idx: Int) -> Bool {
        greenIndex.map { $0 + 1 == idx } ?? false
    }
}

#Preview {
    StoryView(slide: colorSlides[0], isFirst: true, onStart: {})
        .environmentObject(SettingsViewModel())
}
