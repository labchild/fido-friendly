//
//  PaddedTextField.swift
//  FidoFriendly
//
//  Created by Lelah Bates Childs on 1/10/23.
//

import UIKit

class PaddedTextField: UITextField {

    class TextField: UITextField {

        let padding = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 8.0)

        override open func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override open func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    }

}
