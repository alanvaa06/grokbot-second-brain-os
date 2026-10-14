<p align="center"><a href="README.md">English</a> · <strong>Español</strong></p>

<p align="center">
  <img src="docs/assets/grok-bot-banner.png" alt="Grok Bot" width="430">
</p>

<h1 align="center">grokbot-second-brain-os</h1>

<p align="center">
  <strong>El sistema operativo para tu equipo de bots.</strong><br>
  Un coordinador, bots especialistas y un cerebro compartido en markdown simple que es tuyo. El coordinador lo instala. Tú lo lees en Obsidian.
</p>

<p align="center">
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-22c55e.svg"></a>
  <img alt="Built for Grok Bot" src="https://img.shields.io/badge/built%20for-Grok%20Bot-3b82f6.svg">
  <img alt="Markdown only" src="https://img.shields.io/badge/stack-markdown%20%2B%20git-f59e0b.svg">
  <img alt="Obsidian ready" src="https://img.shields.io/badge/UI-Obsidian-7c3aed.svg">
  <a href="docs/acceptance.md"><img alt="Status: beta" src="https://img.shields.io/badge/status-beta-ec4899.svg"></a>
  <img alt="PRs welcome" src="https://img.shields.io/badge/PRs-welcome-14b8a6.svg">
</p>

---

## 🚀 Inicio rápido

Pégale esto a tu bot coordinador:

```text
Set up my second brain from https://github.com/alanvaa06/grokbot-second-brain-os
```

Esa es toda la instalación. El coordinador clona este repo, crea a partir de él un **repo privado en tu GitHub** y te entrevista con una pregunta a la vez: tu nombre, idioma y zona horaria; tus proyectos; los agentes que ya tienes; las reglas que ningún agente debe romper. Registra todo, crea un asistente y un bibliotecario si los quieres, y hace commit. Tú nunca tocas GitHub.

> **Lo que necesita la máquina del coordinador:** `git`, la CLI `gh` y `gh` con sesión iniciada en tu cuenta de GitHub. ¿Todavía no inicia sesión? El coordinador trabaja en local y te lo pide una sola vez al final.

## 🔗 Conecta GitHub (git + gh)

Tu coordinador necesita dos herramientas gratuitas en su máquina para crear tu repo privado. Si no programas, pídele al coordinador que haga estos pasos por ti, o síguelos una sola vez:

1. Crea una cuenta gratis en [github.com](https://github.com) si no tienes una.
2. Instala `git` ([git-scm.com](https://git-scm.com/downloads)) y la CLI de GitHub `gh` ([cli.github.com](https://cli.github.com)).
3. Ejecuta `gh auth login`, elige GitHub.com y HTTPS, e inicia sesión con tu navegador.
4. Comprueba que funcionó con `gh auth status`.

Nunca pegues una contraseña o un token en un chat ni en un archivo del vault.

## 🧠 Qué es

No es otro plugin de memoria para un solo agente de código. Es la forma en que un **equipo** de bots trabaja junto: un coordinador que orquesta, especialistas que hacen el trabajo, un asistente que te pone al día y un bibliotecario que mantiene todo en orden. Todos leen el mismo manual y escriben en las mismas carpetas, así que lo que aprende un bot lo encuentra el siguiente.

El cerebro compartido, en disco, en tu repo:

| Carpeta | Qué vive ahí |
|---|---|
| 👤 `user/` | Quién eres: los datos que le das a tu coordinador, con la fecha en que los dijiste |
| 📁 `projects/` | Una carpeta por proyecto o área: estado, decisiones, tareas abiertas, lecciones, reuniones, entregables |
| 📥 `raw/` | Las fuentes que dejas: papers, transcripciones, research. Nunca se editan, nunca se borran |
| 📚 `wiki/` | Conocimiento compilado desde `raw/`, solo con tu sí y con cada afirmación citada. Los bots lo consultan cuando lo necesitan, por su índice |
| 🤖 `agents/` | Quién es cada bot, qué puede y qué no puede hacer, y las skills que comparten |

`raw/` y `wiki/` siguen el [patrón de wiki con LLM de Andrej Karpathy](https://x.com/karpathy/status/2039805659525644595): entran fuentes inmutables, un LLM las compila en una wiki enlazada con índice y bitácora, y nada se recupera por búsqueda vectorial. Aquí el paso de compilar necesita tu sí, la wiki tiene su propio `_master-index.md` y cualquier bot del equipo puede consultarla cuando la necesite: abre el índice, lee solo los artículos que pide la tarea y los cita. Ningún bot carga la wiki completa en su contexto.

Un archivo, **`AGENTS.md`**, es el manual que todo bot lee antes de trabajar. Dice quién escribe dónde (los muros), cómo leer sin desperdiciar tokens y lo que nunca pasa: nada de fuentes inventadas, nada de secretos en disco, ningún correo enviado sin tu sí.

## ✨ Por qué operar tus bots como equipo

- **Una sola puerta de entrada.** Hablas con el coordinador. El coordinador delega, junta lo que regresa y te responde. Dejas de repartir tareas entre bots a mano.
- **Todo el equipo comparte un cerebro.** El coordinador pasa rutas, no texto pegado. Un agente que escribe el resumen de una reunión lo deja donde el siguiente agente lo va a encontrar.
- **El contexto sobrevive.** Decisiones, tareas y lecciones viven en archivos, no en un chat que se pierde hacia arriba. Cada bot retoma mañana donde el equipo se quedó hoy.
- **Cada bot tiene un trabajo y límites claros.** Cada agente se registra con lo que hace, lo que nunca hace y en qué carpetas puede escribir. Los agentes nuevos se agregan con una entrevista que lo asegura.
- **Tú mantienes el control.** Es tu repo, en tu GitHub, legible en Obsidian. Nada se compila en la wiki, no se crea ningún agente y no se envía ningún mensaje sin tu sí en el chat.
- **Se mantiene limpio.** Un rol de bibliotecario audita el vault de forma programada: links rotos, notas huérfanas, fuentes que nadie compiló, archivos que pasan su límite. Reporta; nunca arregla nada a tus espaldas.
- **Crece contigo.** Agrega proyectos y agentes a través del coordinador. Cada agente nuevo recibe un bloque Vault corto que le dice cómo usar el cerebro.

## 👥 El equipo por defecto

Tres roles, cada uno es un bloque de texto que se agrega a un bot **al que tú le pones nombre**. Sin personajes, sin personalidades incluidas.

| Rol | Trabajo | Escribe |
|---|---|---|
| 🎩 **Coordinador** | Orquesta al equipo, cierra tareas en el vault, aplica cambios a los agentes | `agents/`, `projects/`, `user/`, git |
| 📋 **Asistente** | Resumen diario y reporte semanal hechos con las tareas abiertas de cada proyecto | Nada; le reporta al coordinador |
| 🗂️ **Bibliotecario** | Índices y orden, auditoría cada pocos días, carpetas de proyectos nuevos | Índices, bitácoras, reportes de auditoría |

Agrega agentes de dominio (research, redacción, finanzas, lo que necesites) con la skill `second-brain-new-agent`: un trabajo, una voz, lo que nunca hace por escrito, y el bloque Vault.

## 💜 Usa Obsidian, conserva el control

La mejor forma de vivir con este cerebro es un clon local abierto en Obsidian:

1. Clona tu nuevo repo del vault en tu computadora y abre la carpeta como vault.
2. Instala el plugin **Obsidian Git** con pull automático. Tus bots hacen push después de cada cambio, así que siempre ves lo más reciente.
3. Empieza en `_master-index.md`. Todas las notas se enlazan desde ahí.
4. Edita lo que es tuyo (`user/`, tus notas de proyecto) y haz commit. Deja `raw/`, `wiki/` y `agents/` a los bots.

Ese es el punto: **el cerebro de tus bots es una carpeta que es tuya**, que puedes leer y que puedes editar. No una memoria escondida dentro de un proveedor. Detalles en [`docs/obsidian.md`](docs/obsidian.md) y [`docs/sync.md`](docs/sync.md).

## 🔌 Entornos

| Entorno | Adaptador | Qué hace |
|---|---|---|
| **Grok Bot** | [`adapters/grok-bot/`](adapters/grok-bot/README.md) | Completo: crea agentes, aplica descripciones, programa rutinas |
| Claude Code, Codex, Cursor | [`adapters/claude-code/`](adapters/claude-code/README.md) | Lee el vault, `/compile` y `/audit`; no crea agentes |
| Cualquier cosa con shell y git | [`adapters/generic/`](adapters/generic/README.md) | Manual: imprime las descripciones y tú las pegas |

## 🧩 Cómo está hecho

- **Markdown más git es todo el producto.** "Instalar" significa clonar más una entrevista. Sin servidor, sin base de datos, sin binarios.
- **El framework y tu contenido están separados por carpeta**, así que una actualización futura puede reemplazar el framework sin tocar tu vault. La tabla de quién es dueño de qué está en `AGENTS.md`.
- **Los muros son instrucciones, no candados.** Los agentes comparten disco y credenciales; el manual dice quién escribe dónde y la auditoría detecta desviaciones.
- **Nada se inventa.** Ninguna fuente, cifra, fecha o persona sin cita. Lo que no se pudo verificar se marca como no verificado.
- **Las skills siguen el formato Agent Skills**: una carpeta con un `SKILL.md`, leída directo del clon. Vienen seis con el repo: `init`, `new-agent`, `new-project`, `compile-plan`, `refresh-index`, `audit`.

```text
AGENTS.md        el manual que todo agente lee primero
LOCAL.md         tus valores: nombre, idioma, zona horaria, entorno, quién tiene cada rol
user/  raw/  wiki/  projects/
agents/          registro, reglas, bloques de rol, skills
adapters/        grok-bot, claude-code, generic
docs/            sync, Obsidian, prueba de aceptación, especificación de diseño
```

## 🛠️ Contribuir

Issues y pull requests son bienvenidos, sobre todo reportes de una primera instalación real: cada punto donde tu coordinador tuvo que adivinar es un bug del framework.

Ejecuta `bash scripts/dev-check.sh` antes de un pull request. Rechaza identificadores privados, rutas de plataforma fuera de los adaptadores, manual o bloques demasiado grandes, placeholders desconocidos y guiones largos. El criterio de lanzamiento está en [`docs/acceptance.md`](docs/acceptance.md).

## 📄 Licencia

[MIT](LICENSE). Úsalo, haz fork, construye tu propio equipo encima.

El nombre y el logo de Grok Bot pertenecen a su dueño; este es un proyecto independiente hecho primero para esa plataforma, no un producto oficial.
