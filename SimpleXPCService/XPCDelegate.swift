import Foundation
import AppKit

class XPCDelegate: NSObject, NSXPCListenerDelegate, SimpleXPCProtocol {
    
    func privilegedAlert() {
        DispatchQueue.main.async {
            let alert = NSAlert()
            alert.messageText = "This is a privileged alert"
            alert.informativeText = "You got me!"
            alert.alertStyle = .warning
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
    
    func privilegedHi(completion: @escaping (String) -> Void) {
        completion("Privileged hi! My GID is \(getgid())")
    }
    
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        
        if ConnectionVerifier.isValid(connection: newConnection) {
            newConnection.exportedInterface = NSXPCInterface(with: SimpleXPCProtocol.self)
            newConnection.exportedObject = self
            newConnection.resume()
            return true
        }
    
        return false
    }
    
    
}
