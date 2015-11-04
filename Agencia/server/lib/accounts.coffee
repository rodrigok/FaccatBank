Accounts.validateLoginAttempt (data) ->
	if data.allowed isnt true
		return false

	if data.user.agencia isnt process.env.AGENCIA
		throw new Meteor.Error 'Agencia inválida'

	return true
