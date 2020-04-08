//
//  Formatter.swift
//  FlagCountryQuiz
//
//  Created by Henrik on 2020-02-21.
//  Copyright © 2020 Henrik. All rights reserved.
//

import Foundation

func formatNumber(bigNumber: String) -> String {
    let bigNumber = Int(bigNumber)
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    guard let formattedNumber = numberFormatter.string(from: NSNumber(value: bigNumber ?? 1)) else { return ""}
    return formattedNumber
}

func formatArea(bigNumber: Float) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    guard let formattedNumber = numberFormatter.string(from: NSNumber(value: bigNumber)) else { return ""}
    return formattedNumber
}
