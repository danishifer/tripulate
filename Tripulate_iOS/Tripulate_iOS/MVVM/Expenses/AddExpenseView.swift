//
//  AddExpenseView.swift
//  Tripulate_iOS
//
//  Created by Dani Shifer on 25/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import TripulateKit

struct AddExpenseView : View {
    @EnvironmentObject var viewModel: AddExpenseViewModel
    let onDismiss: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                DecimalTextField(text: self.$viewModel.amount, placeholder: "Amount", isFirstResponder: true)
                TextField(self.$viewModel.name, placeholder: Text("Description"))
                Picker(selection: self.$viewModel.category, label: Text("Category")) {
                    ForEach(self.viewModel.categories) { (category: ExpenseCategory) in
                        HStack {
                            Image(uiImage: category.icon)
                            Text(category.displayName)
                        }
                        .tag(category.id ?? "")
                    }
                }
            }
            .navigationBarTitle(Text("New Expense"))
            .navigationBarItems(leading: Button(action: {
                self.onDismiss()
            }) {
                Text("Cancel")
            }, trailing: Button(action: {
                guard self.viewModel.addExpense() == true else {
                    print("Couldn't add expense")
                    return
                }
                
                self.onDismiss()
            }) {
                Text("Add")
            }.disabled(!viewModel.canAddExpense))
        }
    }
    
    typealias WithViewModel = AddExpenseView.Modified<_EnvironmentKeyWritingModifier<AddExpenseViewModel?>>
}

#if DEBUG
struct AddExpenseView_Previews : PreviewProvider {
    static var previews: some View {
        AddExpenseView(onDismiss: {})
    }
}
#endif
