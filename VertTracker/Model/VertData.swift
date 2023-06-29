//
//  VertData.swift
//  VertTracker
//
//  Created by Allen Wong on 2023-06-21.
//

import Foundation
import SwiftUI
import CoreMotion

class VertData: ObservableObject {
    @Published var maxHeight: NSNumber = 0
    let altimeter = CoreMotion.CMAltimeter()
    var altChange: NSNumber = 0
    @Published var isMeasuring: Bool = false
    var error: Error? = nil
    
    
    func startAltimeter() {
        self.isMeasuring = true
        if CMAltimeter.isRelativeAltitudeAvailable(){
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main) { (data, err) in
                if (err == nil) {
                    self.altChange = data!.relativeAltitude
                    if (self.altChange.decimalValue >= self.maxHeight.decimalValue) {
                        self.maxHeight = self.altChange
                    }
                } else {
                    self.error = err                }
            }
        }
    }
    
    func stopAltimeter() {
        altimeter.stopRelativeAltitudeUpdates()
        isMeasuring = false
    }
    
    func convertToCM() -> Double {
        return maxHeight.doubleValue * 100
    }
    
    func convertToInches() -> Double {
        return maxHeight.doubleValue * 39.3701
        
    }
    
    
}
