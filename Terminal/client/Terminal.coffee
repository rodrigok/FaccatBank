@agencia = Cluster.discoverConnection("agencia1")
@Account = new AccountsClient({connection: agencia})

Account.callLoginMethod
	methodArguments: [{
		user: {username: '00000000000'}
		password: Accounts._hashPassword('00000000000')
	}]

Tracker.autorun (c) ->
	if Account.userId()?
		c.stop()

		try agencia.call 'agencia:deletar', {agencia: '1'}
		try agencia.call 'cliente:deletar', {cpf: '01700873016'}
		try agencia.call 'conta:deletar', {conta: '1'}

		agencia.call 'agencia:cadastrar', {agencia: '1'}
		agencia.call 'cliente:cadastrar', {nome: 'Rodrigo Nascimento', cpf: '01700873016', senha: '123456'}
		agencia.call 'conta:cadastrar', {cpf: '01700873016', conta: '1'}

		agencia.call 'deposito', {conta: '1', valor: 120}
		agencia.call 'deposito', {conta: '1', valor: 20}
		agencia.call 'deposito', {conta: '1', valor: 100}

