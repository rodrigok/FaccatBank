Meteor.methods
	extrato: (data) ->
		Validations.agencia data.agencia
		Validations.conta data.conta

		Verifications.deveExistirAgencia data.agencia
		Verifications.deveExistirConta data.conta

		t = transacoes.find
			agencia: data.agencia
			conta: data.conta

		c = contas.findOne
			_id: data.conta

		return {
			conta: c
			transacoes: t.fetch()
		}
