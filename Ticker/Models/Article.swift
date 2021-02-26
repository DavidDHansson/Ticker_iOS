//
//  Article.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//

import UIKit

struct Article: Codable {
    let title: String
    let description: String?
    let id: String
    let date: Date
    let imgURL: String?
    let provider: String
}
