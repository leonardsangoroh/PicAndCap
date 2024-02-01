//
//  UIDevice+Extension.swift
//  PicAndCap
//
//  Created by Lee Sangoroh on 01/02/2024.
//

import UIKit

extension UIDevice {
    static var isSimulator: Bool = {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }()
}
