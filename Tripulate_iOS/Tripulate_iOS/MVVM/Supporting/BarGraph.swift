//
//  BarGraph.swift
//  Tripulate_iOS
//
//  Created by Haim Marcovici on 26/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

struct BarData<Label>: Identifiable where Label: View {
    var id: Double {
        get {
            return self.value
        }
    }
    
    var value: Double
    var label: Label
}

struct BarGraph : View {
    let data: [BarData<Image>]
    
    var body: some View {
        let minimum = data.min { (rhs, lhs) -> Bool in
            return rhs.value < lhs.value
        }

        let maximum = data.max { (rhs, lhs) -> Bool in
            return rhs.value > lhs.value
        }
        
        return HStack(alignment: .bottom) {
            ForEach(data) { (bar: BarData) in
                VStack {
                    GeometryReader { proxy in
                        Capsule()
                            .fill(Color.secondary)
                            .frame(width: 24, height: 40, alignment: .bottom)
//                        return Text("hello")
                    }
                    
                    bar.label
                }.frame(width: 24)
            }
        }
    }
}

#if DEBUG
struct BarGraph_Previews : PreviewProvider {
    static var previews: some View {
        BarGraph(data: [
            BarData(value: 10, label: Image("category-shopping"))
        ])
    }
}
#endif
