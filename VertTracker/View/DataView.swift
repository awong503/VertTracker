//
//  DataView.swift
//  VertTracker
//
//  Created by Allen Wong on 2023-04-17.
//

import SwiftUI


struct DataView: View {
    @ObservedObject var vertData = VertData()
    @State var isClicked = false
    
    var body: some View {
        VStack {
            VStack {
                Text("VertTracker")
                    .font(.system(size: 40))
                    .padding()
                Text("Press and hold the green icon to measure vertical displacement.")
                    .font(.system(size: 20))

            }.padding()
            Spacer()
            if vertData.error != nil {
                Text("Error: \(vertData.error.debugDescription)")
                    .foregroundColor(.red)
                    .font(.title)
            }

            Button(action: {
                self.isClicked = false
                vertData.stopAltimeter()
            }) {
                ZStack {
                    Circle()
                        .strokeBorder(lineWidth: 12)
                    Image(systemName: "figure.highintensity.intervaltraining")
                        .foregroundColor(.green)
                        .font(.system(size: 100))
                        .padding()
                }
            }.simultaneousGesture(
                LongPressGesture(minimumDuration: 0.1).onEnded({ _ in
                    self.isClicked = true
                    vertData.startAltimeter()
                }))
            
            
            Button(action: {
                vertData.maxHeight = 0
            }) {
                ZStack {
                    Image(systemName: "repeat.circle")
                        .frame(height: 100)
                        .foregroundColor(.red)
                        .font(.system(size: 100))
                        .padding()
                }
            }
            
            VStack(alignment: .leading) {
                Text("\(String(format: "%.3f", vertData.convertToCM())) CM")
                    .foregroundColor(.indigo)
                    .font(.system(size: 30))
                    .frame(maxWidth: .infinity, alignment: .top)
                
                Text("\(String(format: "%.3f", vertData.convertToInches())) IN")
                    .foregroundColor(.indigo)
                    .font(.system(size: 30))
                    .frame(maxWidth: .infinity, alignment: .top)
            }

            
        }.padding()
        
        
    }
    
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
