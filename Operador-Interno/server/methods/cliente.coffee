Meteor.methods
	'cliente:cadastrar': (nome, cpf, senha) ->
		# TODO verificar permissão

		Validations.cpf cpf
		Validations.nome nome
		Validations.senha senha

		Verifications.naoDeveExistirCpf cpf

		Meteor.users.insert
			_id: cpf
			role: 'client'
			profile:
				nome: nome

		Accounts.setPassword cpf, senha

		return true


	'cliente:listar': ->
		# TODO verificar permissão

		return Meteor.users.find({role: 'client'}).fetch()


	'cliente:deletar': (cpf) ->
		# TODO verificar permissão

		Validations.cpf cpf

		Verifications.deveExistirCpf cpf

		Meteor.users.remove _id: cpf

		return true
