import SwiftUI

struct FlowerView: View {
    var body: some View {
        ZStack {
            
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                
                ZStack {
                    ForEach(0..<8) { iteration in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.yellow, .red]),
                                    startPoint: UnitPoint(x: 0, y: 1),
                                    endPoint: UnitPoint(x: 1, y: 0)
                                )
                            )
                            .frame(width: width * 0.7, height: height * 0.7)
                            .rotationEffect(.degrees(Double(iteration) * 25))
                    }
                    
                    Path { path in
                        // Центр цветка
                        let center = CGPoint(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
                        
                        // Стебель
                        path.move(to: center)
                        path.addLine(to: CGPoint(x: center.x, y: center.y + 50))
                        
                        // Лепестки (треугольники)
                        for angle in stride(from: 0, to: 360, by: 45) {
                            let radianAngle = Angle(degrees: Double(angle)).radians
                            let x = center.x + 40 * cos(radianAngle)
                            let y = center.y + 40 * sin(radianAngle)
                            
                            let triangle = Triangle(center: center, vertex1: CGPoint(x: x, y: y), size: 20)
                            path.addPath(triangle.path)
                        }
                    }
                    .fill(Color.cyan) // Заливаем цветом
                }
                }
            
                
        }
    }
}

struct Triangle {
    let path: Path
    
    init(center: CGPoint, vertex1: CGPoint, size: CGFloat) {
        let vertex2 = CGPoint(x: center.x + size * cos(2 * .pi / 3), y: center.y + size * sin(2 * .pi / 3))
        let vertex3 = CGPoint(x: center.x + size * cos(4 * .pi / 3), y: center.y + size * sin(4 * .pi / 3))
        
        path = Path { p in
            p.move(to: vertex1)
            p.addLine(to: vertex2)
            p.addLine(to: vertex3)
            p.closeSubpath()
        }
    }
}

struct ContentView: View {
    var body: some View {
        FlowerView()
            .frame(width: 200, height: 200)
    }
}

struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
