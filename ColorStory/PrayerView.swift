import SwiftUI

struct PrayerItem: Identifiable, Hashable, Codable {
    let id: UUID
    let text: String
    let date: Date
    
    init(id: UUID = UUID(), text: String, date: Date) {
        self.id = id
        self.text = text
        self.date = date
    }
}

struct PrayerView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @State private var prayers: [PrayerItem] = []
    @State private var newPrayer: String = ""
    @State private var showDeleteAlert: Bool = false
    @State private var prayerToDelete: PrayerItem? = nil
    
    let storageKey = "prayer_items"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(prayers) { prayer in
                                HStack {
                                    Spacer()
                                    VStack(alignment: .trailing, spacing: 4) {
                                        Text(prayer.text)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 18)
                                            .background(Color(red: 0.4, green: 0.8, blue: 1.0))
                                            .foregroundColor(.white)
                                            .font(.body)
                                            .cornerRadius(22)
                                            .onLongPressGesture {
                                                prayerToDelete = prayer
                                                showDeleteAlert = true
                                            }
                                        Text(dateString(prayer.date))
                                            .font(.caption2)
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 6)
                                    }
                                }
                                .id(prayer.id)
                            }
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 8)
                    }
                    .onChange(of: prayers.count) { _ in
                        if let last = prayers.last {
                            withAnimation {
                                scrollProxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                    }
                }
                Divider()
                HStack {
                    TextField(settings.selectedLanguage == "ko" ? "기도제목을 입력하세요" : "Enter your prayer request", text: $newPrayer)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                    Button(action: addPrayer) {
                        Image(systemName: "arrow.up")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .padding(10)
                            .background(Color(red: 0.4, green: 0.8, blue: 1.0))
                            .clipShape(Circle())
                    }
                    .disabled(newPrayer.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(.systemBackground))
            }
            .navigationTitle(settings.selectedLanguage == "ko" ? "기도제목" : "Prayer Request")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: loadPrayers)
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text(settings.selectedLanguage == "ko" ? "삭제" : "Delete"),
                    message: Text(settings.selectedLanguage == "ko" ? "이 기도제목을 삭제할까요?" : "Delete this prayer request?"),
                    primaryButton: .destructive(Text(settings.selectedLanguage == "ko" ? "삭제" : "Delete")) {
                        if let prayer = prayerToDelete {
                            deletePrayer(prayer)
                        }
                    },
                    secondaryButton: .cancel(Text(settings.selectedLanguage == "ko" ? "취소" : "Cancel"))
                )
            }
        }
    }
    
    func addPrayer() {
        let trimmed = newPrayer.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        prayers.append(PrayerItem(text: trimmed, date: Date()))
        newPrayer = ""
        savePrayers()
    }
    
    func savePrayers() {
        if let data = try? JSONEncoder().encode(prayers) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    func loadPrayers() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let saved = try? JSONDecoder().decode([PrayerItem].self, from: data) {
            prayers = saved
        }
    }
    
    func deletePrayer(_ prayer: PrayerItem) {
        prayers.removeAll { $0.id == prayer.id }
        savePrayers()
    }
    
    func dateString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: settings.selectedLanguage == "ko" ? "ko_KR" : "en_US")
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    PrayerView().environmentObject(SettingsViewModel())
} 