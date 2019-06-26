//
//  ExpensesView.swift
//  Tripulate
//
//  Created by Dani Shifer on 17/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import TripulateKit

struct ExpensesView : View {
    @EnvironmentObject var viewModel: ExpensesViewModel
    
    var body: some View {
        
        List {
            ForEach(self.viewModel.expenses.identified(by: \.[0])) { (section: [Expense]) in
                Section(header: HStack {
                    Text(self.viewModel.dateFormatter.string(from: section[0].creationDate))
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("$200")
                }) {
                    ForEach(section) { (expense: Expense) in
                        return HStack {
                            VStack(alignment: .leading) {
                                Text(expense.name ?? "")
                                
                                Text({ () -> String in
                                    let formatter = DateFormatter()
                                    formatter.timeStyle = .short
                                    return formatter.string(from: expense.creationDate)
                                }())
                                .font(.caption)
                                .color(.secondary)
                            }
                            
                            Spacer()
                            
                            Text([
                                "\(self.viewModel.currency?.symbol ?? "")",
                                self.viewModel.numberFormatter.string(for: expense.amount) ?? ""
                            ].joined())
                            .font(.headline)
                        }
                    }
                }
                
            }
        }
        .listStyle(.grouped)
        .navigationBarTitle(Text("Expenses"))
        .navigationBarItems(trailing: Button(action: {
            self.viewModel.showAddExpenseView.toggle()
        }) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
        })
        .presentation(viewModel.showAddExpenseView ? Modal(viewModel.addExpenseView, onDismiss: {
            self.viewModel.showAddExpenseView = false
        }) : nil)
    }
    
    typealias WithViewModel = ExpensesView.Modified<_EnvironmentKeyWritingModifier<ExpensesViewModel?>>
}

//#if DEBUG
//struct ExpensesView_Previews : PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            ExpensesView(/*viewModel: .init()*/)
//        }
//    }
//}
//#endif
