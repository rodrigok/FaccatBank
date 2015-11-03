contas = new Meteor.Collection 'contas'
transacoes = new Meteor.Collection 'transacoes'

Meteor.methods
	depositar: (data) ->
		console.log 'depositar', data

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
