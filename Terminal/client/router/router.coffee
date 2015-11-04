Router.onBeforeAction ->
	if agencia.get()?.userId()?
		this.next()
	else
		this.render 'login'

Router.route '/', ->
	if account?.user()?.profile.role is 'funcionario'
		this.render('funcionario')
	else
		this.render('conta')
