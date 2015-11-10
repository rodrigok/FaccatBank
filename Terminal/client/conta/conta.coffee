Template.conta.onCreated ->
	@transferir = new ReactiveVar false
	@extrato = new ReactiveVar
	@carregarSaldo = ->
		agencia.get().call 'extrato', {}, (err, data) =>
			if not showError(err)?
				@extrato.set data

	@carregarSaldo()


Template.conta.helpers
	extrato: ->
		return Template.instance().extrato.get()

	conta: ->
		return account?.userId()

	transferir: ->
		return Template.instance().transferir.get()


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
			agencia.get().call 'depositar', {valor: parseFloat(inputValue)}, (err, data) =>
				if not showError(err)?
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
			agencia.get().call 'sacar', {valor: parseFloat(inputValue)}, (err, data) =>
				if not showError(err)?
					t.carregarSaldo()
					swal
						type: 'success'
						title: 'Valor sacado'

	'click .transferir': (e, t) ->
		t.transferir.set not t.transferir.get()

	'click .cancelar-transferencia': (e, t) ->
		t.transferir.set false

	'submit form': (e, t) ->
		e.preventDefault()
		contaValue = $('#conta').val().trim()
		agenciaValue = $('#agencia').val().trim()
		valorValue = $('#valor').val().trim()

		agencia.get().call 'transferir', {valor: parseFloat(valorValue), para: {agencia: agenciaValue, conta: contaValue}}, (err, data) =>
			if not showError(err)?
				t.carregarSaldo()
				t.transferir.set false
				swal
					type: 'success'
					title: 'Valor transferido'
