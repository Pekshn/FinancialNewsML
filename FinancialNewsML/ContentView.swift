//
//  ContentView.swift
//  FinancialNewsML
//
//  Created by Petar  on 2.3.25..
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var text = "Apple stocks upscaled for 30%"
    @State private var result = ""
    private let model = try! FinancialNewsSentimentAnalysis(configuration: MLModelConfiguration())
    
    var body: some View {
        VStack {
            
            Text(result)
                .frame(height: 44)
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            HStack(alignment: .center) {
                Text("Enter some financial news:")
            }
            
            TextField("Enter text", text: $text)
                .textFieldStyle(.roundedBorder)
            
            Button("Calculate") {
                do {
                    result = try model.prediction(text: text).label
                } catch {
                    print(error.localizedDescription)
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 10)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(getSentimentBgColor(result))
    }
    
    private func getSentimentBgColor(_ sentiment: String) -> Color {
        switch sentiment {
        case "positive":
            return .green
        case "negative":
            return .red
        case "neutral":
            return .yellow
        default:
            return .white
        }
    }
}

#Preview {
    ContentView()
}
