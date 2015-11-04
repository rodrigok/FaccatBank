Template.funcionario.onCreated ->
	@cadastrarCliente = new ReactiveVar false
	@cadastrarConta = new ReactiveVar false

	@clientes = new ReactiveVar
	@carregarClientes = ->
		agencia.get().call 'cliente:listar', {}, (err, data) =>
			@clientes.set data

	@carregarClientes()

	@contas = new ReactiveVar
	@carregarContas = ->
		agencia.get().call 'conta:listar', {}, (err, data) =>
			@contas.set data

	@carregarContas()


Template.funcionario.helpers
	clientes: ->
		return Template.instance().clientes.get()

	contas: ->
		return Template.instance().contas.get()

	conta: ->
		return account?.userId()

	cadastrarConta: ->
		return Template.instance().cadastrarConta.get()

	cadastrarCliente: ->
		return Template.instance().cadastrarCliente.get()

Template.funcionario.events
	'click .logout': ->
		account.logout()

	'click a.cadastrarConta': (e, t) ->
		t.cadastrarConta.set not t.cadastrarConta.get()

	'click a.cadastrarCliente': (e, t) ->
		t.cadastrarCliente.set not t.cadastrarCliente.get()

	'click .cancelar-conta': (e, t) ->
		t.cadastrarConta.set false

	'click .cancelar-cliente': (e, t) ->
		t.cadastrarCliente.set false

	'submit form.cadastrarCliente': (e, t) ->
		e.preventDefault()
		cpfValue = t.$('#cpf').val().trim()
		nomeValue = t.$('#nome').val().trim()

		agencia.get().call 'cliente:cadastrar', {nome: nomeValue, cpf: cpfValue}, (err, data) =>
			if err?
				swal
					type: 'error'
					title: 'Oooops'
					text: err.error
			else
				t.carregarClientes()
				t.cadastrarCliente.set false
				swal
					type: 'success'
					title: 'Cliente cadastrado'

	'submit form.cadastrarConta': (e, t) ->
		e.preventDefault()
		cpfValue = t.$('#cpf').val().trim()
		contaValue = t.$('#conta').val().trim()
		senhaValue = t.$('#senha').val().trim()

		agencia.get().call 'conta:cadastrar', {cpf: cpfValue, conta: contaValue, senha: senhaValue}, (err, data) =>
			if err?
				swal
					type: 'error'
					title: 'Oooops'
					text: err.error
			else
				t.carregarContas()
				t.cadastrarConta.set false
				swal
					type: 'success'
					title: 'Conta cadastrada'

	'click .apagar-conta': (e, t) ->
		swal
			type: 'warning'
			title: "Deseja apagar a conta #{this._id}?"
			closeOnConfirm: false
			showCancelButton: true,
		, =>
			agencia.get().call 'conta:deletar', {conta: this._id}, (err, data) =>
				if err?
					swal
						type: 'error'
						title: 'Oooops'
						text: err.error
				else
					t.carregarContas()
					t.cadastrarConta.set false
					swal
						type: 'success'
						title: 'Conta apagada'

	'click .apagar-cliente': (e, t) ->
		swal
			type: 'warning'
			title: "Deseja apagar o cliente #{this.nome}?"
			closeOnConfirm: false
			showCancelButton: true,
		, =>
			agencia.get().call 'cliente:deletar', {cpf: this._id}, (err, data) =>
				if err?
					swal
						type: 'error'
						title: 'Oooops'
						text: err.error
				else
					t.carregarClientes()
					t.cadastrarCliente.set false
					swal
						type: 'success'
						title: 'Cliente apagado'
