Meteor.startup ->
	if not Meteor.users.findOne('00000000000')?
		Meteor.users.insert
			_id: '00000000000'
			username: '00000000000'
			agencia: '1'
			role: 'funcionario'
			profile:
				nome: 'Funcionário Exemplo'

		Accounts.setPassword '00000000000', '00000000000'

	if not agencias.findOne('1')?
		agencias.insert
			_id: '1'
