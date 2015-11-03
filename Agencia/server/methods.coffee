chamarOperadorInterno = (nome, argumentos) ->
	operadorInterno = Cluster.discoverConnection("operador-interno")
	try
		return operadorInterno.apply nome, argumentos
	catch e
		throw e


# Interno - Agencias
Meteor.methods
	'agencia:cadastrar': ->
		return chamarOperadorInterno 'agencia:cadastrar', arguments

	'agencia:deletar': ->
		return chamarOperadorInterno 'agencia:deletar', arguments


# Interno - Clientes
Meteor.methods
	'conta:cadastrar': ->
		return chamarOperadorInterno 'conta:cadastrar', arguments

	'conta:deletar': ->
		return chamarOperadorInterno 'conta:deletar', arguments


# Interno - Contas
Meteor.methods
	'cliente:cadastrar': ->
		return chamarOperadorInterno 'cliente:cadastrar', arguments

	'cliente:deletar': ->
		return chamarOperadorInterno 'cliente:deletar', arguments
