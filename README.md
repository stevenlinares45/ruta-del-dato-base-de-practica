# Base de practica de La Ruta del Dato (SQL Server)

Empresa de ventas **ficticia** para practicar SQL con el canal [La Ruta del Dato](https://www.youtube.com/@larutadeldato).
Todos los datos son sinteticos (generados con semilla fija), asi que tus resultados seran identicos a los de los videos.

## Contenido
| Archivo | Que hace |
|---|---|
| `01_crear_base.sql` | Crea la base `RutaDelDato` (solo si no existe) |
| `02_tablas.sql` | Crea las 6 tablas con llaves y restricciones |
| `03_datos.sql` | Carga 300 clientes, 6 categorias, 36 productos, 3000 ventas, 7443 lineas de detalle y el inventario |
| `ruta-del-dato_base-de-practica.zip` | Todo lo anterior mas los datos en CSV (para Python, n8n y otros usos) |

## Como usarla (SQL Server Management Studio)
1. Conectate a tu instancia de SQL Server.
2. Ejecuta, en este orden: `01_crear_base.sql`, `02_tablas.sql` y `03_datos.sql`.
3. Comprueba: `SELECT COUNT(*) FROM Clientes;` debe dar **300**.

## Como usarla (linea de comandos)
```
sqlcmd -S localhost -E -C -f 65001 -i 01_crear_base.sql
sqlcmd -S localhost -E -C -f 65001 -i 02_tablas.sql
sqlcmd -S localhost -E -C -f 65001 -d RutaDelDato -i 03_datos.sql
```

Los scripts usan UTF-8 (tildes). Los correos usan el dominio reservado `.test`: no son reales.

## Licencia
MIT (ver `LICENSE`).
