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
		try agenciaFuncionario.call 'conta:deletar', {conta: '2'}

		agenciaFuncionario.call 'cliente:cadastrar', {nome: 'Rodrigo Nascimento', cpf: '22222222222'}
		agenciaFuncionario.call 'conta:cadastrar', {cpf: '22222222222', conta: '1', senha: '123456'}
		agenciaFuncionario.call 'conta:cadastrar', {cpf: '22222222222', conta: '2', senha: '123456'}


		Meteor.setTimeout ->
			AccountCliente.callLoginMethod
				methodArguments: [{
					user: {username: '1'}
					password: Accounts._hashPassword('123456')
				}]

			Tracker.autorun (c) ->
				if AccountCliente.userId()?
					c.stop()

					agenciaCliente.call 'depositar', {valor: 120}
					agenciaCliente.call 'depositar', {valor: 20}
					agenciaCliente.call 'depositar', {valor: 100}

					agenciaCliente.call 'sacar', {valor: 40}

					agenciaCliente.call 'transferir', {valor: 50, para: {agencia: '1', conta: '2'}}

					agenciaCliente.call 'extrato', {}, (err, data) ->
						console.log 'conta 1', JSON.stringify(data, null, 2)

		, 2000
