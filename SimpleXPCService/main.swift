import Foundation

let listener = NSXPCListener.init(machServiceName: MACH_SERVICE_NAME)
let delegate = XPCDelegate()

listener.delegate = delegate
listener.resume()

RunLoop.main.run()
