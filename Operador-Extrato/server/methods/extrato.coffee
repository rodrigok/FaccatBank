Meteor.methods
	extrato: (data) ->
		Validations.agencia data.agencia
		Validations.conta data.conta

		Verifications.deveExistirAgencia data.agencia
		Verifications.deveExistirConta data.conta

		t = transacoes.find
			agencia: data.agencia
			conta: data.conta

		c = Meteor.users.findOne {_id: data.conta}, {fields: {agencia: 1, saldo: 1}}

		return {
			conta: c
			transacoes: t.fetch()
		}
