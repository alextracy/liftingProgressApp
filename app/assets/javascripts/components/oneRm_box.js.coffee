@OneRmBox = React.createClass
	render: ->
		React.DOM.div
			className: 'col-lg-12 card mx-auto'
			React.DOM.div
				className: 'card-block'
				React.DOM.h2
					className: 'card-title text-lg-center'
					'1 RM Estimate'
				React.DOM.h3
					className: 'card-text text-lg-center'
					@props.oneRm