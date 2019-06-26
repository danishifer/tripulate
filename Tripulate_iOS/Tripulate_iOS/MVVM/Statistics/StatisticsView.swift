//
//  StatisticsView.swift
//  Tripulate
//
//  Created by Dani Shifer on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

struct StatisticsView : View {
    @EnvironmentObject var viewModel: StatisticsViewModel
    @State private var selection = 0
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Total Budget")) {
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(
                            self.viewModel.numberFormatter.string(
                                for: self.viewModel.totalBudgetSpent
                            ) ?? ""
                        ).font(.largeTitle).fontWeight(.semibold)
                        
                        Text("of $\(self.viewModel.numberFormatter.string(for: self.viewModel.totalBudget) ?? "") USD spent").color(.secondary)
                    }
                }
                
                Section(header: Text("Categories")) {
                    VStack {
                        SegmentedControl(selection: $selection) {
                            Text("Daily").tag(0)
                            Text("Weekly").tag(1)
                            Text("All Trip").tag(2)
                        }
                        
                        HStack(alignment: .bottom) {
                            VStack {
                                Capsule()
                                    .fill(Color.gray)
                                    .frame(width: 28, height: 60, alignment: .bottom)
                                
                                Image("category-transportation")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                            
                            VStack {
                                Capsule()
                                    .fill(Color.gray)
                                    .frame(width: 28, height: 40, alignment: .bottom)
                                
                                Image("category-shopping")
                            }
                        }
                    }
                }
                
            }
            .listStyle(.grouped)
            .navigationBarTitle(Text("Statistics"))
        }
    }
    
    typealias WithViewModel = StatisticsView.Modified<_EnvironmentKeyWritingModifier<StatisticsViewModel?>>
}

#if DEBUG
struct StatisticsView_Previews : PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
#endif
