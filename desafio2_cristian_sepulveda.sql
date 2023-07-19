--Creando base de datos
CREATE DATABASE desafio_cristian_sepulveda_333; 

--Creacion y llenado de tabla inscritos si es que esta no existe
CREATE TABLE IF NOT EXISTS INSCRITOS(cantidad INT, fecha DATE, fuente VARCHAR);
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 44, '01/01/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 56, '01/01/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 39, '01/02/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 81, '01/02/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 12, '01/03/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 91, '01/03/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 48, '01/04/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 45, '01/04/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 55, '01/05/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 33, '01/05/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 18, '01/06/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 12, '01/06/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 34, '01/07/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 24, '01/07/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 83, '01/08/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 99, '01/08/2021', 'Página' );

--1 ¿Cuántos registros hay?
select count(*) as "total registros" 
from inscritos;

--2 ¿Cuántos inscritos hay en total?
select sum(cantidad) as "total inscritos" 
from inscritos;

--3 ¿Cuál o cuáles son los registros de mayor antiguedad?
select * 
from inscritos 
where fecha = (select min(fecha) 
			   from inscritos);

--4 ¿Cuántos inscritos hay por día?
select fecha, sum(cantidad) as inscritos 
from inscritos 
group by fecha;

--5 ¿Cuántos inscritos hay por fuente?
select fuente, sum(cantidad) as inscritos 
from inscritos 
group by fuente;

--6 ¿Qué día se inscribió la mayor cantidad de personas? ¿Cuántas personas se inscribieron en ese día?
select fecha, sum(cantidad) as inscritos 
from inscritos 
group by fecha 
having sum(cantidad) = (select suma 
			from (select fecha, sum(cantidad) as suma 
				from inscritos 
				group by fecha) as new_table 
			limit 1);

--7 ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog? ¿Cuántas personas fueron?
select fuente, fecha, cantidad 
from inscritos 
where (fuente = 'Blog') and (cantidad = (select max(cantidad) 
						from inscritos 
						where fuente = 'Blog'));

--8 ¿Cuál es el promedio de personas inscritas por día?
select fecha, avg(cantidad) as "promedio inscritos" 
from inscritos 
group by fecha;

--9 ¿Qué días se inscribieron más de 50 personas?
select fecha, sum(cantidad) as inscritos 
from inscritos 
group by fecha 
having sum(cantidad) > 50;

--10 ¿Cuál es el promedio diario de personas inscritas a partir del tercer día en adelante, considerando únicamente las fechas posteriores o iguales a la indicada?
select fecha, avg(cantidad) as "promedio inscritos"
from inscritos 
group by fecha 
having fecha >= to_date('2021-01-03','YYYY-MM-DD');
