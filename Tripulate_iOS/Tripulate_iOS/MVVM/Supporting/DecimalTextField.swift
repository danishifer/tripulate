//
//  AmountTextField.swift
//  Tripulate
//
//  Created by Dani Shifer on 17/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

struct DecimalTextField: UIViewRepresentable {
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        var didBecomeFirstResponder = false
        
        init(text: Binding<String>) {
            $text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
    
    @Binding var text: String
    var placeholder: String
    var isFirstResponder: Bool = false
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.keyboardType = .decimalPad
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        
        
        return textField
    }
    
    func makeCoordinator() -> DecimalTextField.Coordinator {
        return Coordinator(text: $text)
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder {
//            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}

#if DEBUG
struct AmountTextField_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            DecimalTextField(text: .constant("2000.25"), placeholder: "Amount")
                .previewLayout(.fixed(width: 300, height: 30))
            
            DecimalTextField(text: .constant(""), placeholder: "Amount")
                .previewLayout(.fixed(width: 300, height: 30))
        }
    }
}
#endif
