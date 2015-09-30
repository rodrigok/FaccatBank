contas = new Meteor.Collection 'contas'
transacoes = new Meteor.Collection 'transacoes'

Meteor.methods
	depositar: (agencia_id, conta_id, valor) ->
		tx.start 'depositar'

		transacoes.insert
			operacao: 'depositar'
			agencia: agencia_id
			conta: conta_id
			operador: Meteor.userId()
			valor: valor
		,
			tx: true

		contas.update
			_id: conta_id
			agencia: agencia_id
		,
			$inc:
				valor: valor
		,
			tx: true

		tx.commit()
