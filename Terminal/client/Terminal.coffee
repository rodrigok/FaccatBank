@agenciaFuncionario = Cluster.discoverConnection("agencia1")
@agenciaCliente = Cluster.discoverConnection("agencia1")

@AccountFuncionario = new AccountsClient({connection: agenciaFuncionario})
@AccountCliente = new AccountsClient({connection: agenciaCliente})

AccountFuncionario.callLoginMethod
	methodArguments: [{
		user: {username: '00000000000'}
		password: Accounts._hashPassword('00000000000')
	}]

Tracker.autorun (c) ->
	if AccountFuncionario.userId()?
		c.stop()

		try agenciaFuncionario.call 'cliente:deletar', {cpf: '22222222222'}
		try agenciaFuncionario.call 'conta:deletar', {conta: '1'}

		agenciaFuncionario.call 'cliente:cadastrar', {nome: 'Rodrigo Nascimento', cpf: '22222222222', senha: '22222222222'}
		agenciaFuncionario.call 'conta:cadastrar', {cpf: '22222222222', conta: '1'}


		Meteor.setTimeout ->
			AccountCliente.callLoginMethod
				methodArguments: [{
					user: {username: '22222222222'}
					password: Accounts._hashPassword('22222222222')
				}]

			Tracker.autorun (c) ->
				if AccountCliente.userId()?
					c.stop()

					agenciaCliente.call 'deposito', {conta: '1', valor: 120}
					agenciaCliente.call 'deposito', {conta: '1', valor: 20}
					agenciaCliente.call 'deposito', {conta: '1', valor: 100}
		, 2000
