Meteor.methods
	sacar: (data) ->
		Validations.agencia data.agencia
		Validations.conta data.conta
		Validations.valor data.valor

		Verifications.deveExistirAgencia data.agencia
		Verifications.deveExistirConta data.conta

		transacoes.insert
			operacao: 'sacar'
			tipo: 'debito'
			agencia: data.agencia
			conta: data.conta
			operador: Meteor.userId()
			valor: data.valor
			data: new Date

		contas.update
			_id: data.conta
			agencia: data.agencia
		,
			$inc:
				valor: -data.valor

		return true
