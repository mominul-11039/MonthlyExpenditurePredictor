//
//  HomeBackGroundView.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 21/7/23.
//

import SwiftUI

struct HomeBackGroundView: View {
    @ObservedObject var vm = CurrentMonthExpenditureViewModel()
    var data: [Double] = [1000, 1500, 2000, 1200, 1500, 1000, 1100, 1200, 1500, 2000, 3000, 1000, 1500, 2000, 1200, 1500, 1000, 1100, 1200, 1500, 2000, 1000, 1500, 2000, 1200, 1500, 1000, 1100, 1200, 1500, 2000]

    var body: some View {
        ZStack (alignment: .bottom) {
            ZStack(alignment: .top) {
                WaveShape()
                    .fill(Color.white)
                    .ignoresSafeArea()
                    .shadow(color: Color.black.opacity(0.2),radius: 5, x: -5, y: -5)
                if vm.isShowGraph {
                    GraphView(data: vm.graphData)
                        .frame(width: 300, height: 190)
                        .background(Color("SecondaryBackgroundColor"))
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 10, y: 10)
                } else {
                    ProgressView()
                        .frame(width: 300, height: 190)
                        .background(Color("SecondaryBackgroundColor"))
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 10, y: 10)
                }
            }
            listContainerView()
                .fill(Color("SecondaryBackgroundColor"))
                .shadow(color: Color.black.opacity(0.2),radius: 5, x: -5, y: -5)
                .ignoresSafeArea()
                .overlay(alignment: .bottom) {
                    if vm.isShowList {
                        CurrentMonthExpenseView(dailyExpense: vm.dailyExpense)
                    } else {
                        ProgressView()
                        .frame(width: 300, height: UIScreen.screenHeight - 400)
                        .background(Color.clear)
                    }
                }
        }
    }
}

struct HomeBackGroundView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBackGroundView()
    }
}

struct WaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX + 10, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + 10, y: rect.maxY * 0.4))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX * 0.1, y: rect.maxY * 0.35),
                control: CGPoint(x: rect.minX + 12, y: rect.maxY * 0.35))
            path.addLine(to: CGPoint(x: rect.maxX * 0.9, y: rect.maxY * 0.35))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.maxY * 0.3),
                control: CGPoint(x: rect.maxX * 1, y: rect.maxY * 0.35))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + 10, y: rect.maxY))
        }
    }
}

struct listContainerView: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX + 30, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + 30, y: rect.maxY * 0.45))
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + 50, y: rect.maxY * 0.4),
                control: CGPoint(x: rect.minX + 28, y: rect.maxY * 0.4))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.4))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + 30, y: rect.maxY))
        }
    }
}
