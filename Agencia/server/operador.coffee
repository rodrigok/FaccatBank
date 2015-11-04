agencia = String(process.env.AGENCIA)

@chamarOperador = (operador, nome, data) ->
	operadorInterno = Cluster.discoverConnection("operador-#{operador}")
	try
		if Match.test data, Object
			data.agencia = agencia
			data.operador = Meteor.userId()

		return operadorInterno.call nome, data
	catch e
		throw e


@chamarOperadorAutenticado = (operador, nome, data) ->
	user = Meteor.user()
	if not user?
		throw new Meteor.Error 'Autentiação requerida'

	if operador is 'interno' and user.role isnt 'funcionario'
		throw new Meteor.Error 'Usuário sem acesso'

	if operador isnt 'interno' and user.role not in ['funcionario', 'cliente']
		throw new Meteor.Error 'Usuário sem acesso'

	return chamarOperador operador, nome, data
