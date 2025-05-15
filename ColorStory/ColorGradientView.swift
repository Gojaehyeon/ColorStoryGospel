import SwiftUI

struct ColorGradientView: View {
    let colorName: String
    @State private var startPoint = UnitPoint(x: 0, y: 0)
    @State private var endPoint = UnitPoint(x: 1, y: 1)
    
    var gradientColors: [Color] {
        switch colorName {
        case "금색":
            return [
                Color(red: 1.0, green: 0.84, blue: 0.0),  // 밝은 금색
                Color(red: 1.0, green: 0.95, blue: 0.3),  // 더 밝은 금색
                Color(red: 1.0, green: 0.84, blue: 0.0),  // 밝은 금색
                Color(red: 1.0, green: 0.95, blue: 0.3),  // 더 밝은 금색
                Color(red: 1.0, green: 0.84, blue: 0.0)   // 밝은 금색
            ]
        case "검정색":
            return [Color.black, Color.black, Color.black]  // 단색 검정
        case "빨간색":
            return [Color(red: 0.8, green: 0.0, blue: 0.0),
                   Color(red: 1.0, green: 0.0, blue: 0.0),
                   Color(red: 0.8, green: 0.0, blue: 0.0)]
        case "하얀색":
            return [Color.white,
                   Color(red: 0.95, green: 0.95, blue: 0.95),
                   Color.white]
        default:
            return [Color.gray, Color.gray, Color.gray]
        }
    }
    
    var body: some View {
        LinearGradient(colors: gradientColors,
                      startPoint: startPoint,
                      endPoint: endPoint)
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: true)) {
                    startPoint = UnitPoint(x: 1, y: 0)
                    endPoint = UnitPoint(x: 0, y: 1)
                }
            }
    }
}

#Preview {
    ColorGradientView(colorName: "금색")
} 