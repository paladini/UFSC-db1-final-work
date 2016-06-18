CREATE TABLE Pessoa(
	numeroCartao integer NOT NULL,
	nomePess varchar(40),
	sexo char(1) CHECK (sexo in ('M', 'F')),
	emailPref varchar(40),
	codCurso integer
	--CONSTRAINT fk_curso FOREIGN KEY codCurso REFERENCES curso(codCurso)
);
CREATE TABLE OutroEmail (
	numeroCartao integer NOT NULL,
	email varchar(40)
);
CREATE TABLE Curso(
	codCurso integer NOT NULL,
	nomeCurso varchar(40)
);
CREATE TABLE Projeto(
	codProj integer NOT NULL,
	nomeProj varchar(40),
	anoInicio date,
	anoFim date,
	codProjAnte integer
	--CodProjAnte FK
);
CREATE TABLE ProjetoPessoa(
	codProj integer NOT NULL,
	numeroCartao integer NOT NULL,
	papelPessProj varchar(10) CHECK (papelPessProj in ('Líder', 'Membro', 'Bolsista'))
);
ALTER TABLE Curso
	ADD CONSTRAINT pk_codCurso PRIMARY KEY (codCurso);

ALTER TABLE Pessoa
	ADD CONSTRAINT pk_pessoa PRIMARY KEY (numeroCartao),
	ADD CONSTRAINT matricula FOREIGN KEY (codCurso) REFERENCES Curso(codCurso);

ALTER TABLE OutroEmail
	ADD CONSTRAINT pk_numC PRIMARY KEY (numeroCartao, email),
	ADD CONSTRAINT fk_numC FOREIGN KEY (numeroCartao) REFERENCES Pessoa(numeroCartao);



ALTER TABLE Projeto
	ADD CONSTRAINT pk_codProj PRIMARY KEY (codProj),
	ADD CONSTRAINT fk_codProjAnte FOREIGN KEY (codProjAnte) REFERENCES Projeto(codProj);

ALTER TABLE ProjetoPessoa
	ADD CONSTRAINT pk_ProjetoPess PRIMARY KEY (codProj, numeroCartao),
	ADD CONSTRAINT fk_codProj_ProjPess FOREIGN KEY (codProj) REFERENCES Projeto(codProj),
	ADD CONSTRAINT fk_numC_ProjPess FOREIGN KEY (numeroCartao) REFERENCES Pessoa(numeroCartao);
