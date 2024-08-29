import UIKit
import Combine

class MainViewModel: ObservableObject {
    
    //MARK: - Variables
    
    @Published var resultText = "0"
    private var firstNumber = 0.0
    private var secondNumber = 0.0
    private var currentOperation: Operation = .none
    
    //MARK: - Calculator Func
    
    func selectedButton(item: Buttons) {
        
        if item == .clear {
            resultText = "0"
            firstNumber = 0.0
            secondNumber = 0.0
            currentOperation = .none
        }
        
        guard let number = stringToDouble(stringNumber: resultText) else { return }
        
        switch item {
        case .plus:
            firstNumber = number
            currentOperation = .addition
            resultText = "0"
        case .minus:
            firstNumber = number
            currentOperation = .subtract
            resultText = "0"
        case .multiple:
            firstNumber = number
            currentOperation = .multiply
            resultText = "0"
        case .divide:
            firstNumber = number
            currentOperation = .divide
            resultText = "0"
        case .equal:
            secondNumber = number
            do {
                let result = try selectedOperation(currentValue: secondNumber)
                resultText = numberFormatter(numberFormat: result)
                currentOperation = .none
            } catch DivisionError.dividedByZero {
                resultText = "Error" // Handle division by zero error
            } catch {
                resultText = "Error" //An unexpected error occurred
            }
        case .decimal:
            if !resultText.contains(",") {
                resultText += ","
            }
        case .percent:
            let percentValue = number / 100
            resultText = numberFormatter(numberFormat: percentValue)
        case .negative:
            let negatedValue = number * -1
            resultText = numberFormatter(numberFormat: negatedValue)
        default:
            if resultText.count <= 9, item != .clear {
                if resultText == "0" {
                    resultText = item.rawValue
                } else {
                    resultText += item.rawValue
                }
            }
        }
    }
    
    private func selectedOperation(currentValue: Double) throws -> Double {
        switch currentOperation {
        case .addition:
            return firstNumber + currentValue
        case .subtract:
            return firstNumber - currentValue
        case .multiply:
            return firstNumber * currentValue
        case .divide:
            if currentValue == 0 {
                throw DivisionError.dividedByZero
            }
            return firstNumber / currentValue
        case .none:
            return currentValue
        }
    }
    
    private func numberFormatter(numberFormat: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6
        
        if numberFormat == 0 {
            return "0"
        }
        
        // Bilimsel gösterimi sadece büyük veya küçük sayılar için yap
        if abs(numberFormat) < 1e-3 || abs(numberFormat) >= 1e9 {
            formatter.numberStyle = .scientific
            return  formatter.string(from: NSNumber(value: numberFormat)) ?? "0"
        } else {
            formatter.numberStyle = .decimal
            return  formatter.string(from: NSNumber(value: numberFormat)) ?? "0"
        }
    }
    
    private func stringToDouble(stringNumber: String?) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.numberStyle = .decimal
        if let number = formatter.number(from: stringNumber ?? "") {
            return number.doubleValue
        }
        return nil
    }
}

