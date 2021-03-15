//
//  ActionSheetAction.swift
//  Ticker
//
//  Created by David Hansson on 15/03/2021.
//

import UIKit

struct ActionSheetAction {
    let title: NSAttributedString?
    let style: UIAlertAction.Style
    let handler: (() -> Void)?
}
