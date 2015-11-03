@Validations =
	cpf: (cpf) ->
		if not Match.test(cpf, String)
			throw new Meteor.Error 'O campo "cpf" deve ser string'

		if not /^\d{11}$/.test(cpf)
			throw new Meteor.Error 'O campo "cpf" deve conter 11 digitos sem separadores'

	nome: (nome) ->
		if not Match.test(nome, String)
			throw new Meteor.Error 'O campo "nome" deve ser string'

	agencia: (agencia) ->
		if not Match.test(agencia, String)
			throw new Meteor.Error 'O campo "agencia" deve ser string'

	conta: (conta) ->
		if not Match.test(conta, String)
			throw new Meteor.Error 'O campo "conta" deve ser string'


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
		record = contas.findOne(conta)
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
		record = contas.findOne(conta)
		if record?
			throw new Meteor.Error "Conta já cadastrada"

		return record
