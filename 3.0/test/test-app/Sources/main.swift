import Foundation

#if os(Linux)
import Glibc
import ClibBSD
#endif

let random = Int(arc4random_uniform(UInt32(Quotes.all.count)))
print("\(Quotes.all[random])")
