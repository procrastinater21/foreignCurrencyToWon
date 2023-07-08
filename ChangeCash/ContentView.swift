//
//  ContentView.swift
//  ChangeCash
//
//  Created by fia on 2023/07/04.
//

import SwiftUI

struct ContentView: View {
    @State var amount : String = ""
    var body: some View {
        VStack {
            TextField("금액을 입력하세요.", text: $amount)
                .keyboardType(.numberPad)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .padding()
                .onAppear {
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
            
            Text("밧 -> 한화 : \(numberFormatter(price: bartToWon(price: amount))) 원")
                .font(.system(size: 21))
                .padding(5)
            Text("낍 -> 한화 : \(numberFormatter(price: kipToWon(price: amount))) 원")
                .font(.system(size: 21))
                .padding(5)
            Text("동 -> 한화 : \(numberFormatter(price: dongToWon(price: amount))) 원")
                .font(.system(size: 21))
                .padding(5)
        }
        .padding()
        .onAppear {
            UIApplication.shared.hideKeyboard()
        }
    }
}

func bartToWon(price : String) -> Int {
    let price = Int(price)
    let divideTen = (price ?? 0) / 1
    return Int(divideTen * 37)
}

func kipToWon(price : String) -> Int {
    let price = Int(price)
    let divideTen = (price ?? 0) / 1
    return Int(Double(divideTen) * Double(0.07))
}

func dongToWon(price : String) -> Int {
    let price = Int(price)
    let divideTen = (price ?? 0) / 1
    return Int(Double(divideTen) * Double(0.06))
}

func numberFormatter(price : Int) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return numberFormatter.string(from: NSNumber(value: price))!
}

extension UIApplication {
    func hideKeyboard() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
