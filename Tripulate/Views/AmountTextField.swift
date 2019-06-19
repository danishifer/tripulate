//
//  AmountTextField.swift
//  Tripulate
//
//  Created by Dani Shifer on 17/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

class AmountTextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("changed")
    }
}

struct AmountTextField: UIViewRepresentable, UITextFieldDelegate {
    @Binding var text: String
    var placeholder: String = "Amount"
    
    func 
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        textField.text = text
        
        textField.addTarget(AmountTextFieldDelegate(), action: Selector(("textFieldDidChange:")), for: .editingChanged)
        return textField
    }
    
    
    
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}

#if DEBUG
struct AmountTextField_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            AmountTextField(text: .constant("2000.25"))
                .previewLayout(.fixed(width: 300, height: 30))
            
            AmountTextField(text: .constant(""))
                .previewLayout(.fixed(width: 300, height: 30))
        }
    }
}
#endif
