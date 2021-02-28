SELECT * FROM equipment_failure_sensors;
SELECT * FROM equipment_sensors;
SELECT * FROM equipment;

/* LETRA A */

/* o where realiza o filtro pela data */
SELECT Count(sensor_id) FROM equipment_failure_sensors WHERE date BETWEEN '2020-01-01' 
   AND '2020-02-01'  ;



/* LETRA B */

/* para saber qual equipamento obteve mais erros, precisamos relacionar a tabela equipamento a tabela failure. 
Observar quantas falhas cada sensor teve e qual equipamento está conectado a mais sensores */

/*Criando nova tabela com sensor_id e numero total de falhas */
SELECT sensor_id, sum(1) as Falhas INTO equipment_failure_sensors_total
FROM equipment_failure_sensors WHERE date BETWEEN '2020-01-01' AND '2020-02-01' 
GROUP BY sensor_id order by sum(1) asc;

/*Criando nova tabela com sensor_id e numero total de falhas */
SELECT sensor_id, Falhas from equipment_failure_sensors_total order by Falhas asc;

/*unindo tabelas de forma que as chaves relacionadas da tabela intermediárias estejam conectadas para observar quantidade de falha por equipamento*/
SELECT TOP 1 equipment.code, sum(equipment_failure_sensors_total.Falhas) as Falhas FROM equipment 
INNER JOIN equipment_sensors
	on equipment.equipment_id=equipment_sensors.equipment_id
INNER JOIN equipment_failure_sensors_total
	on equipment_failure_sensors_total.sensor_id=equipment_sensors.sensor_id GROUP BY equipment.code
order by Falhas desc;

SELECT equipment.code, sum(equipment_failure_sensors_total.Falhas) as Falhas FROM equipment 
FULL OUTER JOIN equipment_sensors
	on equipment.equipment_id=equipment_sensors.equipment_id
INNER JOIN equipment_failure_sensors_total
	on equipment_failure_sensors_total.sensor_id=equipment_sensors.sensor_id GROUP BY equipment.code
order by Falhas desc;

/* LETRA C */


SELECT equipment.group_name, sum(equipment_failure_sensors_total.Falhas)/count(equipment.equipment_id) as Falhas_Medias_por_sensor FROM equipment 
FULL OUTER JOIN equipment_sensors
	on equipment.equipment_id=equipment_sensors.equipment_id
INNER JOIN  equipment_failure_sensors_total
	on equipment_failure_sensors_total.sensor_id=equipment_sensors.sensor_id GROUP BY equipment.group_name
order by Falhas_Medias_por_sensor asc;
