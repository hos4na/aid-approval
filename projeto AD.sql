---GRUPO: HOSANA BARCELOS, ISABELE MOREIRA E RIAN BAHIENSE
---ESTA ÁRVORE DECIDE SOBRE A APROVAÇÃO OU REPROVAÇÃO DO AUXíLIO EMERGENCIAL 
---ATRIBUTOS PREDITIVOS: RENDA FAMILIAR MENSAL E TRABALHADOR AUTÔNOMO/DESEMPREGADO/EMPREGADO
---ATRIBUTO OBJETIVO: AUXÍLIO EMERGENCIAL 
---ATRIBUTO DICOTÔMICO: IDADE 

CREATE TABLE cidadao(
ID SERIAL PRIMARY KEY,
nome VARCHAR(30),
renda integer,
idade integer,
trabalho VARCHAR(20)
);

INSERT INTO cidadao (nome, renda, idade, trabalho) VALUES
('Desiree Dammarell', 1392, 47, 'Autonomo'),
('Karilynn Insley', 1087, 37, 'Autonomo'),
('Seamus Crayker', 2444, 37, 'Desempregado'),
('Dallas Buxcey', 3048, 40, 'Autonomo'),
('Cherida MacNeilley', 2839, 59, 'Autonomo'),
('Leigh Ubee', 950, 39, 'Empregado'),
('Xerxes Andrich', 1675, 46, 'Desempregado'),
('Fleming Kenchington', 3326, 25, 'Autonomo'),
('Betteanne Burberry', 3645, 32, 'Empregado'),
('Faulkner Humbert', 2484, 48, 'Autonomo'),
('Glendon Binford', 4172, 57, 'Desempregado'),
('Adelina Hassey', 3395, 58, 'Desempregado'),
('Tommy Croxall', 2664, 35, 'Empregado'),
('Fax Cornuau', 867, 28, 'Autonomo'),
('Filmore Scarman', 2624, 59, 'Autonomo'),
('Cordy Colicot', 1346, 43, 'Desempregado'),
('Tedra Pethick', 1695, 31, 'Empregado'),
('Lorianne Graffin', 2773, 55, 'Empregado'),
('Verile Thorp', 2464, 50, 'Desempregado'),
('Jemmie O''Hara', 2732, 51, 'Autonomo'),
('Annetta Durbyn', 1157, 24, 'Empregado'),
('Web McCray', 4290, 45, 'Desempregado'),
('Elna Pantin', 2444, 53, 'Autonomo'),
('Krystyna Finlow', 4270, 23, 'Empregado'),
('Artair Brede', 1499, 58, 'Desempregado'),
('Timofei Meredith', 1918, 50, 'Desempregado'),
('Kore Clamp', 2157, 16, 'Empregado'),
('Quinta Thowes', 2939, 38, 'Autonomo'),
('Ferrel Padgett', 2936, 38, 'Desempregado'),
('Carmelle Shobrook', 4103, 19, 'Autonomo');

create or replace function test(p_renda integer, p_idade integer, p_trabalho varchar(20))
returns varchar(30) as
$$
declare
v_renda integer;
v_idade integer;
v_trabalho varchar(20);

begin
v_renda := p_renda;
v_idade := p_idade;
v_trabalho := p_trabalho;

if v_renda <= 3135 and v_trabalho = 'Desempregado' or v_trabalho = 'Autonomo' then
return 'Auxilio Aprovado';
else
if v_renda <= 3135 and v_trabalho = 'Desempregado' and v_idade >= 18 then
return 'Auxilio Aprovado';
else
if v_renda >= 3135 and v_trabalho = 'Desempregado' then
return 'Auxilio Reprovado';
else
if v_renda <= 3135 and v_idade < 18 then
return 'Auxilio Reprovado';
else
return 'Auxilio Reprovado';
end if;
end if;
end if;
end if;
end;
$$
language PLPGSQL;

create view vw_auxilio as
select nome,renda,idade,trabalho, test(renda,idade,trabalho)
from cidadao;

select count (*), test
from vw_auxilio
group by test;

select * from vw_auxilio;

select test(3100, 27,'Autonomo');
select test(3300, 19, 'Empregado');
select test(2000, 45, 'Desempregado');