Meteor.methods
	'conta:cadastrar': (data) ->
		# TODO verificar permissão
		check data, Object

		Validations.cpf data.cpf
		Validations.agencia data.agencia
		Validations.conta data.conta

		Verifications.deveExistirCpf data.cpf
		Verifications.deveExistirAgencia data.agencia
		Verifications.naoDeveExistirConta data.conta

		contas.insert
			_id: data.conta
			agencia: data.agencia
			cliente: data.cpf
			saldo: 0

		return true


	'conta:listar': ->
		# TODO verificar permissão

		return contas.find().fetch()


	'conta:deletar': (data) ->
		# TODO verificar permissão
		check data, Object

		Validations.conta data.conta
		Verifications.deveExistirConta data.conta

		contas.remove _id: data.conta

		return true
