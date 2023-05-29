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

struct ContentView: View {
    var body: some View {
        
        let aaa = Animal(name: "tiger")
        let bbb = Animal(name: "tiger")
        let ccc = Animal(name: "lion")
        let animals = [aaa, bbb, ccc]
        
        return List(animals) { animal in
            AnimalRow(animal: animal)
        }
    }
}
