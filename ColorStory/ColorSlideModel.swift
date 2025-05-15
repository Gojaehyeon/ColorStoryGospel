//
//  ColorSlideModel.swift
//  ColorStory
//
//  Created by 고재현 on 5/15/25.
//

import Foundation

struct ColorSlide: Identifiable {
    let id = UUID()
    let colorName: String          // 예: "금색"
    let description: String        // 텍스트 설명
    let imageName: String          // 배경 이미지 파일 이름 (예: "gold")
    let voiceFileName: String?     // 음성 파일 이름 (예: "gold.mp3")
}

let colorSlides: [ColorSlide] = [
    ColorSlide(
        colorName: "금색",
        description: "하나님께서 우리를 너무 사랑하셔서\n찬란한 천국을 준비하셨어요.",
        imageName: "gold",
        voiceFileName: "gold.mp3"
    ),
    ColorSlide(
        colorName: "검정색",
        description: "하지만 우리 마음에 죄가 생겨서\n하나님과 멀어지고 말았죠.",
        imageName: "black",
        voiceFileName: "black.mp3"
    ),
    ColorSlide(
        colorName: "빨간색",
        description: "그래서 예수님이 우리 죄를 위해\n피 흘리시고 죽으셨어요.",
        imageName: "red",
        voiceFileName: "red.mp3"
    ),
    ColorSlide(
        colorName: "하얀색",
        description: "예수님의 죽음과 부활을 통해\n우리 마음이 깨끗해졌어요.",
        imageName: "white",
        voiceFileName: "white.mp3"
    ),
    ColorSlide(
        colorName: "금색",
        description: "우리가 예수님을 믿음으로\n천국을 누리게 돼요!",
        imageName: "gold",
        voiceFileName: "gold2.mp3"
    )
]
