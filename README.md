# Memorama en Godot 4

Juego de memorama desarrollado con Godot 4.

El juego selecciona aleatoriamente un subconjunto de una colección de iconos,
genera dos cartas por cada elemento y distribuye las parejas aleatoriamente
sobre el tablero.

## Características

- Generación dinámica de cartas.
- Selección aleatoria de elementos para cada partida.
- Cartas implementadas como escenas reutilizables.
- Distribución automática mediante `GridContainer`.
- Comunicación entre nodos mediante señales.
- Detección automática de parejas.
- Contador de progreso.
- Reinicio al completar la partida.
- Recursos gráficos SVG.

## Estructura

    Main
    ├── Fondo
    ├── ContenedorDeCartas (GridContainer)
    │   └── Card × N
    └── HUD

### `main.tscn`

Escena principal. Administra el estado de la partida, genera las cartas y
comprueba las parejas seleccionadas.

### `card.tscn`

Escena reutilizable que representa una carta. Cada instancia mantiene su
propio identificador, textura y estado.

### `hud.tscn`

Interfaz utilizada para mostrar el progreso y el estado de la partida.

## Funcionamiento

Al comenzar una partida se selecciona aleatoriamente un subconjunto de los
iconos disponibles. Cada elemento se duplica para formar una pareja y el
mazo resultante se mezcla.

Las cartas se instancian dinámicamente desde `card.tscn` y se añaden a un
`GridContainer`, que se encarga de su distribución.

Cuando una carta es seleccionada, emite una señal que es procesada por la
escena principal. Al seleccionar dos cartas, sus identificadores son
comparados. Las parejas permanecen descubiertas, mientras que las cartas
diferentes vuelven a ocultarse después de un breve intervalo.

## Ejecución

1. Abrir el proyecto con Godot 4.
2. Ejecutar el proyecto con `F6`/`F5`.
