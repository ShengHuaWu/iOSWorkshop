import Foundation
import JSONReader

let url = try! JSONReader().readFile()
print(url)
