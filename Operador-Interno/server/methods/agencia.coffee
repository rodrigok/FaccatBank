Meteor.methods
	'agencia:cadastrar': (data) ->
		# TODO verificar permissão
		check data, Object

		Validations.agencia data.agencia

		Verifications.naoDeveExistirAgencia data.agencia

		agencias.insert
			_id: data.agencia

		return true


	'agencia:listar': ->
		# TODO verificar permissão

		return agencias.find().fetch()


	'agencia:deletar': (data) ->
		# TODO verificar permissão
		check data, Object

		Validations.agencia data.agencia
		Verifications.deveExistirAgencia data.agencia

		agencias.remove _id: data.agencia

		return true
