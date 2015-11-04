Meteor.methods
	depositar: (data) ->
		Validations.agencia data.agencia
		Validations.conta data.conta
		Validations.valor data.valor

		Verifications.deveExistirAgencia data.agencia
		Verifications.deveExistirConta data.conta

		transacoes.insert
			operacao: 'depositar'
			agencia: data.agencia
			conta: data.conta
			operador: Meteor.userId()
			valor: data.valor

		contas.update
			_id: data.conta
			agencia: data.agencia
		,
			$inc:
				valor: data.valor
