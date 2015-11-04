Template.login.onCreated ->
	@errors = new ReactiveVar []


Template.login.helpers
	errors: ->
		return Template.instance().errors.get()


Template.login.events
	'submit form': (e, t) ->
		e.preventDefault()
		localStorage.clear()

		t.errors.set []

		agenciaValue = $('#agencia').val().trim()
		contaValue = $('#conta').val().trim()
		senhaValue = $('#senha').val().trim()

		login = ->
			window.AccountCliente = new AccountsClient({connection: window.agenciaConn})
			window.AccountCliente.callLoginMethod
				methodArguments: [{
					user: {username: contaValue}
					password: Accounts._hashPassword(senhaValue)
				}]
				userCallback: (error) ->
					if error?
						errors = t.errors.get()
						if error.reason is 'Incorrect password'
							errors.push('Senha inválida')
						else if error.reason is 'User not found'
							errors.push('Usuário não encontrado')
						else if error.reason is 'Match failed'
							errors.push('Usuário e senha não conferem')
						else
							errors.push(error.reason)
						t.errors.set errors

		if window.agenciaConn?
			window.agenciaConn.close()
			delete window.agenciaConn

		window.agenciaConn = Cluster.discoverConnection("agencia#{agenciaValue}")
		Tracker.autorun (c) ->
			if not agenciaConn?
				c.stop()
				return

			status = agenciaConn.status()
			if status.connected is true
				c.stop()
				agencia.set agenciaConn
				login()

			if status.connected is false and status.retryCount >= 1
				c.stop
				agenciaConn.close()
				delete window.agenciaConn
				errors = t.errors.get()
				errors.push('Agencia inválida ou indisponível')
				t.errors.set errors


# @AccountFuncionario = new AccountsClient({connection: agenciaFuncionario})
# @AccountCliente = new AccountsClient({connection: agenciaCliente})

# AccountFuncionario.callLoginMethod
# 	methodArguments: [{
# 		user: {username: '00000000000'}
# 		password: Accounts._hashPassword('00000000000')
# 	}]

# Tracker.autorun (c) ->
# 	if AccountFuncionario.userId()?
# 		c.stop()

# 		try agenciaFuncionario.call 'cliente:deletar', {cpf: '22222222222'}
# 		try agenciaFuncionario.call 'conta:deletar', {conta: '1'}
# 		try agenciaFuncionario.call 'conta:deletar', {conta: '2'}

# 		agenciaFuncionario.call 'cliente:cadastrar', {nome: 'Rodrigo Nascimento', cpf: '22222222222'}
# 		agenciaFuncionario.call 'conta:cadastrar', {cpf: '22222222222', conta: '1', senha: '123456'}
# 		agenciaFuncionario.call 'conta:cadastrar', {cpf: '22222222222', conta: '2', senha: '123456'}


# 		Meteor.setTimeout ->
# 			AccountCliente.callLoginMethod
# 				methodArguments: [{
# 					user: {username: '1'}
# 					password: Accounts._hashPassword('123456')
# 				}]

# 			Tracker.autorun (c) ->
# 				if AccountCliente.userId()?
# 					c.stop()

# 					agenciaCliente.call 'depositar', {valor: 120}
# 					agenciaCliente.call 'depositar', {valor: 20}
# 					agenciaCliente.call 'depositar', {valor: 100}

# 					agenciaCliente.call 'sacar', {valor: 40}

# 					agenciaCliente.call 'transferir', {valor: 50, para: {agencia: '1', conta: '2'}}

# 					agenciaCliente.call 'extrato', {}, (err, data) ->
# 						console.log 'conta 1', JSON.stringify(data, null, 2)

# 		, 2000
