

DROP TABLE public.refactoring_item;
DROP TABLE public.execution_control;
DROP TABLE public.commit;
DROP TABLE public.project;


CREATE SEQUENCE public.sq_commit;
-- Table: commit

-- DROP TABLE commit;

CREATE TABLE commit
(
  id_commit numeric(10,0) NOT NULL DEFAULT nextval('sq_commit'::regclass), -- Chave primária da tabela commit. Valor automático e autoincementável.
  commit_sha_key character varying(40) NOT NULL, -- SHA  key do commit sendo analisado
  parent_commit_sha_key character varying(40) NOT NULL, -- Chave SHA do commit pai (commit anterior) ao que está sendo analisado e que fio salvo na coluna commit_sha_key
  commit_date timestamp without time zone NOT NULL, -- Date e hora que o commit foi realizado.
  commit_autor character varying(100) NOT NULL, -- Autor do commit
  commit_author_contact character varying(500) NOT NULL, -- Email de contato com o autor do commit
  commit_message text NOT NULL, -- Armazena a message de commit informada pelo desenvolvedor
  id_project numeric(10,0), -- Chave estrageira para a tabela project
  CONSTRAINT pk_commit PRIMARY KEY (id_commit),
  CONSTRAINT fk_commit_idproject_projc_id_project FOREIGN KEY (id_project)
      REFERENCES project (id_project) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE commit
  OWNER TO vagner;
COMMENT ON TABLE commit
  IS 'Tabela que armeza os commits de determinado projeto';
COMMENT ON COLUMN commit.id_commit IS 'Chave primária da tabela commit. Valor automático e autoincementável.';
COMMENT ON COLUMN commit.commit_sha_key IS 'SHA  key do commit sendo analisado';
COMMENT ON COLUMN commit.parent_commit_sha_key IS 'Chave SHA do commit pai (commit anterior) ao que está sendo analisado e que fio salvo na coluna commit_sha_key';
COMMENT ON COLUMN commit.commit_date IS 'Date e hora que o commit foi realizado.';
COMMENT ON COLUMN commit.commit_autor IS 'Autor do commit';
COMMENT ON COLUMN commit.commit_author_contact IS 'Email de contato com o autor do commit';
COMMENT ON COLUMN commit.commit_message IS 'Armazena a message de commit informada pelo desenvolvedor';
COMMENT ON COLUMN commit.id_project IS 'Chave estrageira para a tabela project';


-- Index: fki_commit_idproject_projc_id_project

-- DROP INDEX fki_commit_idproject_projc_id_project;

CREATE INDEX fki_commit_idproject_projc_id_project
  ON commit
  USING btree
  (id_project);

-- Index: uq_commit_sha_key

-- DROP INDEX uq_commit_sha_key;

CREATE UNIQUE INDEX uq_commit_sha_key
  ON commit
  USING btree
  (commit_sha_key COLLATE pg_catalog."default");





----------------------------------------------------------------------------

CREATE SEQUENCE public.sq_project;

-- Table: project

-- DROP TABLE project;

CREATE TABLE project
(
  id_project numeric(10,0) NOT NULL DEFAULT nextval('sq_project'::regclass),
  code_project numeric(2,0) NOT NULL, -- Código do projeto. Gerado com base sequêncial no número de projetos analisados.
  name_project character varying(100) NOT NULL, -- Nome do projeto github utilizado
  total_commit_project numeric(5,0),
  git_url_project character varying(4000) NOT NULL, -- URL do git utilizada para clonar o projeto.
  total_branch_project numeric(5,0), -- Total de branches que o projecto possui
  total_release_project numeric(5,0), -- Total de realeases do projeto
  total_contributor_project numeric(5,0),
  loc_poject numeric(5,0), -- Numero de linhas ( number of lines) da última versão coletada dos sistema.
  updating_date timestamp without time zone NOT NULL, -- Data de atualização das informações
  CONSTRAINT pk_project PRIMARY KEY (id_project)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE project
  OWNER TO vagner;
COMMENT ON TABLE project
  IS 'Tabela para armarzenar os dados dos projetos do github utilizado no projeto da disciplina';
COMMENT ON COLUMN project.code_project IS 'Código do projeto. Gerado com base sequêncial no número de projetos analisados.';
COMMENT ON COLUMN project.name_project IS 'Nome do projeto github utilizado';
COMMENT ON COLUMN project.git_url_project IS 'URL do git utilizada para clonar o projeto.';
COMMENT ON COLUMN project.total_branch_project IS 'Total de branches que o projecto possui';
COMMENT ON COLUMN project.total_release_project IS 'Total de realeases do projeto';
COMMENT ON COLUMN project.loc_poject IS 'Numero de linhas ( number of lines) da última versão coletada dos sistema.';
COMMENT ON COLUMN project.updating_date IS 'Data de atualização das informações';


-- Index: uq_cod_project

-- DROP INDEX uq_cod_project;

CREATE UNIQUE INDEX uq_cod_project
  ON project
  USING btree
  (code_project);

-- Index: uq_name_project

-- DROP INDEX uq_name_project;

CREATE UNIQUE INDEX uq_name_project
  ON project
  USING btree
  (name_project COLLATE pg_catalog."default");

----------------------------------------------------------------------------
-- Table: execution_control

-- DROP TABLE execution_control;

CREATE TABLE execution_control
(
  id_execution_control numeric(10,0) NOT NULL, -- Chave primária da tabela execution_control. Valor auto-incrementado.
  id_project numeric(10,0) NOT NULL, -- Chave estrangeira (FK) para a tabela project
  seq_sequence numeric(5,0) NOT NULL, -- Sequência de execução de deterimado projeto
  start_time timestamp without time zone, -- Estampa de tempo do início da execução do projeto
  finish_time timestamp without time zone, -- Tempo de finalizado da sequência de execução de determinado projeto
  sucess character(1) NOT NULL DEFAULT 'S'::bpchar, -- Indicativo do sucesso ou não da execução de determinado projeto
  CONSTRAINT pk_execution_control PRIMARY KEY (id_execution_control),
  CONSTRAINT fk_proj_idproject_exectrl_id_project FOREIGN KEY (id_project)
      REFERENCES project (id_project) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE execution_control
  OWNER TO vagner;
COMMENT ON TABLE execution_control
  IS 'Trabalha para controlar a execução da coleta de refactoring de cada projeto analisado';
COMMENT ON COLUMN execution_control.id_execution_control IS 'Chave primária da tabela execution_control. Valor auto-incrementado.';
COMMENT ON COLUMN execution_control.id_project IS 'Chave estrangeira (FK) para a tabela project';
COMMENT ON COLUMN execution_control.seq_sequence IS 'Sequência de execução de deterimado projeto';
COMMENT ON COLUMN execution_control.start_time IS 'Estampa de tempo do início da execução do projeto';
COMMENT ON COLUMN execution_control.finish_time IS 'Tempo de finalizado da sequência de execução de determinado projeto';
COMMENT ON COLUMN execution_control.sucess IS 'Indicativo do sucesso ou não da execução de determinado projeto';


-- Index: uq_id_project_execution_sequence

-- DROP INDEX uq_id_project_execution_sequence;

CREATE UNIQUE INDEX uq_id_project_execution_sequence
  ON execution_control
  USING btree
  (id_project, seq_sequence);


---------------------------------------------------------------------
CREATE SEQUENCE public.sq_refactoring_item;

-- Table: refactoring_item

-- DROP TABLE refactoring_item;

CREATE TABLE refactoring_item
(
  id_refactoring_item numeric(10,0) NOT NULL DEFAULT nextval('sq_refactoring_item'::regclass), -- ṔK da tabela refacotring_item. Número sequência auto-incrementado.
  id_commit numeric(10,0) NOT NULL, -- Chave estrangeira para a tabela commit
  id_execution_control numeric(10,0) NOT NULL, -- FK da tabela execution_control
  refactoring_name character varying(100) NOT NULL, -- Nome do refactoring detectado.
  refactoring_string character varying(3000) NOT NULL,
  update_time timestamp without time zone NOT NULL,
  CONSTRAINT pk_refactoring_item PRIMARY KEY (id_refactoring_item),
  CONSTRAINT commit_refactoring_item_fk FOREIGN KEY (id_commit)
      REFERENCES commit (id_commit) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_execctrl_idexectrl_recitm_idexectrl FOREIGN KEY (id_execution_control)
      REFERENCES execution_control (id_execution_control) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE refactoring_item
  OWNER TO vagner;
COMMENT ON TABLE refactoring_item
  IS 'Tabela para armezar os itens de refactoroings recuperados de determinado projecto';
COMMENT ON COLUMN refactoring_item.id_refactoring_item IS 'ṔK da tabela refacotring_item. Número sequência auto-incrementado.';
COMMENT ON COLUMN refactoring_item.id_commit IS 'Chave estrangeira para a tabela commit';
COMMENT ON COLUMN refactoring_item.id_execution_control IS 'FK da tabela execution_control';
COMMENT ON COLUMN refactoring_item.refactoring_name IS 'Nome do refactoring detectado.';

