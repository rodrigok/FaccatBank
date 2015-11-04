@agencia = new ReactiveVar

@conectarNaAgencia = (agenciaValue, cb) ->
	window.agenciaConn = Cluster.discoverConnection("agencia#{agenciaValue}")
	window.account = new AccountsClient({connection: window.agenciaConn})
	Tracker.autorun (c) ->
		if not window.agenciaConn?
			c.stop()
			return

		status = window.agenciaConn.status()
		if status.connected is true
			c.stop()
			agencia.set window.agenciaConn
			cb?(true)

		if status.connected is false and status.retryCount >= 1
			c.stop()
			window.agenciaConn.close()
			delete window.agenciaConn
			cb?(false)


if localStorage.getItem('agencia')
	conectarNaAgencia localStorage.getItem('agencia')
