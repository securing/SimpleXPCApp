# Secure Privileged XPC Helper

Building secure privileged XPC services is not trivial. During my [talk](https://objectivebythesea.com/v3/content.html#wRegula) "Abusing & Securing XPC in macOS apps" on [Objective By The Sea conference](https://objectivebythesea.com/v3/), I promised to share an example of a secure one. So, here it is!

## Learn XPC exploitation

This tool is not only mentioned to help to secure vulnerable XPC apps but also may help you learning XPC exploitation. Go to the `ConnectionVerifier.swift` file and comment the if statements.

## Installation

`1.` Please remember that you need to update the `Info.plist` files with a SecRequirement string basing on your developer certificate, since the Helper uses SMJobless API. More info [here](https://developer.apple.com/library/content/samplecode/SMJobBless/Introduction/Intro.html#//apple_ref/doc/uid/DTS40010071-Intro-DontLinkElementID_2)

Note, that in order to be secure, the SecRequirement string at least has to include:

* bundle identifiers (of the installer and the service)
* your dev certificate's team ID
* 'anchor trusted' prefix
* minimum version (of the installer and the service)

`2.` Updates also need to be performed in `Shared/Constants.swift`. 