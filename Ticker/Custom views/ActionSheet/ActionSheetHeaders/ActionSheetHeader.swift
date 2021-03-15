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
    let detail: NSAttributedString?
}

enum ActionSheetHeaderType {
    case title(title: NSAttributedString)
    case titleDetail(title: NSAttributedString, detail: NSAttributedString)
}
