Meteor.methods
	transferir: (data) ->
		check data, Object
		check data.para, Object

		Validations.agencia data.agencia
		Validations.conta data.conta
		Verifications.deveExistirAgencia data.agencia
		Verifications.deveExistirConta data.conta

		Validations.valor data.valor
		Verifications.temSaldoParaSaque data.conta, data.valor

		Validations.agencia data.para.agencia
		Validations.conta data.para.conta
		Verifications.deveExistirAgencia data.para.agencia
		Verifications.deveExistirConta data.para.conta

		# Debito de
		transacoes.insert
			operacao: 'transferencia'
			tipo: 'debito'
			para: data.para
			agencia: data.agencia
			conta: data.conta
			valor: data.valor

		Meteor.users.update
			_id: data.conta
			agencia: data.agencia
		,
			$inc:
				saldo: -data.valor


		# Credito para
		transacoes.insert
			operacao: 'transferencia'
			tipo: 'credito'
			de:
				agencia: data.agencia
				conta: data.conta
			agencia: data.para.agencia
			conta: data.para.conta
			valor: data.valor

		Meteor.users.update
			_id: data.para.conta
			agencia: data.para.agencia
		,
			$inc:
				saldo: data.valor
