Extension { #name : #GtExceptionDebugingViewConfiguration }

{ #category : #'*GToolkit-Debugger' }
GtExceptionDebugingViewConfiguration class >> forException: anException [
	^ self new
		 withDebuggingExceptionTargetFor: anException
]