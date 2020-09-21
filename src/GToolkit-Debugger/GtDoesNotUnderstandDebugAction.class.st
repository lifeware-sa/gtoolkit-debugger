Class {
	#name : #GtDoesNotUnderstandDebugAction,
	#superclass : #DebugAction,
	#category : #'GToolkit-Debugger-Actions'
}

{ #category : #registration }
GtDoesNotUnderstandDebugAction class >> gt2ContextDebuggingActionFor: aDebugger [
	<gt2ContextDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: BrGlamorousIcons add
]

{ #category : #registration }
GtDoesNotUnderstandDebugAction class >> gt2StackDebuggingActionFor: aDebugger [
	"<gt2StackDebuggingAction>"
	
	^ (self forDebugger: aDebugger)
			icon: BrGlamorousIcons add;
			order: 4
]

{ #category : #testing }
GtDoesNotUnderstandDebugAction >> appliesToContext: aContext [
	^ aContext isContextDoesNotUnderstand or: [ 
		"Select the second context if the interupted context is a does not understand context."
		(self session interruptedContext sender = aContext  and: [ 
			self session interruptedContext  isContextDoesNotUnderstand ]) ]
]

{ #category : #testing }
GtDoesNotUnderstandDebugAction >> appliesToDebugger: aDebugger [

	^ aDebugger session isInterruptedContextDoesNotUnderstand 
]

{ #category : #accessing }
GtDoesNotUnderstandDebugAction >> defaultLabel [

	^  'Create'
]

{ #category : #accessing }
GtDoesNotUnderstandDebugAction >> defaultOrder [

	^ 1
]

{ #category : #actions }
GtDoesNotUnderstandDebugAction >> executeAction [
	"Should only be called when the debugger was created in response to a
	MessageNotUnderstood exception. Create a stub for the method that was
	missing and proceed into it, or create a class if it was missing instead"
	
	| msg msgCategory chosenClass |
	
	msg := self interruptedContext tempAt: 1.
	
	chosenClass := self interruptedContext receiver class.
	msgCategory := 'as yet unclassified'.
	
	self session
		implement: msg 
		classified: msgCategory 
		inClass: chosenClass 
		forContext: self interruptedContext.
	
	self session stepInto: self interruptedContext.
]

{ #category : #accessing }
GtDoesNotUnderstandDebugAction >> help [
    ^ 'Create the missing class or method in the user prompted class, and restart the debugger at the location where it can be edited.'
]

{ #category : #accessing }
GtDoesNotUnderstandDebugAction >> id [

	^ #doesNotUnderstand
]