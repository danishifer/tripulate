//
//  BarGraph.swift
//  Tripulate_iOS
//
//  Created by Dani Shifer on 26/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

struct BarData<Label>: Identifiable where Label: View {
    var id: String?
    var value: Double
    var label: Label
}


struct BarGraph<Label> : View where Label: View {
    let data: [BarData<Label>]
    let kBarSpacing: Length = 16.0
    var idealBarWidth: Length = 30.0
    
    var body: some View {
        guard
            let minimum = data.min(by: { (rhs, lhs) -> Bool in
                return rhs.value < lhs.value
            }),
            var maximum = data.max(by: { (rhs, lhs) -> Bool in
                return rhs.value < lhs.value
            })
        else {
            return AnyView(Text("No Statistics"))
        }
        
        // Compensate for maximum and minimum values
        // being the same resulting in division by 0
        if minimum.value == maximum.value {
            maximum.value = minimum.value + 0.0001
        }
        
        return AnyView(GeometryReader { geometry in
            HStack(alignment: .bottom) {
                ScrollView(showsHorizontalIndicator: false) {
                    HStack(alignment: .bottom, spacing: self.kBarSpacing) {
                        ForEach(self.data) { (bar: BarData) in
                            VStack(alignment: .center, spacing: 0) {
                                GeometryReader { proxy in
                                    VStack {
                                        Spacer()
                                        
                                        Rectangle()
                                            .fill(Color.accentColor)
                                            .frame(height: { () -> Length in
                                                let slope = (proxy.size.height - 20) / CGFloat(maximum.value - minimum.value)
                                                return slope * CGFloat(bar.value)
                                            }(), alignment: .bottom)
                                            .layoutPriority(1)
                                    }
                                    }.layoutPriority(1)
                                
                                bar.label
                            }
                        }
                        }
                        .padding(.horizontal, max(
                            0,
                            geometry.size.width
                                - self.idealBarWidth * CGFloat(self.data.count)
                                - self.kBarSpacing * CGFloat(self.data.count + 1)
                            ) / 2
                        )
                        .frame(minWidth: geometry.size.width, minHeight: geometry.size.height)
                    
                }
            }
        })
    }
}

#if DEBUG
struct BarGraph_Previews : PreviewProvider {
    static var previews: some View {
        BarGraph(data: [
            BarData(value: 10, label: Text("300"))
        ])
    }
}
#endif
