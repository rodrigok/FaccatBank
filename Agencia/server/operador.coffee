agencia = String(process.env.AGENCIA)

@chamarOperador = (operador, nome, data) ->
	this.unblock()
	operadorInterno = Cluster.discoverConnection("operador-#{operador}")
	if operadorInterno.status().status is 'offline'
		throw new Meteor.Error "O serviço \"#{nome}\" está indisponível"
	try
		result = operadorInterno.call nome, data
		operadorInterno.close()
		return result
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

	if user.profile.role not in permissoes[operador]
		throw new Meteor.Error 'Usuário sem acesso'

	if Match.test data, Object
		data.agencia = Meteor.user().agencia
		# data.operador = Meteor.user()
		if Meteor.user().profile.role is 'conta'
			data.conta = Meteor.user()._id

	return chamarOperador.call this, operador, nome, data
