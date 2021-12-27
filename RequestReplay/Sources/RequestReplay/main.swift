import Foundation
import JSONReader

let containers = try! JSONReader().readFile()
print(containers)
