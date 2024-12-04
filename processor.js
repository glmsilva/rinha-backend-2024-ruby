const { randomInt, randomBytes } = require('crypto');

const generateRandomClienteId = () => randomInt(1, 6);
const generateRandomValorTransacao = () => randomInt(1, 10001);
const generateRandomDescricao = () => randomBytes(5).toString('hex'); 
const generateRandomTipo = () => ['c', 'd'][randomInt(0,2)]

function generateTransactionData(context, events, done) {
  const descricao = generateRandomDescricao();
  const clienteId = generateRandomClienteId();
  const valor = generateRandomValorTransacao();
  const tipo = generateRandomTipo();

  context.vars.descricao = descricao;
  context.vars.clienteId = clienteId;
  context.vars.payload = JSON.stringify({ valor, tipo, descricao });

  return done();
}

function validateTransactionBalance(response, context, events, done) {
  const saldo = parseInt(response.body.saldo, 10);
  const limite = parseInt(context.vars.limite, 10);

  if (saldo < limite * -1) {
    console.log('Limite ultrapassado!')
  }

  return done();
}

module.exports = {
  generateTransactionData,
  validateTransactionBalance,
};
