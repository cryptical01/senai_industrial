create database senai_industrial;


use senai_industrial;


create table unidades_senai (
    id_unidade int auto_increment,
    nome_unidade varchar(100) not null,
    cidade varchar(50) not null,
    constraint pk_id_unidade primary key (id_unidade)
);


create table linhas_producao (
    id_linha int auto_increment,
    id_unidade int,
    nome_linha varchar(100),
    constraint pk_id_linha primary key (id_linha),
    constraint fk_id_unidade foreign key (id_unidade)
    references unidades_senai(id_unidade)
);


create table tipos_maquina (
    id_tipo int auto_increment,
    nome_tipo varchar(50),
    horas_revisao_padrao int,
    constraint pk_id_tipo primary key (id_tipo),
    constraint ck_horas_revisao check (horas_revisao_padrao > 0)
);


create table maquinas_senai (
    id_maquina int auto_increment,
    id_linha int,
    id_tipo int,
    tag_patrimonio varchar(30),
    data_aquisicao date,
    status_operacao varchar(20),
    constraint pk_id_maquina primary key (id_maquina),
    constraint fk_id_linha foreign key (id_linha)
    references linhas_producao(id_linha),
    constraint fk_id_tipo foreign key (id_tipo)
    references tipos_maquina(id_tipo),
    constraint uk_tag_patrimonio unique (tag_patrimonio),
    constraint ck_status_operacao check (
        status_operacao in ('ATIVA', 'MANUTENCAO', 'DESATIVADA')
    )
);


create table componentes_maq (
    id_componente int auto_increment,
    id_maquina int,
    nome_componente varchar(100),
    horas_uso_acumulado int,
    limite_horas_alerta int,
    constraint pk_id_componente primary key (id_componente),
    constraint fk_componente_maquina foreign key (id_maquina)
    references maquinas_senai(id_maquina),
    constraint ck_horas_uso check (horas_uso_acumulado >= 0)
);


create table tecnicos (
    id_tecnico int auto_increment,
    nome_tecnico varchar(100),
    especialidade varchar(50),
    nivel_certificacao varchar(30),
    constraint pk_id_tecnico primary key (id_tecnico),
    constraint ck_nivel_certificacao check (
        nivel_certificacao in ('JUNIOR', 'PLENO', 'SENIOR', 'SPECIALIST')
    )
);


create table ordens_servico (
    id_ordem int auto_increment,
    id_maquina int,
    id_tecnico int,
    data_abertura datetime,
    tipo_manutencao varchar(20),
    status_os varchar(20),
    constraint pk_id_ordem primary key (id_ordem),
    constraint fk_ordem_maquina foreign key (id_maquina)
    references maquinas_senai(id_maquina),
    constraint fk_id_tecnico foreign key (id_tecnico)
    references tecnicos(id_tecnico),
    constraint ck_tipo_manutencao check (
        tipo_manutencao in ('PREVENTIVA', 'CORRETIVA', 'PREDITIVA')
    ),
    constraint ck_status_os check (
        status_os in ('ABERTA', 'EM_ANDAMENTO', 'CONCLUIDA', 'CANCELADA')
    )
);


create table estoque_pecas (
    id_peca int auto_increment,
    codigo_part_number varchar(50),
    descricao varchar(150),
    qtd_estoque int,
    preco_unitario decimal(10,2),
    constraint pk_id_peca primary key (id_peca),
    constraint uk_codigo_part_number unique (codigo_part_number),
    constraint ck_qtd_estoque check (qtd_estoque >= 0),
    constraint ck_preco_unitario check (preco_unitario > 0.00)
);


create table pecas_os (
    id_ordem int,
    id_peca int,
    qtd_utilizada int,
    preco_aplicado decimal(10,2),
    constraint pk_pecas_os primary key (id_ordem, id_peca),
    constraint fk_pecas_ordem foreign key (id_ordem)
    references ordens_servico(id_ordem),
    constraint fk_id_peca foreign key (id_peca)
    references estoque_pecas(id_peca),
    constraint ck_qtd_utilizada check (qtd_utilizada > 0)
);


create table historico_sensores (
    id_leitura int auto_increment,
    id_ordem int,
    temperatura_medida decimal(5,2),
    vibracao_mm_s decimal(5,2),
    data_hora_leitura datetime,
    prompt_geracao_ia varchar(100) default 'GERADO_POR_LLM',
    constraint pk_id_leitura primary key (id_leitura),
    constraint fk_historico_ordem foreign key (id_ordem)
    references ordens_servico(id_ordem),
    constraint ck_temperatura check (
        temperatura_medida between -50.00 and 300.00
    )
);