#!/usr/bin/env bash
# =============================================================================
#  hacer_commits.sh — Tarea 1 · SOFT-12
#
#  Convierte tu tarea ya terminada en un repositorio git con commits
#  pequeños y ordenados (uno por unidad de trabajo), y genera la tabla de
#  resumen del README a partir del historial REAL.
#
#  Cómo usarlo (desde Git Bash, dentro de la carpeta Tarea1):
#      bash hacer_commits.sh
#
#  Las fechas de los commits son las reales (la fecha/hora de HOY).
#  El script NO modifica fechas ni falsifica nada.
# =============================================================================
set -e

# ---------- Verificaciones previas ----------
if [ ! -d caso1 ] || [ ! -d caso2 ] || [ ! -f README.md ]; then
  echo "❌ Ejecuta este script DENTRO de la carpeta Tarea1"
  echo "   (donde están caso1/, caso2/ y README.md)."
  exit 1
fi

if [ -d .git ]; then
  echo "❌ Ya existe un repositorio git aquí (carpeta .git)."
  echo "   Este script es para empezar desde cero."
  exit 1
fi

if [ -z "$(git config user.name)" ] || [ -z "$(git config user.email)" ]; then
  echo "❌ Falta configurar tu nombre y correo en git. Ejecuta primero:"
  echo '   git config --global user.name  "Tu Nombre"'
  echo '   git config --global user.email "tu-correo-de-github@ejemplo.com"'
  exit 1
fi

RESPALDO="../Tarea1_respaldo"
if [ -e "$RESPALDO" ]; then
  echo "❌ Ya existe $RESPALDO . Bórralo o renómbralo y vuelve a ejecutar."
  exit 1
fi

# ---------- Respaldo de tu tarea terminada ----------
mkdir "$RESPALDO"
cp -r ./. "$RESPALDO"/
SRC="$(cd "$RESPALDO" && pwd)"
echo "✅ Respaldo de tu tarea creado en: $SRC"

# ---------- Preparación ----------
git init -q
git symbolic-ref HEAD refs/heads/main
rm -f README.md \
      caso1/index.html caso1/css/estilos.css \
      caso2/index.html caso2/css/estilos.css

CASOS=()
CAMBIOS=()

# armar <archivo> <líneas>  → reconstruye el archivo con esas líneas del original
armar() { sed -n "$2" "$SRC/$1" > "$1"; }

# confirmar <mensaje> <caso> <descripción>  → hace el commit
confirmar() {
  git add -A
  git commit -q -m "$1"
  CASOS+=("$2")
  CAMBIOS+=("$3")
  echo "   commit: $1"
}

echo "▶ Creando commits..."

# ============================ README + estructura ============================
armar README.md '1,52p'
confirmar "Crear estructura de carpetas y README inicial" "Ambos" \
  "Carpetas caso1 y caso2; identificación, descripción e instrucciones en el README"

# ================================== CASO 1 ===================================
armar caso1/index.html '1,32p;184,191p'
: > caso1/css/estilos.css
confirmar "Caso 1: esqueleto HTML semántico con header, nav, main y footer" "Caso 1" \
  "Estructura semántica base y navegación con las cinco opciones"

armar caso1/css/estilos.css '1,63p'
confirmar "Caso 1: variables CSS, reset y estilos base mobile-first" "Caso 1" \
  "Variables en :root, box-sizing global y tipografía base"

armar caso1/css/estilos.css '1,135p;329,336p'
confirmar "Caso 1: cabecera sticky y navegación con Flexbox" "Caso 1" \
  "position: sticky en la cabecera y nav flex que envuelve; estilo del pie"

armar caso1/index.html '1,106p;183,191p'
armar caso1/css/estilos.css '1,253p;329,336p'
confirmar "Caso 1: resumen de operaciones y misiones activas" "Caso 1" \
  "Indicadores con Flexbox y cinco misiones con estados y etiqueta de prioridad absolute"

armar caso1/index.html '1,171p;183,191p'
armar caso1/css/estilos.css '1,305p;329,336p'
confirmar "Caso 1: equipos científicos y alertas con jerarquía visual" "Caso 1" \
  "Cuatro equipos y cuatro alertas con niveles de importancia diferenciados"

armar caso1/index.html '1,$p'
armar caso1/css/estilos.css '1,336p'
confirmar "Caso 1: agenda de próximas actividades" "Caso 1" \
  "Lista ordenada cronológicamente con hora, actividad y equipo"

armar caso1/css/estilos.css '1,354p'
confirmar "Caso 1: media query de tableta con dos columnas" "Caso 1" \
  "min-width: 601px ajusta los indicadores y coloca los equipos en dos columnas"

armar caso1/css/estilos.css '1,$p'
confirmar "Caso 1: CSS Grid con zonas simultáneas para escritorio" "Caso 1" \
  "min-width: 1024px con grid-template-areas para ver todo el panel a la vez"

# ================================== CASO 2 ===================================
armar caso2/index.html '1,27p;136,143p'
: > caso2/css/estilos.css
confirmar "Caso 2: esqueleto HTML semántico del panel del festival" "Caso 2" \
  "Header, nav con cinco opciones, main y footer"

armar caso2/css/estilos.css '1,124p;255,262p'
confirmar "Caso 2: variables CSS, base mobile-first, encabezado y nav sticky" "Caso 2" \
  "Variables, nav flex con position: sticky en teléfono y panel de una columna"

armar caso2/index.html '1,64p;135,143p'
armar caso2/css/estilos.css '1,196p;255,262p'
confirmar "Caso 2: secciones Ahora y próximas actividades" "Caso 2" \
  "Tres actividades en curso con etiqueta absolute y seis próximas actividades"

armar caso2/index.html '1,107p;135,143p'
armar caso2/css/estilos.css '1,196p;227,248p;255,262p'
confirmar "Caso 2: programación por escenarios" "Caso 2" \
  "Cuatro escenarios apilados en teléfono, base para el Grid de escritorio"

armar caso2/index.html '1,130p;135,143p'
armar caso2/css/estilos.css '1,248p;255,262p'
confirmar "Caso 2: cambios importantes y servicios con Flexbox" "Caso 2" \
  "Avisos destacados y seis servicios que se acomodan con flex-wrap"

armar caso2/index.html '1,$p'
armar caso2/css/estilos.css '1,262p'
confirmar "Caso 2: sección de información general" "Caso 2" \
  "Bloque de información general completo en la versión de teléfono"

armar caso2/css/estilos.css '1,279p'
confirmar "Caso 2: media query de tableta" "Caso 2" \
  "min-width: 601px con Ahora y escenarios en dos columnas"

armar caso2/css/estilos.css '1,$p'
confirmar "Caso 2: CSS Grid para comparar escenarios en escritorio" "Caso 2" \
  "min-width: 1024px reorganiza el panel y coloca los escenarios lado a lado"

# ============================ README: decisiones =============================
armar README.md '1,145p'
confirmar "Documentar decisiones de diseño en el README" "Ambos" \
  "Respuestas a los aspectos que el estudiante debe poder explicar"

# ============================ README: tabla de commits =======================
{
  sed -n '1,145p' "$SRC/README.md"
  cat <<'EOF'
## Resumen de commits

Tabla generada con `git log --date=short --pretty=format:"| %ad | %h | %s |"`
y completada con las columnas de caso y cambio principal.

> **Nota:** el último commit del repositorio es el que agrega esta tabla al
> README. Su hash no existe hasta que se crea el commit, por lo que ese commit
> no aparece como fila; `git log` muestra un commit más que esta tabla.

| # | Fecha | Hash | Mensaje | Caso | Cambio |
|---|-------|------|---------|------|--------|
EOF
  n=0
  git log --reverse --date=short --abbrev=7 --pretty=tformat:'%ad|%h|%s' |
  while IFS='|' read -r fecha hash msg; do
    echo "| $((n+1)) | $fecha | $hash | $msg | ${CASOS[$n]} | ${CAMBIOS[$n]} |"
    n=$((n+1))
  done
} > README.tmp
mv README.tmp README.md

git add -A
git commit -q -m "Agregar tabla de resumen de commits al README"
echo "   commit: Agregar tabla de resumen de commits al README"

# ================================ Verificación ===============================
echo
if diff -rq -x .git -x README.md "$SRC" . > /dev/null; then
  echo "✅ Los archivos de caso1 y caso2 son IDÉNTICOS a tu tarea original."
else
  echo "⚠️  Hay diferencias con tu original (avísame):"
  diff -rq -x .git -x README.md "$SRC" .
fi
echo "✅ Total de commits: $(git rev-list --count HEAD)"
echo
git log --date=short --pretty=format:"%ad  %h  %s"
echo
