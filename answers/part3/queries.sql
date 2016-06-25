-- Questão I 
-- "Retornar número e nome do projeto que começaram entre 2001 e 2010 e tiveram seu fim após 2011."
-- π codProj, nomeProj (σ(anoInicio >= 2001 AND anoInicio <= 2010 AND anoFim > 2011)(Projeto))
SELECT codProj, nomeProj FROM Projeto WHERE 
	(anoInicio BETWEEN 2001 AND 2010) AND (anoFim > 2011);

-- Questão II
-- "Retornar numero do cartão e nome da pessoa junto com o nome do curso que está associado a ela para toda pessoa do sexo feminino que está no curso cujo ID é 1, 2 ou 3."
-- Obs: o "IN" é convertido pelo SGBD para uma série de ORs, portanto a query é válida.
-- (a) Usando Join
-- π(p.numeroCartao, p.nomePess, c.nomeCurso)(σ(p.sexo = 'F' AND (c.codCurso = 1 OR c.codCurso = 2 OR c.codCurso = 3))(ρ p (Pessoa) ⋈(c.codCurso = p.codCurso) ρ c(Curso)))
SELECT p.numeroCartao, p.nomePess, c.nomeCurso FROM Pessoa p
	INNER JOIN Curso c ON c.codCurso = p.codCurso
	WHERE (p.sexo = 'F') AND (c.codCurso IN (1, 2, 3));


-- (b) Usando produto cartesiano
-- π(p.numeroCartao, p.nomePess, c.nomeCurso)(σ(p.sexo = 'F' AND (c.codCurso = 1 OR c.codCurso = 2 OR c.codCurso = 3) AND(c.codCurso = p.codCurso))(ρ p (Pessoa) X ρ c(Curso)))
SELECT p.numeroCartao, p.nomePess, c.nomeCurso FROM Pessoa p , Curso c
	WHERE (c.codCurso = p.codCurso) AND
		  (p.sexo = 'F') AND
		  (c.codCurso IN (1, 2, 3));


-- Questão III
-- Retornar o nome do projeto e sua quantidade de membros ("Membros" do sexo masculino e em projetos que começaram depois de 2004).
-- π tit.nomeProj, G(count(tit.papelPessProj))
--	(π p.nomePess, pp.papelPessProj, proj.nomeProj
--		σ (p.sexo = 'M' AND pp.papelPessProj = 'Membro' AND proj.anoInicio > 2004) 
--		((ρ p (Pessoa) ⋈(p.numeroCartao = pp.numeroCartao) ρ pp (projetoPessoa))
--		⋈ (pp.codProj = proj.codProj) (ρ proj (Projeto)))
--	)
SELECT tit.nomeProj, COUNT(tit.papelPessProj)
	FROM 
	(
		SELECT p.nomePess, pp.PapelPessProj, proj.nomeProj
		FROM Pessoa p JOIN projetoPessoa pp ON p.numeroCartao = pp.numeroCartao
		JOIN Projeto proj ON pp.codProj = proj.codProj
		WHERE p.sexo = 'M' AND pp.papelPessProj = 'Membro' AND proj.anoInicio > 2004
	) as tit
GROUP BY tit.nomeProj
ORDER BY tit.nomeProj;

-- Questão IV
-- "Selecionar o código do projeto, nome do projeto e quantidade de pessoas do sexo masculino que estudam no curso 'Blabla' e estão associadas a esse projeto. Ordenar pelo nome do projeto em ordem crescente."
SELECT proj.codProj, proj.nomeProj, COUNT(pj.codProj) FROM Pessoa p
	INNER JOIN Curso c ON c.codCurso = p.codCurso
	INNER JOIN ProjetoPessoa pj ON pj.NumeroCartao = p.numeroCartao
	INNER JOIN Projeto proj ON proj.codProj = pj.codProj
	WHERE (c.nomeCurso = 'Ciencias da Computacao') AND (p.sexo = 'M')
	GROUP BY proj.codProj, proj.nomeProj
	ORDER BY proj.nomeProj ASC;

-- Questão V
-- "Quantidade de pessoas do sexo Feminino que trabalham como 'Membro' em cada projeto, desde que o número de mulheres trabalhando nesse projeto seja maior do que 2."
SELECT proj.nomeProj, COUNT(pj.codProj) FROM Pessoa p
	INNER JOIN ProjetoPessoa pj ON pj.NumeroCartao = p.numeroCartao
	INNER JOIN Projeto proj ON proj.codProj = pj.codProj
	WHERE (p.sexo = 'F') AND
		  (pj.papelPessProj = 'Membro')
	GROUP BY proj.codProj
	HAVING COUNT(pj.codProj) > 1;