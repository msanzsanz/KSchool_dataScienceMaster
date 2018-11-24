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
