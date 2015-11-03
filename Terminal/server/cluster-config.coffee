console.log process.env.MONGO_URL
Cluster.connect process.env.MONGO_URL
Cluster.register 'terminal'

operadorInterno = Cluster.discoverConnection("operador-interno")

# Dados de teste
try operadorInterno.call 'agencia:deletar', '1'
try operadorInterno.call 'agencia:deletar', '2'
try operadorInterno.call 'agencia:deletar', '3'
try operadorInterno.call 'cliente:deletar', '01700873016'
try operadorInterno.call 'conta:deletar', '1'

operadorInterno.call 'agencia:cadastrar', '1'
operadorInterno.call 'agencia:cadastrar', '2'
operadorInterno.call 'agencia:cadastrar', '3'
operadorInterno.call 'cliente:cadastrar', 'Rodrigo Nascimento', '01700873016'
operadorInterno.call 'conta:cadastrar', '01700873016', '1', '1'
