agencia = String(process.env.AGENCIA)

chamarOperador = (operador, nome, data) ->
	operadorInterno = Cluster.discoverConnection("operador-#{operador}")
	try
		if Match.test data, Object
			data.agencia = agencia
			data.operador = Meteor.userId()

		return operadorInterno.call nome, data
	catch e
		throw e


# Interno - Agencias
Meteor.methods
	'agencia:cadastrar': (data) ->
		return chamarOperador.call this, 'interno', 'agencia:cadastrar', data

	'agencia:deletar': (data) ->
		return chamarOperador.call this, 'interno', 'agencia:deletar', data


# Interno - Clientes
Meteor.methods
	'conta:cadastrar': (data) ->
		return chamarOperador.call this, 'interno', 'conta:cadastrar', data

	'conta:deletar': (data) ->
		return chamarOperador.call this, 'interno', 'conta:deletar', data


# Interno - Contas
Meteor.methods
	'cliente:cadastrar': (data) ->
		return chamarOperador.call this, 'interno', 'cliente:cadastrar', data

	'cliente:deletar': (data) ->
		return chamarOperador.call this, 'interno', 'cliente:deletar', data


# Deposito
Meteor.methods
	'deposito': (data) ->
		return chamarOperador.call this, 'deposito', 'depositar', data
