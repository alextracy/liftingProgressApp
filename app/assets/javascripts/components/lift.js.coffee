coefficients = {
	1: 1, 2: .943, 3: .906, 4: .881, 5: .851, 6: .831, 7: .807, 8: .786, 9: .765, 10: .744
}
@Lift = React.createClass
	getInitialState: ->
		edit: false
		oneRm: @props.lift.oneRm
		isMetric: @props.lift.isMetric
	handleToggle: (e) ->
		e.preventDefault()
		@setState edit: !@state.edit
	handleDelete: (e) ->
		e.preventDefault()
		$.ajax
			method: 'DELETE'
			url: "/lifts/#{ @props.lift.id }"
			dataType: 'JSON'
			success: () =>
				@props.handleDeleteLift @props.lift
	handleEdit: (e) ->
		e.preventDefault()
		data =
			date: ReactDOM.findDOMNode(@refs.date).value
			liftName: ReactDOM.findDOMNode(@refs.liftName).value
			weightLifted: ReactDOM.findDOMNode(@refs.weightLifted).value
			isMetric: @state.isMetric
			repsPerformed: ReactDOM.findDOMNode(@refs.repsPerformed).value
			oneRm: @state.oneRm
		$.ajax
			method: 'PUT'
			url: "/lifts/#{ @props.lift.id }"
			dataType: 'JSON'
			data:
				lift: data
			success: (data) =>
				@setState edit: false
				@props.handleEditLift @props.lift, data
	reCalculateOneRm: ->
		@setState oneRm: @getOneRm( ReactDOM.findDOMNode(@refs.weightLifted).value, ReactDOM.findDOMNode(@refs.repsPerformed).value)
		getOneRm: (weight, resps) ->
			if weight and reps > 0 and reps < 11
				weight / coeficients[reps]
			else
				0
	toggleUnit: (e) ->
		e.preventDefault()
		@setState isMetric: !@state.isMetric
	liftRow: ->
		React.DOM.tr null,
			React.DOM.td null, @props.lift.date
			React.DOM.td null, @props.lift.liftName
			React.DOM.td null, @props.lift.weightLifted
			React.DOM.td null, @props.lift.repsPerformed
			React.DOM.td null, @props.lift.oneRm
			React.DOM.td null, @props.lift.isMetric.toString()
			React.DOM.td null,
				React.DOM.button
					className: 'btn btn-primary'
					onClick: @handleToggle
					'Edit'
				React.DOM.button
					className: 'btn btn-danger'
					onClick: @handleDelete
					'Delete'
	liftForm: ->
		React.DOM.tr null,
			React.DOM.td null,
				React.DOM.input
					className: 'form-control'
					type: 'date'
					defaultValue: @props.lift.date
					ref: 'date'
			React.DOM.td null,
				React.DOM.input
					className: 'form-control'
					type: 'text'
					defaultValue: @props.lift.liftName
					ref: 'liftName'
			React.DOM.td null,
				React.DOM.input
					className: 'form-control'
					type: 'number'
					defaultValue: @props.lift.weightLifted
					ref: 'weightLifted'
					onChange: @reCalculateOneRm
			React.DOM.td null,
				React.DOM.input
					className: 'form-control'
					type: 'number'
					min: '1'
					max: '10'
					defaultValue: @props.lift.repsPerformed
					ref: 'repsPerformed'
					onChange: @reCalculateOneRm
			React.DOM.td null,
				@state.oneRm
			React.DOM.td null,
				React.DOM.button
					className: 'btn btn-primary'
					onClick: @handleEdit
					'Update'
				React.DOM.button
					className: 'btn btn-danger'
					onClick: @handleToggle
					'Cancel'
	render: ->
		if @state.edit
			@liftForm()
		else
			@liftRow()
