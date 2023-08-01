create schema kraft;

set schema 'kraft';

create table fabrica(
	id serial primary key, 
	cod_fabrica varchar(30) not null unique,
	cnpj varchar(14) not null unique,
	endereco varchar(50) null
);


create table fornecedor(
	id serial primary key,
	cnpj varchar(14) not null unique,
	nm_fornecedor varchar(30) null,
	cnae_ramo_atv varchar(7) not null,
	desc_ramo_atv varchar(50)	
);


create table transportadora(
	id serial primary key,
	cnpj varchar(14) not null unique,
	nm_transportadora varchar(50)
);


create table produto(
	id serial primary key,
	ncm varchar(8),
	cod_prod varchar(20),
	desc_prod varchar(50)	
);


create table transporte(
	id serial primary key,
	id_transportadora int4 not null references transportadora(id)
									on delete cascade
									on update cascade,
	litro_combustivel_fosseis decimal(10,3)
);


create table lote(
	id serial primary key,
	cod_lote varchar(20) not null unique,
	id_produto int4 not null references produto(id)
							on delete cascade
							on update cascade,
	dt_ini_prod date not null,
	dt_fim_prod date not null,
	qtd_prod decimal (12,4) not null,
	qtd_desperdicio decimal (12,4) not null,
	qtd_kj decimal (12,4) not null,
	qtd_litro_agua decimal (12,4) not null,
	kg_acucar decimal (12,4) not null,
	kg_sodio decimal (12,4) not null,
	kg_residuos_reciclavel decimal (12,4) not null,
	kg_residuos_n_reciclavel decimal (12,4) not null,
	embalagem_sustentavel bool not null
);



create table fornecimento(
	id serial primary key,
	id_fornecedor int4 not null references fornecedor(id)
								on delete cascade
								on update cascade,
	id_produto int4 not null references produto(id)
							 on delete cascade
							 on update cascade,
	id_transporte int4 not null references transportadora(id)
								on delete cascade
								on update cascade,
	qtd decimal(14,4) not null,
	cod_lote_fornecedor varchar(20) null,
	sustentavel bool not null
);

create table fabricacao(
	id serial primary key,
	id_fabrica int4 not null references fabrica(id)
							 on delete cascade
							 on update cascade,
	id_lote int4 not null references lote(id)
							 on delete cascade
							 on update cascade,
	id_fornecimento int4 not null references fornecimento(id)
							 on delete cascade
							 on update cascade
);