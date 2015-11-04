Meteor.methods
	'cliente:cadastrar': (data) ->
		check data, Object

		Validations.cpf data.cpf
		Validations.nome data.nome

		Verifications.naoDeveExistirCpf data.cpf

		clientes.insert
			_id: data.cpf
			nome: data.nome

		return true


	'cliente:listar': ->
		return clientes.find().fetch()


	'cliente:deletar': (data) ->
		check data, Object

		Validations.cpf data.cpf

		Verifications.deveExistirCpf data.cpf

		clientes.remove _id: data.cpf

		return true
