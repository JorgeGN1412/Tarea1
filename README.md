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

## Resumen de commits

Tabla generada con `git log --date=short --pretty=format:"| %ad | %h | %s |"`
y completada con las columnas de caso y cambio principal.

> **Nota:** `git log` muestra dos commits más que esta tabla: el que agrega
> la tabla al README y el que elimina un script auxiliar. El hash de un commit
> no existe hasta que se crea, por lo que no pueden aparecer como filas.

| # | Fecha | Hash | Mensaje | Caso | Cambio |
|---|-------|------|---------|------|--------|
| 1 | 2026-09-20 | 7ea096a | Crear estructura de carpetas y README inicial | Ambos | Carpetas caso1 y caso2; identificación, descripción e instrucciones en el README |
| 2 | 2026-09-20 | 8d743cd | Caso 1: esqueleto HTML semántico con header, nav, main y footer | Caso 1 | Estructura semántica base y navegación con las cinco opciones |
| 3 | 2026-09-20 | fd872b3 | Caso 1: variables CSS, reset y estilos base mobile-first | Caso 1 | Variables en :root, box-sizing global y tipografía base |
| 4 | 2026-09-20 | bbafd0b | Caso 1: cabecera sticky y navegación con Flexbox | Caso 1 | position: sticky en la cabecera y nav flex que envuelve; estilo del pie |
| 5 | 2026-09-20 | 98ab07d | Caso 1: resumen de operaciones y misiones activas | Caso 1 | Indicadores con Flexbox y cinco misiones con estados y etiqueta de prioridad absolute |
| 6 | 2026-09-20 | 77b11df | Caso 1: equipos científicos y alertas con jerarquía visual | Caso 1 | Cuatro equipos y cuatro alertas con niveles de importancia diferenciados |
| 7 | 2026-09-20 | 661e1cf | Caso 1: agenda de próximas actividades | Caso 1 | Lista ordenada cronológicamente con hora, actividad y equipo |
| 8 | 2026-09-20 | e9d754a | Caso 1: media query de tableta con dos columnas | Caso 1 | min-width: 601px ajusta los indicadores y coloca los equipos en dos columnas |
| 9 | 2026-09-20 | 4965eb8 | Caso 1: CSS Grid con zonas simultáneas para escritorio | Caso 1 | min-width: 1024px con grid-template-areas para ver todo el panel a la vez |
| 10 | 2026-09-20 | b9cdd65 | Caso 2: esqueleto HTML semántico del panel del festival | Caso 2 | Header, nav con cinco opciones, main y footer |
| 11 | 2026-09-20 | e6b4c24 | Caso 2: variables CSS, base mobile-first, encabezado y nav sticky | Caso 2 | Variables, nav flex con position: sticky en teléfono y panel de una columna |
| 12 | 2026-09-20 | 6ec0fd1 | Caso 2: secciones Ahora y próximas actividades | Caso 2 | Tres actividades en curso con etiqueta absolute y seis próximas actividades |
| 13 | 2026-09-20 | e758182 | Caso 2: programación por escenarios | Caso 2 | Cuatro escenarios apilados en teléfono, base para el Grid de escritorio |
| 14 | 2026-09-20 | 73b29bf | Caso 2: cambios importantes y servicios con Flexbox | Caso 2 | Avisos destacados y seis servicios que se acomodan con flex-wrap |
| 15 | 2026-09-20 | 563f3ae | Caso 2: sección de información general | Caso 2 | Bloque de información general completo en la versión de teléfono |
| 16 | 2026-09-20 | 8a0d626 | Caso 2: media query de tableta | Caso 2 | min-width: 601px con Ahora y escenarios en dos columnas |
| 17 | 2026-09-20 | b7af271 | Caso 2: CSS Grid para comparar escenarios en escritorio | Caso 2 | min-width: 1024px reorganiza el panel y coloca los escenarios lado a lado |
| 18 | 2026-09-20 | fc34126 | Documentar decisiones de diseño en el README | Ambos | Respuestas a los aspectos que el estudiante debe poder explicar |
