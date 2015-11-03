if not process.env.AGENCIA?
	console.log 'Variável de ambiente não econtrada "AGENCIA"'
	process.exit(0)

Cluster.connect process.env.MONGO_URL
Cluster.register "agencia-#{process.env.AGENCIA}"
