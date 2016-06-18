-- Questão I 
-- "Retornar número e nome do projeto que começaram entre 2010 e 2014 e tiveram seu fim após 2015."
SELECT codProj, nomeProj FROM Projeto WHERE 
	(anoInicio BETWEEN 2010 AND 2014) AND (anoFim > 2015);

-- Questão II (será que usamos IN mesmo?)
-- "Retornar numero do cartão e nome da pessoa junto com o nome do curso que está associado a ela para toda pessoa do sexo feminino que está no curso cujo ID é 1, 2 ou 3."
-- Obs: o "IN" é convertido pelo SGBD para uma série de ORs, portanto a query é válida.
-- (a) Usando Join
SELECT p.numeroCartao, p.nomePess, c.nomeCurso FROM Pessoa p
	INNER JOIN Curso c ON c.codCurso = p.codCurso
	WHERE (p.sexo = 'F') AND (c.codCurso IN (1, 2, 3));

-- (b) Usando produto cartesiano
SELECT p.numeroCartao, p.nomePess, c.nomeCurso FROM Pessoa p , Curso c
	WHERE (c.codCurso = p.codCurso) AND
		  (p.sexo = 'F') AND
		  (c.codCurso IN (1, 2, 3));

-- Questão III (tem um hackzinho, será que dá pra deixar assim?)
-- "Retornar número do cartão e nome das pessoas que estão relacionadas a um projeto que começou entre 2010 e 2015 tem o papel de 'Membro'."
SELECT p.nomePess, pj. , proj.nomeProj,count(codProj) FROM ProjetoPessoa pj
	INNER JOIN Pessoa p ON p.numeroCartao = pj.NumeroCartao
	INNER JOIN Projeto proj ON proj.codProj = pj.codProj
	WHERE (p.sexo = 'M') AND
		(proj.anoInicio BETWEEN 2010 AND 2015) AND 
		(proj.anoFim = 2014)
	GROUP BY ;

-- Questão IV (errado pq acessa 4 tabelas?)(Emmanuel: Acho que sim, talvez retirar a tabela curso e fazer um where em relação ao papel da pessoa no projeto.)
-- "Selecionar o código do projeto, nome do projeto e quantidade de pessoas do sexo masculino que estudam no curso 'Blabla' e estão associadas a esse projeto. Ordenar pelo nome do projeto em ordem crescente."
SELECT proj.codProj, proj.nomeProj, COUNT(proj.codProj) FROM Pessoa p
	INNER JOIN Curso c ON c.codCurso = p.codCurso
	INNER JOIN ProjetoPessoa pj ON pj.NumeroCartao = p.numeroCartao
	INNER JOIN Projeto proj ON proj.codProj = pj.codProj
	WHERE (c.nomeCurso = 'Ciencias da Computacao') AND (p.sexo = 'M')
	GROUP BY proj.codProj, proj.nomeProj
	ORDER BY proj.nomeProj ASC

-- Questão V
-- "Quantidade de pessoas do sexo feminino que trabalham como 'Membro' em cada projeto, desde que o número de mulheres trabalhando nesse projeto seja maior do que 2."
SELECT proj.codProj, COUNT(proj.codProj) FROM Pessoa p
	INNER JOIN ProjetoPessoa pj ON pj.NumeroCartao = p.numeroCartao
	INNER JOIN Projeto proj ON proj.codProj = pj.codProj
	WHERE (p.sexo = 'F') AND
		  (pj.papelPessProj = 'Membro')
	GROUP BY proj.codProj
	HAVING COUNT(proj.codProj) > 2;

-- Ideias: 
-- 		Porcentagem de pessoas do sexo feminino que faz cursos
-- 

-- Sobrando
SELECT p.numeroCartao, p.nomePess FROM Pessoa p
	INNER JOIN ProjetoPessoa pj ON pj.NumeroCartao = p.numeroCartao
	INNER JOIN Projeto ON Projeto.codProj = pj.codProj
	WHERE (pj.papelPessProj = 'Membro') AND (Projeto.anoInicio BETWEEN 2010 AND 2015);
