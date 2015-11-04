Meteor.methods
	depositar: (data) ->
		Validations.agencia data.agencia
		Validations.conta data.conta
		Validations.valor data.valor

		Verifications.deveExistirAgencia data.agencia
		Verifications.deveExistirConta data.conta

		transacoes.insert
			operacao: 'depositar'
			tipo: 'credito'
			agencia: data.agencia
			conta: data.conta
			operador: Meteor.userId()
			valor: data.valor
			data: new Date

		Meteor.users.update
			_id: data.conta
			agencia: data.agencia
		,
			$inc:
				saldo: data.valor

		return true
