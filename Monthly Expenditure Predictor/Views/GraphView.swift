//
//  GraphView.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 21/7/23.
//

import SwiftUI

struct GraphView: View {
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0
    
    init(data: [Double]) {
        self.data = data
        maxY = data.max() ?? 0
        minY = 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = Color("PrimaryBackgroundColor")
        endingDate = Date()
        startingDate = endingDate.addingTimeInterval(-14*24*60*60)
    }
    
    var body: some View {
        VStack {
            chartView
                .frame(width: 280, height: 140)
                .background(chartBackground)
                .overlay(chartYAxis.padding(.horizontal, 8), alignment: .leading)
            
            chartDateLabels
                .padding(8)
        }
        .font(.caption)
        .foregroundColor(Color("PrimaryBackgroundColor"))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
        
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(data: [])
    }
}

extension GraphView {
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40)
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(Double(3 * ((maxY + minY) / 4)).formattedWithAbbreviations())
            Spacer()
            Text(Double(2 * ((maxY + minY) / 4)).formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 4).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabels: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
