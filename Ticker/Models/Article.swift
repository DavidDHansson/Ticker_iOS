//
//  Article.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//

import UIKit

struct Article: Codable {
    let img: String?
    let link: String
    let provider: String
    let title: String?
    let date: [String: Int]
}
