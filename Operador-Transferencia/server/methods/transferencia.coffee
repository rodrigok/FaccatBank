Meteor.methods
	transferir: (data) ->
		check data, Object
		check data.para, Object

		Validations.agencia data.agencia
		Validations.conta data.conta
		Verifications.deveExistirAgencia data.agencia
		Verifications.deveExistirConta data.conta

		Validations.agencia data.para.agencia
		Validations.conta data.para.conta
		Verifications.deveExistirAgencia data.para.agencia
		Verifications.deveExistirConta data.para.conta

		Validations.valor data.valor

		# Debito de
		transacoes.insert
			operacao: 'transferencia'
			tipo: 'debito'
			para: data.para
			agencia: data.agencia
			conta: data.conta
			operador: Meteor.userId()
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
			de: data.de
			agencia: data.para.agencia
			conta: data.para.conta
			operador: Meteor.userId()
			valor: data.valor

		Meteor.users.update
			_id: data.para.conta
			agencia: data.para.agencia
		,
			$inc:
				saldo: data.valor
