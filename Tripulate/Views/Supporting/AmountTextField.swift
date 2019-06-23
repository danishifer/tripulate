//
//  AmountTextField.swift
//  Tripulate
//
//  Created by Dani Shifer on 17/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI

struct AmountTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = "Amount"
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.text = text
        textField.keyboardType = .decimalPad
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: nil) { (notification) in
            self.text = textField.text ?? ""
        }
        
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
