//
//  Article.swift
//  Ticker
//
//  Created by David Hansson on 17/02/2021.
//

import UIKit

struct Article: Codable {
    let title: String?
    let img: String?
    let link: String
    let displayDate: String
    let provider: String
    let providerText: String
    let providerLink: String
    let providerImage: String
    let date: [String: Int]
}
