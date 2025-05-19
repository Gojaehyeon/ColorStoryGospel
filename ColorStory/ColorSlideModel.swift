//
//  ColorSlideModel.swift
//  ColorStory
//
//  Created by 고재현 on 5/15/25.
//

import Foundation
import SwiftUI

struct ColorSlide: Identifiable {
    let id = UUID()
    let colorName: String
    let description: String
    let descriptionEn: String
    let imageName: String
    let bibleVerses: [String]
    let bibleVersesEn: [String]
    let bibleReferences: [String]
    let bibleReferencesEn: [String]
    
    func localizedDescription(language: String? = nil) -> String {
        let lang = language ?? (Locale.current.language.languageCode?.identifier ?? "ko")
        if lang == "ko" {
            return description
        } else {
            return descriptionEn
        }
    }
}

let colorSlides: [ColorSlide] = [
    ColorSlide(
        colorName: "다크그레이",
        description: "Colorstory: 색으로 전하는 복음",
        descriptionEn: "Colorstory: Gospel in Color",
        imageName: "skyblue",
        bibleVerses: [],
        bibleVersesEn: [],
        bibleReferences: [],
        bibleReferencesEn: []
    ),
    ColorSlide(
        colorName: "금색",
        description: "하나님께서 우리를 너무 사랑하셔서\n찬란한 천국을 준비하셨어요.",
        descriptionEn: "God loved us so much\nthat He prepared a glorious heaven for us.",
        imageName: "gold",
        bibleVerses: [
            "내 아버지 집에는 거할 곳이 많도다 내가 너희를 위하여 처소를 예비하러 가노니 - 요한복음 14:2",
            "오직 우리의 시민권은 하늘에 있는지라 거기로부터 구원하는 이 곧 주 예수 그리스도를 기다리노니 - 빌립보서 3:20",
            "하나님이 그들을 위하여 한 성을 예비하셨느니라 - 히브리서 11:16"
        ],
        bibleVersesEn: [
            "My Father's house has many rooms I am going there to prepare a place for you - John 14:2",
            "But our citizenship is in heaven, and from it we await a Savior, the Lord Jesus Christ - Philippians 3:20",
            "Therefore God is not ashamed to be called their God, for he has prepared for them a city - Hebrews 11:16"
        ],
        bibleReferences: [
            "요한복음 14:2",
            "빌립보서 3:20",
            "히브리서 11:16"
        ],
        bibleReferencesEn: [
            "John 14:2",
            "Philippians 3:20",
            "Hebrews 11:16"
        ]
    ),
    ColorSlide(
        colorName: "검정색",
        description: "하지만 우리 마음에 죄가 생겨서\n하나님과 멀어지고 말았죠.",
        descriptionEn: "But sin entered our hearts\nand we became separated from God.",
        imageName: "black",
        bibleVerses: [
            "모든 사람이 죄를 범하였으매 하나님의 영광에 이르지 못하더니",
            "그러므로 한 사람으로 말미암아 죄가 세상에 들어오고 죄로 말미암아 사망이 왔나니 이와 같이 모든 사람이 죄를 지었으므로 사망이 모든 사람에게 이르렀느니라",
            "죄의 삯은 사망이요 하나님의 은사는 그리스도 예수 우리 주 안에 있는 영생이니라"
        ],
        bibleVersesEn: [
            "For all have sinned and fall short of the glory of God",
            "Therefore just as sin came into the world through one man and death through sin and so death spread to all men because all sinned",
            "For the wages of sin is death but the free gift of God is eternal life in Christ Jesus our Lord"
        ],
        bibleReferences: [
            "로마서 3:23",
            "로마서 5:12",
            "로마서 6:23"
        ],
        bibleReferencesEn: [
            "Romans 3:23",
            "Romans 5:12",
            "Romans 6:23"
        ]
    ),
    ColorSlide(
        colorName: "빨간색",
        description: "그래서 예수님이 우리 죄를 위해\n피 흘리시고 죽으셨어요.",
        descriptionEn: "So Jesus shed His blood for our sins\nand died on the cross.",
        imageName: "red",
        bibleVerses: [
            "우리가 아직 죄인 되었을 때에 그리스도께서 우리를 위하여 죽으심으로 하나님께서 우리에 대한 자기의 사랑을 확증하셨느니라 - 로마서 5:8",
            "그가 찔림은 우리의 허물을 인함이요 - 이사야 53:5",
            "이는 죄 사함을 얻게 하려고 많은 사람을 위하여 흘리는 바 나의 피 곧 언약의 피니라 - 마태복음 26:28"
        ],
        bibleVersesEn: [
            "But God shows his love for us in that while we were still sinners, Christ died for us - Romans 5:8",
            "But he was pierced for our transgressions - Isaiah 53:5",
            "For this is my blood of the covenant, which is poured out for many for the forgiveness of sins - Matthew 26:28"
        ],
        bibleReferences: [
            "로마서 5:8",
            "이사야 53:5",
            "마태복음 26:28"
        ],
        bibleReferencesEn: [
            "Romans 5:8",
            "Isaiah 53:5",
            "Matthew 26:28"
        ]
    ),
    ColorSlide(
        colorName: "하얀색",
        description: "예수님의 죽음과 부활을 통해\n우리 마음이 깨끗해졌어요.",
        descriptionEn: "Through Jesus' death and resurrection\nour hearts are made clean.",
        imageName: "white",
        bibleVerses: [
            "너희 죄가 주홍 같을지라도 눈과 같이 희어질 것이요 - 이사야 1:18",
            "그가 우리 죄를 사하시며 우리를 모든 불의에서 깨끗하게 하실 것이요 - 요한일서 1:9",
            "내가 그들의 불의를 사하고 다시는 그 죄를 기억하지 아니하리라 - 히브리서 8:12"
        ],
        bibleVersesEn: [
            "Though your sins are like scarlet, they shall be as white as snow - Isaiah 1:18",
            "He is faithful and just to forgive us our sins and to cleanse us from all unrighteousness - 1 John 1:9",
            "For I will be merciful toward their iniquities, and I will remember their sins no more - Hebrews 8:12"
        ],
        bibleReferences: [
            "이사야 1:18",
            "요한일서 1:9",
            "히브리서 8:12"
        ],
        bibleReferencesEn: [
            "Isaiah 1:18",
            "1 John 1:9",
            "Hebrews 8:12"
        ]
    ),
    ColorSlide(
        colorName: "금색",
        description: "우리가 예수님을 믿음으로\n천국을 누리게 돼요!",
        descriptionEn: "By believing in Jesus\nwe can enjoy heaven!",
        imageName: "gold",
        bibleVerses: [
            "하나님이 세상을 이처럼 사랑하사 독생자를 주셨으니 그를 믿는 자마다 멸망하지 않고 영생을 얻게 하려 하심이라 - 요한복음 3:16",
            "내 양은 내 음성을 들으며 내가 그들에게 영생을 주노니 - 요한복음 10:27–28",
            "또 내가 본즉 새 하늘과 새 땅이 있더라 - 요한계시록 21:1"
        ],
        bibleVersesEn: [
            "For God so loved the world that he gave his only Son whoever believes in him should not perish but have eternal life - John 3:16",
            "My sheep hear my voice I give them eternal life, and they will never perish - John 10:27–28",
            "Then I saw a new heaven and a new earth - Revelation 21:1"
        ],
        bibleReferences: [
            "요한복음 3:16",
            "요한복음 10:27–28",
            "요한계시록 21:1"
        ],
        bibleReferencesEn: [
            "John 3:16",
            "John 10:27–28",
            "Revelation 21:1"
        ]
    ),
    ColorSlide(
        colorName: "초록색",
        description: "하나님의 자녀는 영적으로 하루하루 성장해요.\n예수님이 주신 새 생명 덕분이에요.",
        descriptionEn: "God's children grow\nand enjoy His gifts.",
        imageName: "green",
        bibleVerses: [
            "갓난 아기들 같이 순전하고 신령한 젖을 사모하라 이는 그로 말미암아 너희로 구원에 이르도록 자라게 하려 함이라 - 베드로전서 2:2",
            "그는 시냇가에 심은 나무가 철을 따라 열매를 맺으며 - 시편 1:3",
            "오직 사랑 안에서 참된 것을 하여 범사에 그에게까지 자랄지라 - 에베소서 4:15"
        ],
        bibleVersesEn: [
            "Like newborn infants, long for the pure spiritual milk, that by it you may grow up into salvation - 1 Peter 2:2",
            "He is like a tree planted by streams of water that yields its fruit in its season - Psalm 1:3",
            "Rather, speaking the truth in love, we are to grow up in every way into him who is the head, into Christ - Ephesians 4:15"
        ],
        bibleReferences: [
            "베드로전서 2:2",
            "시편 1:3",
            "에베소서 4:15"
        ],
        bibleReferencesEn: [
            "1 Peter 2:2",
            "Psalm 1:3",
            "Ephesians 4:15"
        ]
    ),
    ColorSlide(
        colorName: "다크그레이",
        description: "처음으로 돌아가기",
        descriptionEn: "Back to the Beginning",
        imageName: "skyblue",
        bibleVerses: [],
        bibleVersesEn: [],
        bibleReferences: [],
        bibleReferencesEn: []
    )
]
