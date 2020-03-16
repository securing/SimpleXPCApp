// Installer implemented basing on https://github.com/erikberglund/SwiftPrivilegedHelper

import Foundation
import ServiceManagement

enum HelperAuthorizationError: Error {
    case message(String)
}

class HelperInstaller {
    
    private static func executeAuthorizationFunction(_ authorizationFunction: () -> (OSStatus) ) throws {
        let osStatus = authorizationFunction()
        guard osStatus == errAuthorizationSuccess else {
            throw HelperAuthorizationError.message(String(describing: SecCopyErrorMessageString(osStatus, nil)))
        }
    }
    
    static func authorizationRef(_ rights: UnsafePointer<AuthorizationRights>?,
                                 _ environment: UnsafePointer<AuthorizationEnvironment>?,
                                 _ flags: AuthorizationFlags) throws -> AuthorizationRef? {
        var authRef: AuthorizationRef?
        try executeAuthorizationFunction { AuthorizationCreate(rights, environment, flags, &authRef) }
        return authRef
    }
    
    static func install() -> Void {
    
        var cfError: Unmanaged<CFError>?
        var authItem = AuthorizationItem(name: kSMRightBlessPrivilegedHelper, valueLength: 0, value:UnsafeMutableRawPointer(bitPattern: 0), flags: 0)
        var authRights = AuthorizationRights(count: 1, items: &authItem)
        
        do {
            let authRef = try authorizationRef(&authRights, nil, [.interactionAllowed, .extendRights, .preAuthorize])
            SMJobBless(kSMDomainSystemLaunchd, MACH_SERVICE_NAME as CFString, authRef, &cfError)
        } catch let err {
            print("Error in installing the helper -> \(err.localizedDescription)")
        }
    }
    
}
