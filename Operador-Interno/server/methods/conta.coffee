Meteor.methods
	'conta:cadastrar': (data) ->
		check data, Object

		Validations.cpf data.cpf
		Validations.agencia data.agencia
		Validations.conta data.conta
		Validations.senha data.senha

		Verifications.deveExistirCpf data.cpf
		Verifications.deveExistirAgencia data.agencia
		Verifications.naoDeveExistirConta data.conta

		Meteor.users.insert
			_id: data.conta
			agencia: data.agencia
			role: 'conta'
			username: data.conta
			saldo: 0

		Accounts.setPassword data.conta, data.senha

		return true


	'conta:listar': ->
		return Meteor.users.find({role: 'conta'}).fetch()


	'conta:deletar': (data) ->
		check data, Object

		Validations.conta data.conta
		Verifications.deveExistirConta data.conta

		Meteor.users.remove _id: data.conta

		transacoes.remove conta: data.conta

		return true
