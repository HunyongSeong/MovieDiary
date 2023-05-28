import UIKit
import SwiftUI

var greeting = "Hello, playground"

struct Animal: Identifiable {
    var id = UUID()
    var name: String
}

struct AnimalRow: View {
    var animal: Animal
    var body: some View {
        Text("현재 동물원에 있는 동물 = \(animal.name)")
    }
}

