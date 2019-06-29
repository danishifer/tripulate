//
//  StatisticsView.swift
//  Tripulate
//
//  Created by Dani Shifer on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import TripulateKit

struct StatisticsView : View {
    @EnvironmentObject var viewModel: StatisticsViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Total Budget")) {
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(
                            [
                                self.viewModel.currency?.symbol ?? "",
                                self.viewModel.currency?.useSpace ?? false ? " " : "",
                                self.viewModel.numberFormatter.string(
                                    for: self.viewModel.totalBudgetSpent
                                ) ?? ""
                            ].joined()
                        ).font(.largeTitle).fontWeight(.semibold)
                        
                        Text(
                            [
                                "of ",
                                self.viewModel.currency?.symbol ?? "",
                                self.viewModel.currency?.useSpace ?? false ? " " : "",
                                self.viewModel.numberFormatter.string(for: self.viewModel.totalBudget) ?? "",
                                " ",
                                self.viewModel.currency?.code.uppercased() ?? "",
                                " spent"
                            ].joined()
                        ).color(.secondary)
                    }
                }
                
                Section(header: Text("Categories")) {
                    VStack {
                        BarGraph(data: self.viewModel.categoriesDistibution).frame(height: 250)
                    }
                }
                
                Section(header: Text("Days")) {
                    BarGraph(data: self.viewModel.daysDistribution).frame(height: 250)
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
