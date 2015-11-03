Meteor.methods
	'agencia:cadastrar': (agencia) ->
		# TODO verificar permissão

		Validations.agencia agencia

		Verifications.naoDeveExistirAgencia agencia

		agencias.insert
			_id: agencia

		return true


	'agencia:listar': ->
		# TODO verificar permissão

		return agencias.find().fetch()


	'agencia:deletar': (agencia) ->
		# TODO verificar permissão

		Validations.agencia agencia
		Verifications.deveExistirAgencia agencia

		agencias.remove _id: agencia

		return true
