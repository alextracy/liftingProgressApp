coefficients = {
	1: 1, 2: .943, 3: .906, 4: .881, 5: .851, 6: .831, 7: .807, 8: .786, 9: .765, 10: .744
}
@LiftForm = React.createClass
	getInitialState: ->
		date: ''
		liftName: ''
		isMetric: false
		weightLifted: ''
		repsPerformed: ''
		oneRm: '0'
	handleValueChange: (e) ->
		valueName = e.target.name
		@setState "#{ valueName }": e.target.value
	toggleUnit: (e) ->
		e.preventDefault()
		@setState isMetric: !@state.isMetric
	calculateOneRm: ->
		if @state.weightLifted and @state.repsPerformed
			@state.oneRm = @state.weightLifted / coefficients[@state.repsPerformed]
		else
			0
	valid: ->
		@state.date && @state.liftName && @state.weightLifted && @state.repsPerformed && @state.oneRm
	handleSubmit: (e) ->
		e.preventDefault()
		$.post '', { lift: @state }, (data) =>
			@props.handleNewLift data
			@setState @getInitialState()
		, 'JSON'
	render: ->
		React.DOM.form
			className: 'form-inline'
			onSubmit: @handleSubmit
			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'date'
					className: 'form-control'
					placeholder: '11/11/1111'
					name: 'date'
					value: @state.date
					onChange: @handleValueChange
			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'Lift Name'
					name: 'liftName'
					value: @state.liftName
					onChange: @handleValueChange
			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'number'
					className: 'form-control'
					placeholder: 'weightLifted'
					name: 'weightLifted'
					value: @state.weightLifted
					onChange: @handleValueChange
			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'number'
					min: 1
					max: 10
					className: 'form-control'
					placeholder: '#'
					name: 'repsPerformed'
					value: @state.repsPerformed
					onChange: @handleValueChange
			React.DOM.button
				className: 'btn btn-primary'
				onClick: @toggleUnit
				'Metric = ' + @state.isMetric.toString()
			React.DOM.button
				type: 'submit'
				className: 'btn btn-primary'
				disabled: !@valid()
				'Create Lift'
			React.createElement OneRmBox, oneRm: @calculateOneRm()

