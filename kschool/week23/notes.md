## Introducción a métricas robustas

media recortada
media winsorizada

* Alfa trimmed --> elimina el alfa % de datos por cada extremo. 10% por la drcha, 10% por la izq. y luego calcula las estadísticas necesarias

si alfa = 0 --> media
si alfa = 50 --> mediana

* Alfa winsorizada --> Los valores que están por encima de ese 0.1 los reduce hasta el valor máximo del umbral. Es decir, es como si saturase.
Todo lo que esté por encima del percentil 90 se convierte en percentil 90.
Todo lo que esté por debajo del percentil 10 se convierte en percentil 10.

Conclusiones - Métricas robustas 

1. Analizar variables económicas que "huelan" mal y usar estadísticos robustos (mediana)
2. Todas las técnicas que se basan en árboles, por su propia definicion, son robustas a los outliners.
3. En todo lo que es deeplearning los outliers, ya que los perentrones de deeplearnign son modelos lineales 

Conclusiones - forecast de demanda

1. Importante poner los márgenes con la precisión de ese margen.
2. Sólo hace falta una métrica.
3. Los modelos Bayesianos son los mas potentes en forecasting. Expertos en forecast son sólo expertos en forecast.
4. Ver 


## Diseño de experimentos

Aislar todos los efectos para sólo medir 1 variable.
Todo esto generalmente se usa en medicina. 
Es interesante que estos diseños de experimentos se tiene que hacer antes de coger los datos.

**Sección Cruzada:** Haces una foto fija
Xej, una BBDD de clientes con sus compras a lo largo del tiempo. 
Hay datos que permanecen mas o menos fijos de mes a mes (salario, estudios) y otros mas variables (facturación mensual)

**Longitudinales**
Sólo una persona, pero a la largo del tiempo.
Normalmente se tratan con series temporales.

**Case-Control**
Dividir la población en los dos grupos.
Se puede hacer en un momento determinado o en el tiempo.
Paneles: dividies la gente en grupos y evaluas como evoluciona eso a lo largo del tiempo. Ej, eliges el canal de contacto (tlf, email) y mides el impacto en la relación

**Cohortes**
muy habitual en el mantenimiento preventivo de una flota de camiones.
Se pueden agrupar los camiones en su fecha de adquisición y evaluar cómo se dañan a lo largo del tiempo (primer año, segundo año, etc...)


## Evaluación de modelos predictivos

Potenciales
   Aplico acción 
   No Aplico acción
No potenciales
   Aplico acción
   No Aplico acción

Es importante que se midan las 2 variables en sus 4 combinaciones, xq sino luego no puedes saber xq funcionan las cosas. Si es el modelo o es la acción. 
Adicionalmente las acciones varian a lo largo del tiempo.
El modelo también pierde eficacia (xej, los patrones pueden cambiar. El 5j puede perder status). Si su nivel predictivo baja, hay que aplicar acciones (reentrenarlo, regenerarlo, etc)

Adicionalmente, cuando recrees el modelo, hay que decidir qué datos coger. Si se perdió capacidad predictiva en el modelo, no tiene sentido coger los datos pasados tal cual.
Adicionalmente, hay que filtrar todos los casos que están afectados por mi accion, xq no son limpios.

Igualmente, en mantenimiento preventivo, hay que dejar de aplicar las acciones de vez en cuando. Sino, no podemos ir cogiendo datos a futuro para reentrenar los modelos.

Por este motivo, se han evitado cajas negras especificas (los zapata no pagan), estamos generando excepciones que se perpetuan en el tiempo.

## Difference in difference

## Segmentación de clientes
**Segmentación estratégica:** Segmentas el mercado. Ves a todas las personas, sus variables psociodemográficas y segmentas el mercado.
Goal: segmentar la población total

**Segmentación táctica**: yo segmento a mis clientes en función de los servicios y productos que tienen.
Xq? Si detecto dos personas similares, qui´za debería ofrecer a sus similares los mismos productos.

**Segmentación comportamentales** 
Entender cuándo cambian los patrones. Ha cambiado la empresa algo o lo he cambiado yo?

Importante:::: para los cluster, no meter todas las features que tiens, sólo las que vayan a aportar.
REcordatorio: K.means se productica muy facilmente.


### Modelo RFM: Recencia - Frecuencia - Monetización
PAra esto, el dataset pinta como
Fecha, Cliente, Importe.

Variantes... Fecha, cliente, tiempo en página
            Fecha, cliente, número llamadas
            
.... Con que tengas Fecha, ID, variable numérica se puede montar una segmentación comportamental miuy fácil.

