📽️Filmática – Consultas SQL
Consultas sobre datos de una tienda de alquiler de películas.

##🪧Descripción General
Este proyecto consiste en la ejecución de una serie de consultas SQL sobre una base de datos diseñada para gestionar los datos de una tienda de alquiler de películas. El objetivo final que se persigue con este proyecto es obtener un mayor entendimiento sobre los productos y los alquileres de la tienda. 
La base de datos contiene información relacionada con las películas, clientes, empleados, alquileres y otros elementos necesarios para el funcionamiento de esta tienda. Cada una de las tablas ofrece información valiosa sobre cada uno de los procesos/productos de la tienda.
Este archivo proporciona una guía detallada sobre la estructura del proyecto, las consultas realizadas y cómo han sido ejecutadas. 

##📊Estructura del Proyecto
El proyecto se organiza en la siguiente estructura de carpetas y archivos: 
I--- Data/ # Datos crudos sobre los productos y procesos de la tienda, contiene la base de datos. 
I---Scripts/ #Incluye el script de SQL con las consultas realizadas a lo largo del proyecto para ejecutar el script será necesaria la instalación de PostgreSQL. 
I--- Documentación/ #Incluye el archivo Read_me en el que se explica la estructura y la descripción del proyecto y un segundo archivo con los enunciados que describen las consultas realizadas. 

##💻Instalación y Requisitos
Antes de comenzar, asegúrate de que los siguientes requisitos se cumplen:
- Una instalación funcional de PostgreSQL para la realización del proyecto se ha utilizado la versión 16 de PostgreSQL.
- Acceso a un gestor de base de datos, preferiblemente DBeaver ya que ha sido el gestor de base de datos utilizado en este proyecto.
- La base de datos de la tienda de alquiler de películas debe estar descargada y configurada en el gestor de base de datos. La base de datos la encontrarás en la carpeta 
“Data” en este mismo directorio.
**Ejecución de las consultas:**  
Para ejecutar las consultas, sigue estos pasos:
1.Asegúrate de que la base de datos de PostgreSQL esté en ejecución.
2.Conéctate al servidor utilizando un cliente SQL.
3.Importa el archivo con la base de datos para crearla y rellenarla con datos.
4.Copia y pega las consultas proporcionadas en tu cliente SQL y ejecútalas para observar los resultados.
  
##📈Estructura de la Base de Datos
El esquema Entidad–Relación (ER) de Filmática está diseñado para representar de manera clara cómo interactúan las diferentes entidades dentro de la base de datos de la tienda. 
**Tablas principales del esquema ER sobre las que impacta nuestro estudio:**
- film: Esta tabla contiene la información básica de las películas, como el título, descripción, duración, o categoría, entre otros detalles. Se relaciona con otras tablas mediante claves foráneas para vincular las películas con su  inventario, categorías, alquileres o actores. 
- customer: En esta tabla se registran los datos de los clientes, incluyendo su nombre, dirección, correo electrónico y estado de actividad. Los clientes están relacionados con la tabla “rental”, que maneja los alquileres realizados, y con “payment”, en la que se detallan los registros de pagos.
- rental: Esta tabla guarda información sobre los alquileres realizados, incluyendo las fechas de inicio y finalización de los alquileres.
- inventory: Lista las copias disponibles de las películas y su localización dentro del establecimiento. Cada inventario está asociado a una película específica (tabla film) y se conecta con los registros de alquiler (rental) para gestionar la disponibilidad.
- staff: Detalla la información del personal del negocio, incluyendo los nombres y roles. También interactúa con la tabla payment para registrar quién procesó los pagos de los clientes.
- payment: Registra los pagos realizados por los clientes por los alquileres. Está directamente relacionado con customer, rental, y staff, reflejando los datos del cliente, el alquiler realizado y el empleado que gestionó la transacción.
- Store: Registra los datos de las tiendas en propiedad de Filmática incluye datos sobre su dirección y el personal que trabaja en cada tienda.

**Relaciones entre tablas**
- La tabla film está en el centro del sistema, vinculándose con inventory (que gestiona el stock de copias disponibles) y con rental (que contiene el historial de alquileres). Además se relaciona directamente o a través de tablas intermedias con la tabla actor (incluye los nombre y apellidos de los actores que participan en las películas que hay en tienda), category (incluye las categorías de las películas) y language (que gestiona los lenguajes de las películas)
- Customer está relacionado con rental y payment, indicando qué cliente alquiló qué película y cómo se realizó el pago correspondiente.
- Inventory funciona como una tabla intermedia que conecta la tabla film con los alquileres (rental) y los clientes (customer). Además de su función como tabla intermedia, esta tabla se encarga de la gestión de inventarios y de que cada película queda correctamente registrada y localizada, vinculándola con film y rental.
- Rental se relaciona con las tablas customer y payment de manera directa al incluir estas la información del pago y los datos de los clientes por cada alquiler. Además, se relaciona de forma indirecta con la tabla film que incluye datos de las películas alquiladas a través de la tabla inventory. 
- Staff interactúa con payment y rental para reflejar las operaciones realizadas por el personal. 
Este diseño proporciona una estructura lógica y eficiente que permite una gestión integral y detallada de todas las operaciones de la tienda de alquiler de películas desde esta base de datos.

##🔎Resultados y Conclusiones
El análisis realizado a través de las diversas consultas SQL ha permitido a Filmática optimizar su gestión de datos sobre la tienda. Estas consultas han garantizado un flujo eficiente de información, mejorando la trazabilidad de los alquileres y los pagos así como un mayor conocimiento sobre sus productos y las características de los mismos.
Asimismo, se identificaron oportunidades para incorporar métricas adicionales, como el rendimiento de películas por categoría o el análisis de patrones de alquiler, lo que podría proporcionar valiosos datos para futuras estrategias comerciales.
Por último, se han proporcionado en menor medida también datos acerca de la organización de las tiendas lo que puede ofrecer nuevos puntos de vista que permitan mejorar la forma en la que se administran las mismas.
Este proyecto ha sido diseñado para explorar y analizar datos de una tienda de alquiler de películas utilizando consultas SQL en PostgreSQL. Si encuentras errores o quieres sugerir mejoras, no dudes en contribuir al proyecto.

##🐾Próximos pasos
El presente proyecto se considera concluido en relación a su objetivo principal original  de explorar y analizar los datos de la tienda de alquiler de películas mediante consultas SQL.
Sin embargo, de proseguir con su desarrollo, se sugiere como próximos pasos la creación de dashboards interactivos que ofrezcan información visual y comprensible sobre los productos, sus ventas, y los patrones de compra de los clientes para mejorar el entendimiento de los datos por parte del cliente.
Estas herramientas permitirían a Filmática tomar decisiones más informadas basadas en el rendimiento de su catálogo y en el comportamiento de su clientela.
Adicionalmente, sería de gran valor realizar un análisis exhaustivo sobre cómo las variables externas influyen al modelo de negocio de Filmática. Las variables deberían analizarse tanto desde un punto de vista macroeconómico analizando indicadores como el PIB. Así como desde el punto de vista microeconómico quizá con el uso de un análisis de fuerzas de Porter. 
Este enfoque proporcionaría una visión más holística del negocio, ayudando a la tienda a adaptarse a un entorno cambiante y a identificar nuevas oportunidades para mantenerse competitiva en el sector del entretenimiento.

🤝Contribuciones
Las contribuciones al estudio son bienvenidas, para contribuir al estudio por favor observar las recomendaciones que se ofrecen en el apartado anterior de este documento. 

🖊️Autores
Jorge Donderis Pla (jorgedonderis@gmail.com) (https://github.com/jdonderis)
