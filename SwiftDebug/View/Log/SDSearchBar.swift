//
//  SDSearchBar.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/11.
//

import Foundation
import UIKit
class SDSearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        searchBarStyle = .minimal
        isTranslucent = false
        prompt = ""
        showsCancelButton = false
        showsScopeBar = false
        showsBookmarkButton = false
        autocapitalizationType = .none
//        backgroundColor = mainBackgroundColor
        barTintColor = SDConfigCenter.shared.genernalConfig.mainBackgroundColor
//        layer.borderWidth = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
