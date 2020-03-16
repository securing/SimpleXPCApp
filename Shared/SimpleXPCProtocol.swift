import Foundation

@objc(SimpleXPCProtocol)
protocol SimpleXPCProtocol {
    func privilegedHi(completion: @escaping (String) -> Void)
    func privilegedAlert()
}
