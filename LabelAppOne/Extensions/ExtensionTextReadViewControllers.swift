//
//  ExtensionTextReadViewControllers.swift
//  LabelAppOne
//
//  Created by Александр Николаевич on 28.01.2022.
//

import Foundation
import UIKit

extension TextReadViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    // сколько компонентов выводить
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    // сколько строк в компоненте
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        familesFont.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        familesFont[row]
        
    }
    
    // выбор ячейки
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let nameFont = self.familesFont[row]
        self.currentFont = nameFont
        self.mainTextView.font = UIFont(name: nameFont, size: 35)
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == mainTextView {
            mainTextView.resignFirstResponder()
        }
        
    }
    

}
