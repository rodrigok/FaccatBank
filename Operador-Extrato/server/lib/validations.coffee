@Validations =
	cpf: (cpf) ->
		if not Match.test(cpf, String)
			throw new Meteor.Error 'O campo "cpf" deve ser string'

		if not /^\d{11}$/.test(cpf)
			throw new Meteor.Error 'O campo "cpf" deve conter 11 digitos sem separadores'

	senha: (senha) ->
		if not Match.test(senha, String)
			throw new Meteor.Error 'O campo "senha" deve ser string'

		if not /^.{6,}$/.test(senha)
			throw new Meteor.Error 'O campo "senha" deve conter 6 ou mais digitos'

	nome: (nome) ->
		if not Match.test(nome, String)
			throw new Meteor.Error 'O campo "nome" deve ser string'

	agencia: (agencia) ->
		if not Match.test(agencia, String)
			throw new Meteor.Error 'O campo "agencia" deve ser string'

	conta: (conta) ->
		if not Match.test(conta, String)
			throw new Meteor.Error 'O campo "conta" deve ser string'

	valor: (valor) ->
		if not Match.test(valor, Number) or Number.isNaN(valor)
			throw new Meteor.Error 'O campo "valor" deve ser numérico'

		if valor <= 0
			throw new Meteor.Error 'O campo "valor" deve ser maior que 0'


@Verifications =
	deveExistirCpf: (cpf) ->
		record = clientes.findOne(cpf)
		if not record?
			throw new Meteor.Error "Cliente não encontrado"

		return record

	deveExistirAgencia: (agencia) ->
		record = agencias.findOne(agencia)
		if not record?
			throw new Meteor.Error "Agencia não encontrada"

		return record

	deveExistirConta: (conta) ->
		record = Meteor.users.findOne(conta)
		if not record?
			throw new Meteor.Error "Conta não encontrada"

		return record



	naoDeveExistirCpf: (cpf) ->
		record = clientes.findOne(cpf)
		if record?
			throw new Meteor.Error "Cliente já cadastrado"

		return record

	naoDeveExistirAgencia: (agencia) ->
		record = agencias.findOne(agencia)
		if record?
			throw new Meteor.Error "Agencia já cadastrada"

		return record

	naoDeveExistirConta: (conta) ->
		record = Meteor.users.findOne(conta)
		if record?
			throw new Meteor.Error "Conta já cadastrada"

		return record

	temSaldoParaSaque: (conta, valor) ->
		if not Match.test(valor, Number) or Number.isNaN(valor)
			throw new Meteor.Error 'O campo "valor" deve ser numérico'

		record = Meteor.users.findOne(conta)
		if not record?
			throw new Meteor.Error "Conta não encontrada"

		saldo = record.saldo
		if saldo < valor
			throw new Meteor.Error 'Conta não possui saldo suficiente'

		return saldo
