Cluster.connect process.env.MONGO_URL
Cluster.register 'terminal'

agencia = Cluster.discoverConnection("agencia")

# Dados de teste
try agencia.call 'agencia:deletar', {agencia: '1'}
try agencia.call 'agencia:deletar', {agencia: '2'}
try agencia.call 'agencia:deletar', {agencia: '3'}
try agencia.call 'cliente:deletar', {cpf: '01700873016'}
try agencia.call 'conta:deletar', {conta: '1'}

agencia.call 'agencia:cadastrar', {agencia: '1'}
agencia.call 'agencia:cadastrar', {agencia: '2'}
agencia.call 'agencia:cadastrar', {agencia: '3'}
agencia.call 'cliente:cadastrar', {nome: 'Rodrigo Nascimento', cpf: '01700873016', senha: '123456'}
agencia.call 'conta:cadastrar', {cpf: '01700873016', agencia: '1', conta: '1'}
