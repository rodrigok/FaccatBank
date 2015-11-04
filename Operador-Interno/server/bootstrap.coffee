Meteor.startup ->
	if not Meteor.users.findOne('00000000000')?
		Meteor.users.insert
			_id: '00000000000'
			username: '00000000000'
			role: 'funcionario'
			profile:
				nome: 'Funcionário Exemplo'

		Accounts.setPassword '00000000000', '00000000000'

	if not Meteor.users.findOne('11111111111')?
		Meteor.users.insert
			_id: '11111111111'
			username: '11111111111'
			role: 'cliente'
			profile:
				nome: 'Cliente Exemplo'

		Accounts.setPassword '11111111111', '11111111111'

	if not agencias.findOne('1')?
		agencias.insert
			_id: '1'
