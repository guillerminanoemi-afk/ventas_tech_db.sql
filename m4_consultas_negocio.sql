
Consulta 1

SELECT MONTH (fecha_venta) AS mes, SUM(cantidad * precio_unitario) AS total_facturado, COUNT (*) AS cantidad_pedidos, SUM(cantidad * precio_unitario) / COUNT (*) ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);

Consulta 2

SELECT TOP 5 id_producto, SUM(cantidad * precio_unitario) AS total_facturado, SUM(cantidad) AS unidades_vendidas
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

Consulta 3

SELECT id_cliente, COUNT (*) AS cantidad_pedidos, SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT (*) > 1

Consulta 4

  WITH facturacion_por_producto AS (
  SELECT 
  id_producto,
  SUM (cantidad * precio unitario) AS total_facturado
  FROM ventas
  GROUP BY id_producto
  )
  
SELECT id_producto, total_facturado
  CASE 
  WHEN total_facturado > (SELECT AVG(total_facturado) FROM facturacion_por_producto) THEN 'Por encima'
  ELSE 'Por debajo'
  END AS condicion
  FROM facturacion_por_producto;

-- COMENTARIOS 
-- Hallazgo 1: El total gastado por cliente se encuentra concentrado en el cliente 1 quien ocupa el 41% del gasto total con 2 pedidos. Como el resto también tiene 2 pedidos, significa que compró productos cuyo precio unitario es el doble o triple del resto
-- Hallazgo 2: El id_producto 1 es uno de los que tiene menor cantidad de unidades vendidas (3) y es el que cuenta con el mayor monto facturado, lo que significa que el precio unitario es el mayor
-- Hallazgo 3: Solo el producto 1 y 3 se encuentran por encima del promedio de facturación, concentrando el 76% del total facturado entre el resto de los productos
