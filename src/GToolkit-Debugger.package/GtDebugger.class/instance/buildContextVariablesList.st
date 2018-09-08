building widgets
buildContextVariablesList
	| contextVariablesList |
	
	contextVariablesList := BrColumnedList new 
		addEventHandler: (GtInspectorListToSelectHandler new transformation: [:each | each rawValue ]);
		constraintsDo: [ :c | 
			c padding: (BlInsets all: 10) ].
			
	contextVariablesList column
		title: 'Variable';
		stencil: [ :aNode :index |
			| textElement |
			textElement := (BrListLabelStencil matchParent: (GTObjectPrinter asNonTruncatedTextFrom: aNode key)) asElement.
			textElement constraintsDo: [ :c | c padding: (BlInsets right: 10)] ].

	contextVariablesList column
		title: 'Value';
		stencil: [ :aNode :index | 
			| textElement rawValue displayValue |
				[ rawValue := aNode rawValue. ] 
					on: Error 
					do: [ displayValue := Text string: aNode errorMessage attribute: TextColor red ].
			textElement := (BrListLabelStencil matchParent: (displayValue 
				ifNil: [ GTObjectPrinter asTruncatedTextFrom: rawValue ])) asElement.
			textElement constraintsDo: [ :c | c padding: (BlInsets right: 10) ] ].
	^ contextVariablesList
	
	