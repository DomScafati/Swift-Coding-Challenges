import Foundation


func raceConditionGCD() {
    let lock = NSLock()
    var counter = 0
    let group = DispatchGroup()

    for _ in 0..<1000 {
        DispatchQueue.global().async(group: group) {
            lock.lock()
            counter += 1 // 🚨 Unsafe — race condition
            lock.unlock()
        }
    }

    group.wait()
    print("Final count:", counter) // ❌ Often < 1000
}



raceConditionGCD()
