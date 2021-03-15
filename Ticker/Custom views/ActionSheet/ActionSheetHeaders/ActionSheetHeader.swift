//
//  ActionSheetHeader.swift
//  Ticker
//
//  Created by David Hansson on 15/03/2021.
//

import UIKit

protocol ActionSheetHeader {
    func configure(withViewModel viewModel: ActionSheetHeaderViewModel)
}

struct ActionSheetHeaderViewModel {
    let title: NSAttributedString?
}

enum ActionSheetHeaderType {
    case title(title: NSAttributedString)
}
