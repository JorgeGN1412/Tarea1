# Tarea 1 — Construcción de interfaces web adaptables con HTML y CSS

## Identificación

- **Estudiante:** Jorge García Núñez
- **Curso:** SOFT-12 · Programación Web Avanzada
- **Sección:** SCV2
- **Docente:** Álvaro Cordero Peña
- **Fecha de entrega:** 20 de setiembre de 2026

## Descripción de los casos

### Caso 1 — Centro de control de una expedición científica
Pantalla tipo dashboard para que un equipo coordinador visualice de un vistazo el
estado de una expedición científica: indicadores generales, misiones activas,
equipos científicos, alertas y agenda del día. Resuelve el problema de mostrar
mucha información simultánea sin que se vea como una página corporativa
tradicional, priorizando lectura rápida en computadora y tableta.

### Caso 2 — Panel público de información de un festival
Panel pensado principalmente para teléfono, ya que los asistentes lo consultan
mientras se mueven por el festival. Resuelve el problema de mostrar "qué está
pasando ahora" como lo más importante en pantallas pequeñas, y de aprovechar
el espacio en escritorio para comparar la programación de varios escenarios a
la vez.

## Estructura de carpetas

```
Tarea1/
├── README.md
├── caso1/
│   ├── index.html
│   ├── css/
│   │   └── estilos.css
│   └── img/
└── caso2/
    ├── index.html
    ├── css/
    │   └── estilos.css
    └── img/
```

## Instrucciones para abrir cada caso

1. Clonar el repositorio.
2. Abrir `caso1/index.html` directamente en el navegador para ver el centro de
   control de la expedición.
3. Abrir `caso2/index.html` directamente en el navegador para ver el panel del
   festival.
4. Cada caso es independiente entre sí; no requieren servidor ni JavaScript.

## Decisiones de diseño

**¿Por qué seleccionó determinadas etiquetas semánticas?**
Se usó `header` para la identidad de cada página, `nav` para los menús de
navegación, `main` para el contenido central, `section` para cada bloque de
contenido con su propio `h2` (resumen, misiones, escenarios, etc.), `article`
para elementos repetibles y autocontenidos (una misión, un equipo, una
actividad), `aside` para contenido complementario (alertas en el Caso 1,
cambios importantes en el Caso 2) y `footer` para el cierre de cada página.

**¿Cómo organizó la jerarquía de encabezados?**
`h1` se usa una sola vez por página para el título general (nombre de la
expedición o del festival). Cada sección principal tiene un `h2`, y dentro de
las tarjetas repetidas (misión, equipo, escenario) se usa `h3` para el nombre
del elemento individual.

**¿Cómo incorporó la accesibilidad básica?**
Ambos documentos declaran `lang="es"`. Los estados (prioridad, categoría,
nivel de alerta) se comunican con texto además de color (por ejemplo
"Prioridad alta", símbolos ▶/⏸/■/✔ junto al estado de una misión, o la palabra
"Crítica"/"Alta" antes del mensaje de una alerta). Se usó `aria-label` en la
navegación y `aria-labelledby` para asociar cada sección con su encabezado.

**¿Cómo funciona el modelo de caja en sus principales componentes?**
Se aplicó `box-sizing: border-box` de forma global para que `padding` y
`border` no alteren el ancho declarado. Las tarjetas (`.tarjeta`) usan
`padding` interno consistente definido por variable, y los contenedores de
grid/flex usan `gap` en vez de márgenes individuales para separar elementos,
evitando así márgenes arbitrarios.

**¿Dónde utilizó posicionamiento, cuál valor de position empleó y por qué?**
- Caso 1: la cabecera (`.cabecera`) usa `position: sticky` para permanecer
  visible mientras se hace scroll en pantallas donde el contenido es largo.
  La etiqueta de prioridad de cada misión (`.mision__etiqueta`) usa
  `position: absolute` dentro de `.mision` con `position: relative`, para
  superponerse en la esquina de la tarjeta sin afectar el flujo del texto.
- Caso 2: la navegación (`.nav-principal`) usa `position: sticky` para
  mantenerse accesible en teléfono mientras el usuario se desplaza por el
  panel. La etiqueta "En este momento" (`.actividad-ahora__etiqueta`) usa
  `position: absolute` sobre `.actividad-ahora` con `position: relative`.
En ambos casos se verificó que el elemento posicionado no genere
desbordamiento horizontal ni tape contenido en ningún ancho de pantalla.

**¿Por qué algunos estilos prevalecen sobre otros?**
Se usaron clases de bloque (BEM simplificado, por ejemplo `.mision`,
`.mision__estado`, `.mision__estado--progreso`) para mantener una
especificidad baja y predecible, evitando anidar selectores o usar
`!important`. Las variantes de estado (`--progreso`, `--pendiente`, etc.) se
aplican como clases modificadoras que sobrescriben solo la propiedad de color
necesaria.

**¿Dónde utilizó Flexbox y por qué?**
En la navegación de ambos casos (alineación horizontal con ajuste al
envolver), en los indicadores del Caso 1 (distribución con tamaños distintos
según importancia), en el encabezado de cada misión (nombre a la izquierda,
estado a la derecha) y en la lista de servicios del Caso 2 (etiquetas que se
acomodan según el ancho disponible). Flexbox se usó siempre que la necesidad
era de alineación o distribución en una sola dirección.

**¿Dónde utilizó CSS Grid y por qué?**
El Caso 1 resuelve su estructura principal en escritorio con
`grid-template-areas` (resumen, misiones, equipos, alertas y agenda
distribuidos en zonas), que es el requerimiento explícito de ese caso. El
Caso 2 usa Grid principalmente en "Programación por escenarios" para poder
comparar los cuatro escenarios lado a lado en pantallas grandes, y también
para reorganizar el panel completo en escritorio.

**¿Cómo cambia el layout entre teléfono, tableta y escritorio?**
En teléfono todo se organiza en una sola columna, priorizando lo más
relevante primero (en el Caso 2, la sección "Ahora" se muestra primero
mediante `order` de Flexbox). En tableta aparecen columnas de a dos en
elementos repetibles (equipos, escenarios, actividades "ahora"). En
escritorio, ambos casos cambian a una distribución de Grid con varias zonas
visibles simultáneamente, aprovechando el ancho disponible.

**¿Cuáles media queries utilizó y por qué seleccionó esos breakpoints?**
Se usaron `min-width: 601px` (tableta) y `min-width: 1024px` (escritorio),
siguiendo la referencia orientativa de la consigna (teléfono 320–600px,
tableta 601–1024px, escritorio desde 1024px), ya que se ajustan bien al
contenido sin necesidad de breakpoints adicionales.

**¿Cuáles unidades relativas utilizó?**
`rem` para tipografía y espaciados (a través de las variables
`--espaciado-*`), `%`/`fr` para el reparto de columnas en Grid y Flexbox, y
`vw` implícito en el uso de `max-width` combinado con contenedores fluidos.

**¿Para qué sirven las variables CSS que definió?**
Las variables en `:root` (colores principales, de fondo, de texto, de estados,
espaciados y radios) centralizan la identidad visual de cada caso. Permiten
mantener consistencia entre componentes y modificar el diseño completo
cambiando un solo valor, sin buscar y reemplazar colores o medidas repetidas
por todo el CSS.

