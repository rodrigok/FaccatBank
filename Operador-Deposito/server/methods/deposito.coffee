contas = new Meteor.Collection 'contas'
transacoes = new Meteor.Collection 'transacoes'

Meteor.methods
	depositar: (agencia_id, conta_id, valor) ->
		console.log 'depositar', agencia_id, conta_id, valor

		transacoes.insert
			operacao: 'depositar'
			agencia: agencia_id
			conta: conta_id
			operador: Meteor.userId()
			valor: valor

		contas.update
			_id: conta_id
			agencia: agencia_id
		,
			$inc:
				valor: valor
