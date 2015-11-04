Router.onBeforeAction ->
	if agencia.get()?.userId()?
		this.next()
	else
		this.render 'login'

Router.route '/', ->
	this.render('main')
