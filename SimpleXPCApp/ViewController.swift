import Cocoa

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func installHelperClicked(_ sender: Any) {
        HelperInstaller.install()
    }
    
    @IBAction func sendPrivilegedHiMessage(_ sender: Any) {
        
        let connection = NSXPCConnection(machServiceName: MACH_SERVICE_NAME, options: .privileged)
        connection.remoteObjectInterface = NSXPCInterface(with: SimpleXPCProtocol.self)
        connection.resume()
        
        let remoteObject = connection.remoteObjectProxyWithErrorHandler { (err) in
            print("Error \(err.localizedDescription)")
        } as? SimpleXPCProtocol
        
        remoteObject?.privilegedHi(completion: { (message) in
            DispatchQueue.main.async {
                let alert = NSAlert()
                alert.messageText = "Helper responded"
                alert.informativeText = message
                alert.alertStyle = .informational
                alert.addButton(withTitle: "OK")
                alert.runModal()
            }
        })
        
    }
    
    @IBAction func spawnPrivilegedAlert(_ sender: Any) {
        let connection = NSXPCConnection(machServiceName: MACH_SERVICE_NAME, options: .privileged)
        connection.remoteObjectInterface = NSXPCInterface(with: SimpleXPCProtocol.self)
        connection.resume()
        
        let remoteObject = connection.remoteObjectProxyWithErrorHandler { (err) in
            print("Error \(err.localizedDescription)")
        } as? SimpleXPCProtocol
        
        remoteObject?.privilegedAlert()
    }
}

