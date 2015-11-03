agencia = '1'

chamarOperadorInterno = (nome, data) ->
	operadorInterno = Cluster.discoverConnection("operador-interno")
	try
		if Match.test data, Object
			data.agencia = agencia

		return operadorInterno.call nome, data
	catch e
		throw e


# Interno - Agencias
Meteor.methods
	'agencia:cadastrar': (data) ->
		return chamarOperadorInterno 'agencia:cadastrar', data

	'agencia:deletar': (data) ->
		return chamarOperadorInterno 'agencia:deletar', data


# Interno - Clientes
Meteor.methods
	'conta:cadastrar': (data) ->
		return chamarOperadorInterno 'conta:cadastrar', data

	'conta:deletar': (data) ->
		return chamarOperadorInterno 'conta:deletar', data


# Interno - Contas
Meteor.methods
	'cliente:cadastrar': (data) ->
		return chamarOperadorInterno 'cliente:cadastrar', data

	'cliente:deletar': (data) ->
		return chamarOperadorInterno 'cliente:deletar', data
