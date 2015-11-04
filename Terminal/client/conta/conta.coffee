Template.conta.onCreated ->
	@extrato = new ReactiveVar
	@carregarSaldo = ->
		agencia.get().call 'extrato', {}, (err, data) =>
			@extrato.set data

	@carregarSaldo()

Template.conta.helpers
	extrato: ->
		return Template.instance().extrato.get()

	conta: ->
		return account?.userId()

Template.conta.events
	'click .logout': ->
		account.logout()

	'click .depositar': (e, t) ->
		swal
			title: 'Depositar'
			text: 'Digite o valor a depositar'
			type: 'input'
			inputType: 'number'
			inputPlaceholder: 'Valor'
			showCancelButton: true
			closeOnConfirm: false
			animation: "slide-from-top"
		, (inputValue) ->
			console.log 1
			agencia.get().call 'depositar', {valor: parseFloat(inputValue)}, (err, data) =>
				if err?
					swal
						type: 'error'
						title: 'Oooops'
						text: err.error
				else
					t.carregarSaldo()
					swal
						type: 'success'
						title: 'Valor depositado'

	'click .sacar': (e, t) ->
		swal
			title: 'Sacar'
			text: 'Digite o valor a sacar'
			type: 'input'
			inputType: 'number'
			inputPlaceholder: 'Valor'
			showCancelButton: true
			closeOnConfirm: false
			animation: "slide-from-top"
		, (inputValue) ->
			console.log 1
			agencia.get().call 'sacar', {valor: parseFloat(inputValue)}, (err, data) =>
				if err?
					swal
						type: 'error'
						title: 'Oooops'
						text: err.error
				else
					t.carregarSaldo()
					swal
						type: 'success'
						title: 'Valor sacado'
