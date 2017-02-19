@Lift = React.createClass
	render: ->
		React.DOM.tr null,
			React.DOM.td null, @props.lift.date
			React.DOM.td null, @props.lift.liftName
			React.DOM.td null, @props.lift.weightLifted
			React.DOM.td null, @props.lift.isMetric.toString()
			React.DOM.td null, @props.lift.repsPerformed
			React.DOM.td null, @props.lift.oneRm