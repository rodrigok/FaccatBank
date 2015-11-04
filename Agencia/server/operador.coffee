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


permissoes =
	interno: ['funcionario']
	deposito: ['conta']
	saque: ['conta']
	extrato: ['conta']
	transferencia: ['conta']


@chamarOperadorAutenticado = (operador, nome, data) ->
	user = Meteor.user()
	if not user?
		throw new Meteor.Error 'Autentiação requerida'

	if user.role not in permissoes[operador]
		throw new Meteor.Error 'Usuário sem acesso'

	return chamarOperador operador, nome, data
