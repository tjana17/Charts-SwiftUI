//
//  ContentView.swift
//  Charts-SwiftUI
//
//  Created by Janarthanan Kannan on 09/04/24.
//

import SwiftUI
import Charts

enum Charts: String {
    case bar = "Bar"
    case line = "Line"
    case pie = "Pie"
}

struct ContentView: View {
    
    @State private var chartData: [DataModel] = dataList
    @State private var isAnimated: Bool = false
    @State private var currentChart = "Bar"
    
    var chartType = [Charts.bar.rawValue, Charts.line.rawValue, Charts.pie.rawValue]
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Picker("Choose the chart", selection: $currentChart) {
                        ForEach(chartType, id: \.self) { datum in
                            Text(datum)
                        }
                    }
                    .pickerStyle(.segmented)
                    ///Bar Chart
                    if currentChart == Charts.bar.rawValue {
                        Chart {
                            ForEach(chartData) { datum in
                                BarMark(x: .value("Month", datum.month),
                                        y: .value("Data List", datum.isAnimated ? datum.value : 0))
                                    .foregroundStyle(.blue.gradient)
                                    .opacity(datum.isAnimated ? 1 : 0)
                            }
                        }
                        .chartYScale(domain: 0...12000)
                        .frame(height: 300)
                        .padding()
                        .background(.background, in: .rect(cornerRadius: 10))
                        .onAppear(perform: resetChartAnimation)
                        .onAppear(perform: animateChart)
                    }
                    ///Line Chart
                    if currentChart == Charts.line.rawValue {
                        Chart {
                            ForEach(chartData) { datum in
                                LineMark(x: .value("Month", datum.month),
                                         y: .value("Data List", datum.isAnimated ? datum.value : 0))
                                    .foregroundStyle(.blue.gradient)
                                    .opacity(datum.isAnimated ? 1 : 0)
                            }
                        }
                        .chartYScale(domain: 0...12000)
                        .frame(height: 300)
                        .padding()
                        .background(.background, in: .rect(cornerRadius: 10))
                        .onAppear(perform: resetChartAnimation)
                        .onAppear(perform: animateChart)
                    }
                    ///Pie Chart
                    if currentChart == Charts.pie.rawValue {
                        Chart {
                            ForEach(chartData) { datum in
                                SectorMark(angle: .value("Data List", datum.isAnimated ? datum.value : 0))
                                    .foregroundStyle(by: .value("Month", datum.month))
                                    .opacity(datum.isAnimated ? 1 : 0)
                            }
                        }
                        .chartYScale(domain: 0...12000)
                        .frame(height: 300)
                        .padding()
                        .background(.background, in: .rect(cornerRadius: 10))
                        .onAppear(perform: resetChartAnimation)
                        .onAppear(perform: animateChart)
                    }
                }
                
                Spacer(minLength: 0)
                
            }
            .padding()
            .background(.gray.opacity(0.12))
            .navigationTitle("Charts")
        }
    }
    
    private func animateChart() {
        guard !isAnimated else { return }
        isAnimated = true
        $chartData.enumerated().forEach { index, element in
            let delay = Double(index) * 0.12
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.smooth) {
                    element.wrappedValue.isAnimated = true
                }
            }
        }
    }
    
    private func resetChartAnimation() {
        $chartData.forEach { datum in
            datum.wrappedValue.isAnimated = false
        }
        isAnimated = false
    }
}

#Preview {
    ContentView()
}
