Meteor.methods
	'conta:cadastrar': (data) ->
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
		return contas.find().fetch()


	'conta:deletar': (data) ->
		check data, Object

		Validations.conta data.conta
		Verifications.deveExistirConta data.conta

		contas.remove _id: data.conta

		transacoes.remove conta: data.conta

		return true
