// RUN: rm -rf %t
// RUN: %clang_cc1 -objcmt-migrate-property -mt-migrate-directory %t %s -x objective-c -fobjc-runtime-has-weak -fobjc-arc -fobjc-default-synthesize-properties -triple x86_64-apple-darwin11
// RUN: c-arcmt-test -mt-migrate-directory %t | arcmt-test -verify-transformed-files %s.result
// RUN: %clang_cc1 -triple x86_64-apple-darwin10 -fsyntax-only -x objective-c -fobjc-runtime-has-weak -fobjc-arc -fobjc-default-synthesize-properties %s.result

@interface NSObject @end

@protocol P
- (id) Meth1: (double) arg;
@end

@interface Test1  // Test for no super class and no protocol list
@end

@implementation Test1
- (id) Meth1: (double) arg { return 0; }
@end

@protocol P1 @end
@protocol P2 @end

@interface Test2 <P1, P2>  // Test for no super class and with protocol list
{
  id IVAR1;
  id IVAR2;
}
@end

@implementation Test2
- (id) Meth1: (double) arg { return 0; }
@end

@interface Test3 : NSObject  { // Test for Super class and no  protocol list
  id IV1;
}
@end

@implementation Test3
- (id) Meth1: (double) arg { return 0; }
@end

@interface Test4 : NSObject <P1, P2> // Test for Super class and protocol list
@end

@implementation Test4
- (id) Meth1: (double) arg { return 0; }
@end

