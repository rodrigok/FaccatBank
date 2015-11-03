clientes = new Meteor.Collection 'clientes'

Meteor.methods
	cadastrarCliente: (nome, cpf) ->
		# TODO verificar permissão

		if not Match.test(nome, String) or not Match.test(cpf, String)
			throw new Meteor.Error 'Os campos "nome" e "cpf" devem ser string'

		if not /^\d{11}$/.test(cpf)
			throw new Meteor.Error 'O campo "cpf" deve conter 11 digitos sem separadores'

		if clientes.findOne(cpf)?
			throw new Meteor.Error 'CPF já cadastrado'

		clientes.insert
			_id: cpf
			nome: nome

		return true


	listarClientes: ->
		# TODO verificar permissão

		return clientes.find().fetch()


	alterarCliente: (cpf, nome) ->
		# TODO verificar permissão

		if not Match.test(nome, String) or not Match.test(cpf, String)
			throw new Meteor.Error 'Os campos "nome" e "cpf" devem ser string'

		if not /^\d{11}$/.test(cpf)
			throw new Meteor.Error 'O campo "cpf" deve conter 11 digitos sem separadores'

		query =
			_id: cpf

		update =
			$set:
				nome: nome

		clientes.update query, update

		return true


	deletarCliente: (cfp) ->
		# TODO verificar permissão

		if not Match.test(cpf, String)
			throw new Meteor.Error 'O campo "cpf" deve ser string'

		if not /^\d{11}$/.test(cpf)
			throw new Meteor.Error 'O campo "cpf" deve conter 11 digitos sem separadores'


		clientes.remove _id: cfp

		return true
