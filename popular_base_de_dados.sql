use senai_industrial;

insert into unidades_senai (nome_unidade, cidade) values
('senai umuarama', 'umuarama'),
('senai maringa', 'maringa'),
('senai londrina', 'londrina'),
('senai curitiba', 'curitiba'),
('senai cascavel', 'cascavel');

insert into linhas_producao (id_unidade, nome_linha) values
(1, 'usinagem industrial'),
(2, 'montagem mecanica'),
(3, 'soldagem industrial'),
(4, 'automacao industrial'),
(5, 'corte de metais');

insert into tipos_maquina (nome_tipo, horas_revisao_padrao) values
('torno cnc', 500),
('fresadora', 800),
('maquina de solda', 300),
('esteira automatizada', 600),
('prensa hidraulica', 1000);

insert into maquinas_senai (id_linha, id_tipo, tag_patrimonio, data_aquisicao, status_operacao) values
(1, 1, 'pat-001', '2023-02-10', 'ATIVA'),
(2, 2, 'pat-002', '2022-05-15', 'MANUTENCAO'),
(3, 3, 'pat-003', '2024-03-20', 'ATIVA'),
(4, 4, 'pat-004', '2021-08-12', 'DESATIVADA'),
(5, 5, 'pat-005', '2025-01-25', 'ATIVA');

insert into componentes_maq (id_maquina, nome_componente, horas_uso_acumulado, limite_horas_alerta) values
(1, 'motor eletrico', 350, 500),
(2, 'rolamento industrial', 650, 800),
(3, 'transformador', 180, 300),
(4, 'sensor de movimento', 450, 600),
(5, 'cilindro hidraulico', 750, 1000);

insert into tecnicos (nome_tecnico, especialidade, nivel_certificacao) values
('gabriel silva', 'mecanica industrial', 'JUNIOR'),
('pedro santos', 'eletrica industrial', 'PLENO'),
('mariana costa', 'automacao', 'SENIOR'),
('lucas oliveira', 'hidraulica', 'SPECIALIST'),
('rafael souza', 'manutencao industrial', 'PLENO');

insert into ordens_servico (id_maquina, id_tecnico, data_abertura, tipo_manutencao, status_os) values
(1, 1, '2026-11-10 08:00:00', 'PREVENTIVA', 'CONCLUIDA'),
(2, 2, '2026-11-11 09:30:00', 'CORRETIVA', 'EM_ANDAMENTO'),
(3, 3, '2026-11-12 10:15:00', 'PREDITIVA', 'ABERTA'),
(4, 4, '2026-11-13 14:00:00', 'CORRETIVA', 'CANCELADA'),
(5, 5, '2026-11-14 15:45:00', 'PREVENTIVA', 'CONCLUIDA');

insert into estoque_pecas (codigo_part_number, descricao, qtd_estoque, preco_unitario) values
('pn-001', 'motor eletrico industrial', 10, 850.00),
('pn-002', 'rolamento de aco', 35, 120.00),
('pn-003', 'fusivel industrial', 50, 25.00),
('pn-004', 'sensor de temperatura', 15, 180.00),
('pn-005', 'filtro hidraulico', 20, 95.00);

insert into pecas_os (id_ordem, id_peca, qtd_utilizada, preco_aplicado) values
(1, 1, 1, 850.00),
(2, 2, 2, 120.00),
(3, 3, 3, 25.00),
(1, 4, 1, 180.00),
(5, 5, 2, 95.00);

insert into historico_sensores (id_ordem, temperatura_medida, vibracao_mm_s, data_hora_leitura) values
(1, 65.50, 2.30, '2026-11-10 08:30:00'),
(2, 82.40, 4.80, '2026-11-11 10:00:00'),
(3, 45.20, 1.50, '2026-11-12 11:30:00'),
(4, 28.00, 0.00, '2026-11-13 14:30:00'),
(5, 72.80, 3.20, '2026-11-14 16:00:00');