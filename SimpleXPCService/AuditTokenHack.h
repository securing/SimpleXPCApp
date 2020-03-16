#import <Foundation/Foundation.h>

@interface NSXPCConnection(PrivateAuditToken)

@property (nonatomic, readonly) audit_token_t auditToken;

@end


@interface AuditTokenHack : NSObject

+(NSData *)getAuditTokenDataFromNSXPCConnection:(NSXPCConnection *)connection;

@end
