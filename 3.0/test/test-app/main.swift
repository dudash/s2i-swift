import Foundation
let random = Int(arc4random_uniform(UInt32(Quotes.all.count)))
print("\(Quotes.all[random])")
