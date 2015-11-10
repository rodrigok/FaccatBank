@showError = (error) ->
	if error?
		swal
			title: 'Ooops'
			text: error.error
			type: 'error'
			animation: "slide-from-top"

	return error
