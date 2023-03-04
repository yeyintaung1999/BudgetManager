
import SwiftUI

@available(OSX 10.15, *)
public struct PieChartView: View {
    public let values: [Double]
    public let names: [String]
    public let formatter: (Double) -> String
    public let categories: [CategoryEntity]
    
    public var colors: [Color]
    public var backgroundColor: Color
    
    public var widthFraction: CGFloat
    public var innerRadiusFraction: CGFloat
    
    @State private var activeIndex: Int = -1
    
    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: String(format: "%.0f%%", value * 100 / sum), color: self.colors[i]))
            endDeg += degrees
        }
        return tempSlices
    }
    
    public init(values:[Double], names: [String], formatter: @escaping (Double) -> String, colors: [Color] = [Color.blue, Color.green, Color.orange], backgroundColor: Color = Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), widthFraction: CGFloat = 0.75, innerRadiusFraction: CGFloat = 0.60, categories: [CategoryEntity]){
        self.values = values
        self.names = names
        self.formatter = formatter
        
        self.colors = getColorArray(categories: categories)//getColorArray(count: values.count)
        self.backgroundColor = Color(uiColor: UIColor(named: "whiteDL")!)
        self.widthFraction = widthFraction
        self.innerRadiusFraction = innerRadiusFraction
        self.categories = categories
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack{
                ZStack{
                  
                    ForEach(0..<self.values.count){ i in
                        
                        PieSlice(pieSliceData: self.slices[i])
                            .scaleEffect(self.activeIndex == i ? 1.03 : 1)
                            .animation(Animation.spring())
                        
                        
                    }
                    .frame(width: widthFraction * geometry.size.width, height: widthFraction * geometry.size.width)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let radius = 0.5 * widthFraction * geometry.size.width
                                let diff = CGPoint(x: value.location.x - radius, y: radius - value.location.y)
                                let dist = pow(pow(diff.x, 2.0) + pow(diff.y, 2.0), 0.5)
                                if (dist > radius || dist < radius * innerRadiusFraction) {
                                    self.activeIndex = -1
                                    return
                                }
                                var radians = Double(atan2(diff.x, diff.y))
                                if (radians < 0) {
                                    radians = 2 * Double.pi + radians
                                }
                                
                                for (i, slice) in slices.enumerated() {
                                    if (radians < slice.endAngle.radians) {
                                        self.activeIndex = i
                                        break
                                    }
                                }
                            }
                            .onEnded { value in
                                self.activeIndex = -1
                            }
                    )
                    Circle()
                        .fill(self.backgroundColor)
                        .frame(width: widthFraction * geometry.size.width * innerRadiusFraction, height: widthFraction * geometry.size.width * innerRadiusFraction)
                    
                    VStack {
                        Text(self.activeIndex == -1 ? "Total" : names[self.activeIndex])
                            .font(.system(size: 14, weight: .medium, design: .serif))
                            .foregroundColor(Color.gray)
                        Text(self.formatter(self.activeIndex == -1 ? values.reduce(0, +) : values[self.activeIndex]))
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundColor(Color(uiColor: UIColor(named: "ThemeColor")!))
                    }
                    
                }
                PieChartRows(colors: self.colors, names: self.names, values: self.values.map { self.formatter($0) }, percents: self.values.map { String(format: "%.0f%%", $0 * 100 / self.values.reduce(0, +)) })
            }
            .background(self.backgroundColor)
            .foregroundColor(Color.white)
        }
    }
}

@available(OSX 10.15, *)
struct PieChartRows: View {
    
    
    var colors: [Color]
    var names: [String]
    var values: [String]
    var percents: [String]
    
    var body: some View {
        VStack{
        
            ForEach(0..<self.values.count){ i in
                HStack {
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(self.colors[i])
                        .frame(width: 20, height: 20)
                    Text(self.names[i])
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                        .foregroundColor(Color(uiColor: UIColor(named: "ThemeColor")!))
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(self.values[i])
                            .foregroundColor(Color(uiColor: UIColor(named: "ThemeColor")!))
                            .font(.system(size: 14, weight: .medium, design: .monospaced))
                        Text(self.percents[i])
                            .font(.system(size: 12, weight: .medium, design: .monospaced))
                            .foregroundColor(Color.gray)
                    }
                }
            }
        }.padding([.leading, .trailing], 10)
    }
}

@available(OSX 10.15.0, *)
struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(values: [1300, 500, 300], names: ["Rent", "Transport", "Education"], formatter: {value in String(format: "$%.2f", value)}, categories: [CategoryEntity]())
    }
}

func getColorArray(count: Int)->[Color]{
    var colors: [Color] = []
//    var i = 0
//    while i < count {
//        colors.append(Color(red: .random(in: 0.2...1.0), green: .random(in: 0.2...1.0), blue: .random(in: 0.2...1.0)))
//        i += 1
//    }
    
    
    return colors
}

func getColorArray(categories: [CategoryEntity])->[Color]{
    var colors: [Color] = []
    categories.forEach { entity in
        
        
        let red: String = (entity.color?.components(separatedBy: "-")[0])!
        let green: String = (entity.color?.components(separatedBy: "-")[1])!
        let blue: String = (entity.color?.components(separatedBy: "-")[2])!
        colors.append(Color(red: Double(red) ?? 0.2, green: Double(green) ?? 0.2, blue: Double(blue) ?? 0.2))
    }
    
    
    return colors
}

