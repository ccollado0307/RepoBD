use CFL2020_data;

-- Ejercicios de Clase 
select e01_cliente.nombre, e01_cliente.apellido, e01_telefono.nro_telefono
from e01_cliente 
inner join e01_telefono 
on e01_cliente.nro_cliente = e01_telefono.nro_cliente
where e01_cliente.nombre = 'Xerxes';

select c.nombre, c.apellido, t.nro_telefono
from e01_cliente c
inner join e01_telefono t 
on c.nro_cliente = t.nro_cliente
where c.nombre = 'Xerxes';

select distinct c.*, f.*
from e01_cliente c
left join  e01_factura f 
on (c.nro_cliente = f.nro_cliente);

select distinct f.*, c.*
from e01_factura f
right join e01_cliente c  
on (c.nro_cliente = f.nro_cliente);

select distinct c.*
from e01_cliente c
left join  e01_factura f 
on (c.nro_cliente = f.nro_cliente)
where f.nro_cliente is null;

select distinct c.*, f.*
from e01_cliente c
left join  e01_factura f 
on (c.nro_cliente = f.nro_cliente)
where f.nro_cliente is not null;

select distinct c.*,
case when f.nro_factura is null then 'no tiene fact'
else 'tiene factura'
end as factura
from e01_cliente c
left join  e01_factura f 
on (c.nro_cliente = f.nro_cliente); 

-- 1.Mostrar cada teléfono junto con los datos del cliente.
select telefono.*, cliente.*
from e01_telefono telefono
inner join e01_cliente cliente 
on telefono.nro_cliente = cliente.nro_cliente
order by telefono.codigo_area;

-- 2.Mostrar todos los teléfonos del cliente número 30 junto con todos sus datos personales.
select cliente.*, telefono.codigo_area, telefono.nro_telefono, telefono.tipo
from e01_cliente cliente 
inner join e01_telefono telefono 
on cliente.nro_cliente = telefono.nro_cliente 
where cliente.nro_cliente = 30
order by telefono.codigo_area;

-- 3.Mostrar nombre y apellido de cada cliente junto con lo que gastó en total (con iva incluido).
select cliente.nombre, cliente.apellido, factura.total_con_iva
from e01_cliente cliente 
inner join e01_factura factura 
on cliente.nro_cliente = factura.nro_cliente 
order by cliente.apellido;

-- 4.Listar todas las facturas que hayan sido compradas por el cliente de nombre "Pandora" y apellido "Tate".
select distinct factura.*
from e01_factura factura
right join e01_cliente cliente  
on (cliente.nro_cliente = factura.nro_cliente)
where cliente.nombre = 'Pandora' and cliente.apellido = 'Tate';

-- 5.Listar todas las Facturas que contengan productos de la marca "In Faucibus Inc."
select fact.* 
from e01_factura fact
inner join e01_detalle_factura detFact 
on (fact.nro_factura = detFact.nro_factura)
inner join e01_producto prod
on (detFact.codigo_producto = prod.codigo_producto)
where marca = 'In Faucibus Inc.';

-- 6.listar todos los clientes que tengan código de área 296
-- RESULTADO = 2
select cte.*, tel.codigo_area
from e01_cliente cte 
inner join e01_telefono tel
on cte.nro_cliente = tel.nro_cliente 
where tel.codigo_area = 296;

-- 7.mostrarme todos los clientes que compraron el producto cuyo nombre = 'scales' 
-- RESULTADO 18
select c.*
from e01_cliente c
inner join e01_factura f
on f.nro_cliente = c.nro_cliente
inner join e01_detalle_factura df
on df.nro_factura = f.nro_factura
inner join e01_producto p
on p.codigo_producto = df.codigo_producto
where p.nombre = 'scales';

-- 8.mostrar los códigos de área de los clientes del punto anterior
-- RESULTADO = 30
select distinct c.*, t.codigo_area
from e01_telefono t
inner join e01_cliente c
on t.nro_cliente = c.nro_cliente
	inner join e01_factura f
	on f.nro_cliente = c.nro_cliente
		inner join e01_detalle_factura df
		on df.nro_factura = f.nro_factura
			inner join e01_producto p
			on p.codigo_producto = df.codigo_producto
			where p.nombre = 'scales';
            
-- 9. Mostrar los clientes sin teléfonos
-- RESULTADO = 16
select distinct c.*
from e01_cliente c
	left join  e01_telefono t 
	on (c.nro_cliente = t.nro_cliente)
	where t.nro_cliente is null;

-- 10. Mostrar los código de teléfono de los clientes que no tienen facturas
-- RESULTADO = 5
select distinct c.*, t.codigo_area
from e01_telefono t 
	left join  e01_cliente c
	on (c.nro_cliente = t.nro_cliente)
		left join e01_factura f
        on (c.nro_cliente = f.nro_cliente)
		where f.nro_cliente is null;	

-- 11. Mostrar las facturas que no tienen productos asociados
-- RESULTADO = 126
select distinct f.*, df.codigo_producto, df.cantidad
from e01_factura f
	left join  e01_detalle_factura df
	on (f.nro_factura = df.nro_factura)
		left join e01_producto p
        on (df.codigo_producto = p.codigo_producto)
		where p.codigo_producto is null;	
        
-- Mostrar los clientes que tienen facturas sin productos
-- RESULTADO = 128
select c.*, f.nro_factura, p.codigo_producto
from e01_cliente c
left join e01_factura f
on (c.nro_cliente = f.nro_cliente)
		left join  e01_detalle_factura df
		on (f.nro_factura = df.nro_factura)
			left join e01_producto p
			on (df.codigo_producto = p.codigo_producto)
			where p.codigo_producto is null;
