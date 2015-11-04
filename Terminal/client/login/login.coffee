Template.login.onCreated ->
	@errors = new ReactiveVar []


Template.login.helpers
	errors: ->
		return Template.instance().errors.get()


Template.login.events
	'submit form': (e, t) ->
		e.preventDefault()

		t.errors.set []

		agenciaValue = $('#agencia').val().trim()
		contaValue = $('#conta').val().trim()
		senhaValue = $('#senha').val().trim()

		localStorage.setItem('agencia', agenciaValue)

		login = ->
			window.account.callLoginMethod
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

		conectarNaAgencia agenciaValue, (success) ->
			if success is true
				login()
			else
				errors = t.errors.get()
				errors.push('Agencia inválida ou indisponível')
				t.errors.set errors



# 		try agenciaFuncionario.call 'cliente:deletar', {cpf: '22222222222'}
# 		try agenciaFuncionario.call 'conta:deletar', {conta: '1'}
# 		try agenciaFuncionario.call 'conta:deletar', {conta: '2'}

# 		agenciaFuncionario.call 'cliente:cadastrar', {nome: 'Rodrigo Nascimento', cpf: '22222222222'}
# 		agenciaFuncionario.call 'conta:cadastrar', {cpf: '22222222222', conta: '1', senha: '123456'}
# 		agenciaFuncionario.call 'conta:cadastrar', {cpf: '22222222222', conta: '2', senha: '123456'}

