# Interno - Agencias
Meteor.methods
	'agencia:cadastrar': (data) ->
		return chamarOperadorAutenticado.call this, 'interno', 'agencia:cadastrar', data

	'agencia:deletar': (data) ->
		return chamarOperadorAutenticado.call this, 'interno', 'agencia:deletar', data


# Interno - Clientes
Meteor.methods
	'conta:cadastrar': (data) ->
		return chamarOperadorAutenticado.call this, 'interno', 'conta:cadastrar', data

	'conta:deletar': (data) ->
		return chamarOperadorAutenticado.call this, 'interno', 'conta:deletar', data


# Interno - Contas
Meteor.methods
	'cliente:cadastrar': (data) ->
		return chamarOperadorAutenticado.call this, 'interno', 'cliente:cadastrar', data

	'cliente:deletar': (data) ->
		return chamarOperadorAutenticado.call this, 'interno', 'cliente:deletar', data


# Deposito
Meteor.methods
	'depositar': (data) ->
		return chamarOperadorAutenticado.call this, 'deposito', 'depositar', data


# Saque
Meteor.methods
	'sacar': (data) ->
		return chamarOperadorAutenticado.call this, 'saque', 'sacar', data


# Extrato
Meteor.methods
	'extrato': (data) ->
		return chamarOperadorAutenticado.call this, 'extrato', 'extrato', data


# Transferencia
Meteor.methods
	'transferir': (data) ->
		return chamarOperadorAutenticado.call this, 'transferencia', 'transferir', data
