//
//  Model.swift
//  CalculatorMVVM
//
//  Created by Tuna Demirci on 26.08.2024.
//

import Foundation

enum DivisionError: Error {
    case dividedByZero
}

enum Operation {
    case addition, subtract, multiply, divide, none
}

enum Buttons: String {
    case zero     = "0"
    case one      = "1"
    case two      = "2"
    case three    = "3"
    case four     = "4"
    case five     = "5"
    case six      = "6"
    case seven    = "7"
    case eight    = "8"
    case nine     = "9"
    case plus     = "+"
    case minus    = "-"
    case multiple = "x"
    case divide   = "/"
    case equal    = "="
    case decimal  = ","
    case percent  = "%"
    case negative = "+/-"
    case clear    = "AC"
}
