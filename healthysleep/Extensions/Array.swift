//
//  Array.swift
//  healthysleep
//
//  Created by Mac on 28/06/2021.
//

import Foundation


extension Array {
    
    subscript(index: Int) -> Any {
            get {
                return self[index]
            }
            set(newValue) {
                self[index] = newValue
            }
        }
}
