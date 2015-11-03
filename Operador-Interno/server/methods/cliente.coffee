Meteor.methods
	'cliente:cadastrar': (nome, cpf) ->
		# TODO verificar permissão

		Validations.cpf cpf
		Validations.nome nome

		Verifications.naoDeveExistirCpf cpf

		clientes.insert
			_id: cpf
			nome: nome

		return true


	'cliente:listar': ->
		# TODO verificar permissão

		return clientes.find().fetch()


	'cliente:alterar': (cpf, nome) ->
		# TODO verificar permissão

		Validations.cpf cpf
		Validations.nome nome

		Verifications.deveExistirCpf cpf

		query =
			_id: cpf

		update =
			$set:
				nome: nome

		clientes.update query, update

		return true


	'cliente:deletar': (cpf) ->
		# TODO verificar permissão

		Validations.cpf cpf

		Verifications.deveExistirCpf cpf

		clientes.remove _id: cpf

		return true
