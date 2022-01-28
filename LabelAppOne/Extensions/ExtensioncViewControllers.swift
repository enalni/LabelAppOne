//
//  ExtensioncViewControllers.swift
//  LabelAppOne
//
//  Created by Александр Николаевич on 28.01.2022.
//

import Foundation
import UIKit


extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    // сколько компонентов выводить
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    // сколько строк в компоненте
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 0: return familesFont.count
        case 1: return systemColor.count
        default:
            return 0
        }
        
    }
    
    // что будет выводить
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case 0 : return familesFont[row]
        case 1: return systemColor[row]
        default:
            return "error"
        }
    }
    
    // выбор ячейки
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
        case 0:
            DispatchQueue.main.async {
                let nameFont = self.familesFont[row]
                self.currentFont = nameFont
                self.myLabel.font = UIFont(name: nameFont, size: 35)
            }
        case 1:
            DispatchQueue.main.async {
                self.myLabel.textColor = self.color[row]
            }
        default:
            break
        }
    }
}
