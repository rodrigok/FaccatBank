Meteor.methods
	'agencia:cadastrar': (data) ->
		check data, Object

		Validations.agencia data.agencia

		Verifications.naoDeveExistirAgencia data.agencia

		agencias.insert
			_id: data.agencia

		return true


	'agencia:listar': ->
		return agencias.find().fetch()


	'agencia:deletar': (data) ->
		check data, Object

		Validations.agencia data.agencia
		Verifications.deveExistirAgencia data.agencia

		agencias.remove _id: data.agencia

		return true
