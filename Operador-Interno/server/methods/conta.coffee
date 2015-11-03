Meteor.methods
	'conta:cadastrar': (cpf, agencia, conta) ->
		# TODO verificar permissão

		Validations.cpf cpf
		Validations.agencia agencia
		Validations.conta conta

		Verifications.deveExistirCpf cpf
		Verifications.deveExistirAgencia agencia
		Verifications.naoDeveExistirConta conta

		contas.insert
			_id: conta
			agencia: agencia
			cliente: cpf
			saldo: 0

		return true


	'conta:listar': ->
		# TODO verificar permissão

		return contas.find().fetch()


	'conta:deletar': (conta) ->
		# TODO verificar permissão

		Validations.conta conta
		Verifications.deveExistirConta conta

		contas.remove _id: conta

		return true
