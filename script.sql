CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    saldo BIGINT NOT NULL DEFAULT 0,
    limite BIGINT NOT NULL,
    CONSTRAINT chk_saldo CHECK (saldo > -limite)
);

CREATE TYPE tipo AS ENUM ('c', 'd');

CREATE TABLE transacoes(
    id SERIAL PRIMARy KEY,
    cliente_id INT REFERENCES clientes(id),
    valor BIGINT NOT NULL,
    tipo tipo NOT NULL,
    descricao VARCHAR(10),
    realizada_em TIMESTAMP
);

    DO $$
BEGIN
INSERT INTO clientes (nome, limite)
VALUES
    ('o barato sai caro', 1000 * 100),
    ('zan corp ltda', 800 * 100),
    ('les cruders', 10000 * 100),
    ('padaria joia de cocaia', 100000 * 100),
    ('kid mais', 5000 * 100);
END; $$