Meteor.methods
	'cliente:cadastrar': (data) ->
		# TODO verificar permissão
		check data, Object

		Validations.cpf data.cpf
		Validations.nome data.nome
		Validations.senha data.senha

		Verifications.naoDeveExistirCpf data.cpf

		Meteor.users.insert
			_id: data.cpf
			username: data.cpf
			role: 'cliente'
			profile:
				nome: data.nome

		Accounts.setPassword data.cpf, data.senha

		return true


	'cliente:listar': ->
		# TODO verificar permissão

		return Meteor.users.find({role: 'client'}).fetch()


	'cliente:deletar': (data) ->
		# TODO verificar permissão
		check data, Object

		Validations.cpf data.cpf

		Verifications.deveExistirCpf data.cpf

		Meteor.users.remove _id: data.cpf

		return true
