# Pizzería La Nieve — sitio web

Contexto para cualquier sesión de Claude Code que retome este proyecto.

## Qué es

Sitio web de una página para la **Pizzería La Nieve**, Mar del Plata (Argentina).
Forma parte de un negocio de Mateo: crear páginas web para locales de Mar del Plata
y vendérselas. La Nieve es el primer cliente objetivo — es una pizzería muy conocida
en la ciudad y **no tiene absolutamente nada en internet** (ni web, ni Instagram;
solo una página de Facebook vieja).

El sitio funciona como **demo de venta**: se le muestra al dueño ya funcionando,
con sus datos reales, para cerrar la venta.

## Estado

- `index.html` — sitio completo y funcionando. Un solo archivo, sin dependencias,
  sin build. Pesa ~730 KB porque el logo y dos fotos van embebidos como data URI.
  Ojo: a ese tamaño el navegador integrado ya no lo abre como `file://` — hay que
  levantar el servidor local (ver "Cómo probarlo localmente").
- `index-v2-azul.html` — versión anterior (mismo diseño, paleta azul, carta de
  ejemplo). Se guarda por si hace falta comparar.
- `index-v1-pizarron.html` — versión más vieja (diseño de pizarrón, tipografía
  Archivo Black, bordes rectos).
- `docs\` — la versión lista para subir a un hosting (HTML liviano + imágenes
  sueltas). **Es generada**: no editarla a mano, sale de `hacer-publicar.ps1`.
- `hacer-publicar.ps1`, `hacer-og.ps1`, `publicar-cabecera.html` — lo que arma esa
  carpeta. Ver "Publicar".
- Publicado como Artifact privado en:
  https://claude.ai/code/artifact/9d1a3f34-a771-42c4-b9ad-691b2b431930
  Favicon del Artifact: 🍕 (mantenerlo igual en cada republicación).

> Al republicar el Artifact, quien tenga el link compartido **sigue viendo la versión
> vieja hasta mover el "share pin"** desde el menú de compartir de la página.

## Datos del local

Relevados **en persona por Mateo el 26/08/2026** (fotos de los TV de la carta, el
pizarrón de promos, las dos vitrinas y la fachada):

| Dato | Valor |
|---|---|
| Dirección | Rivadavia 3002, esq. La Rioja, Mar del Plata |
| Teléfono | 0223 495-0104 |
| Horario | Todos los días, 08:00 a 01:00 |
| Desde | 1949 (dice el toldo de la fachada) |
| Especialidad | Pizza al molde |
| Servicios | Salón (mostrador y mesas), take away, delivery |
| Pago | Efectivo y tarjeta |

## PENDIENTE — lo que falta para terminar

1. **Bebidas.** Es la única categoría sin datos: no hay foto de la lista. En la
   fachada hay carteles de **Quilmes y Pepsi**. Cuando Mateo tenga los precios,
   agregar una pestaña `{ tab: "Bebidas", grupos: [...] }` al final de `CARTA`
   y sumar el link en el pie (`data-tab="4"`).
2. **Número de WhatsApp.** La constante `WHATSAPP` tiene hoy el número **de Mateo**
   (`5492235337853`), a propósito: así, en la demo delante del dueño, el pedido
   llega de verdad a un teléfono que Mateo puede mostrar. Al cerrar la venta hay
   que cambiarlo por el del delivery del local, en formato internacional sin `+`
   ni espacios: `54 9 223 XXXXXXX`.
3. **Precios a re-chequear** (los carteles escritos a mano salieron con reflejo
   del vidrio o quedaron fuera de foco):
   - `Fugazzín` $2.200 — sospechosamente barato al lado del calentito ($5.200).
   - `Budín de pan` $4.300 — puede ser $8.300.
   - `Tarteleta` $4.200 y su descripción, medio tapada por el reflejo.
   - `Empanada de carne` y `Empanada de jamón y queso`: cargadas a $2.700 **por
     analogía** con las de verdura y cebolla, que sí se leen. Confirmar.
   - Faltan en la carta por no tener precio legible: fainá común (sin relleno),
     fatay picante, pizza de pollo, fugazzetta roquefort, fugazzetta pepperoni,
     tarta de ricota.
4. **Más fotos.** Ya están embebidas el logo, la fachada y la vitrina de tortas
   (ver "Fotos"). Falta la **vitrina de salados** (fainá, calentitos, fatay) — la
   foto existe pero no quedó guardada en disco. Cuando aparezca, iría como segunda
   imagen en "El local" o arriba de la pestaña "Del mostrador".
5. Confirmar zona de delivery y si cobran envío. **Ojo:** la respuesta del FAQ dice
   "repartimos en la zona del centro y alrededores" y eso está inventado — hay que
   confirmarlo o sacarlo antes de que lo lea el dueño.

## Cómo actualizar la carta

Toda la carta vive en el array `CARTA` al final del `<script>`, separada del diseño.
No hace falta tocar HTML ni CSS:

```js
const CARTA = [
  { tab: "Pizzas", grupos: [
      { nombre: "Pizzas enteras", items: [
          { n:"Muzzarella", d:"Salsa, muzzarella y aceitunas.", p:16000 },
          //  n = nombre   d = descripción (puede ir "")   p = precio en pesos, número entero
      ]}
  ]}
];
```

**El campo `n` es la clave del pedido**: no puede repetirse en toda la carta ni
coincidir con el `nombre` de un combo, porque el carrito indexa por nombre. Por eso
las porciones se llaman `"Porción de muzzarella"` y no `"Muzzarella"`.

Los combos están en el array `COMBOS`, con la misma lógica: son las nueve "súper
promos" del pizarrón de la vereda, que son **para llevar**. El que lleva
`destacado:true` es el que sale con la tarjeta roja llena.
El precio se formatea solo con `plata()` — cargar solo el número.

El CSS conserva la clase `.aviso` (barra de aviso arriba de todo) aunque el `div`
ya no esté en el HTML: sirve si hace falta volver a poner un cartel de "vista previa".

## Decisiones de diseño (respetarlas)

Rediseño de agosto 2026, pedido de Mateo: **más moderno y funcional**, tomando como
referencia una demo hecha con Webild (tarjetas redondeadas, precios grandes). De esa
referencia se toma el lenguaje visual, **no** su uso de fotos de stock: esas se
notaban de plantilla y siguen descartadas.

- **Fondo claro siempre.** Pedido explícito de Mateo. Se quitaron a propósito los
  bloques de tema oscuro: no hay `prefers-color-scheme` ni `data-theme` en el CSS,
  y `html` fuerza `color-scheme:light`. No volver a agregarlos.
- **Rojo y amarillo**, los colores reales del cartel de La Nieve (logo: óvalo rojo
  con letras amarillas), sobre fondo blanco. Pedido de Mateo después de ir al local.
  El azul de la versión anterior quedó descartado.
- Paleta: blanco `#FFFFFF`, superficie `#FFF7EC`, rojo de marca `#D4202A`
  (hover `#A8151E`), amarillo `#FFC72C` con marrón `#4A2A00` para el texto encima,
  tinta `#1A100C`, `#1E0C0A` para pie y menú de pantalla completa.
  Los neutros tienen **sesgo cálido** a propósito.
- Cómo se reparten los dos colores: el **rojo** manda (botones, precios, links,
  degradados de contacto y del combo destacado); el **amarillo** aparece de a poco
  — pastillas de sección, la mitad de los íconos, la raya de los títulos de grupo,
  el borde al pasar el mouse por un producto, y "NIEVE" en el pie.
  La pastilla amarilla sobre rojo (contacto, combo destacado) es una cita directa
  del logo. **No** poner texto amarillo sobre blanco: no contrasta.
- El punto verde de "Abierto ahora" se deja verde a propósito: es un semáforo, no
  parte de la marca.
- Tipografías (Google Fonts): **Plus Jakarta Sans** para todo (400–800) y
  **DM Mono** solo para etiquetas chicas, horarios y teléfonos.
- Formas: **bordes bien redondeados** (16–28px, botones tipo píldora), sombras
  suaves y muy difusas, sin gradientes salvo el rojo de contacto/combo destacado.
- Fotos: **solo fotos propias del local**, nunca de stock. Son tres y están
  medidas: el logo del payaso (barra de navegación, portada y pie), la fachada de
  la esquina (columna derecha de "El local", sin recorte: `aspect-ratio:9/16`, que
  es la proporción original) y la vitrina de tortas (banda 21:9 arriba de la carta).
  El resto del peso visual lo siguen llevando las tarjetas, la tipografía grande y
  los íconos SVG dibujados a mano en el propio archivo.
- Nada de reseñas ni testimonios inventados (la demo de Webild los traía). Tampoco
  frases tipo "el más pedido": las promos se llaman como en el pizarrón, "Promo 1"
  a "Promo 9".
- El archivo incluye `<meta name="viewport">` propio para que se vea bien en el
  celular también abierto suelto, sin el envoltorio del Artifact.

## Cómo funciona el pedido

Barra fija abajo: se arma tocando el `+` de cada producto (que se convierte en un
control de cantidad) y genera un mensaje de WhatsApp con el detalle, el total y el
tipo de entrega. Detalles de implementación:

- El pedido se guarda en `localStorage` (`lanieve-pedido`), envuelto en `try/catch`.
- Chips de entrega: retirar / con envío / en el local. Se suma al mensaje.
- Buscador de la carta: filtra **todas** las pestañas a la vez y muestra de qué
  pestaña viene cada grupo. Con el campo vacío vuelve a la pestaña activa.
- Cartel "Abierto ahora / Cerrado" calculado con el reloj del visitante contra el
  horario 08:00–01:00, refrescado cada minuto.

## Publicar

`index.html` (un solo archivo, con todo embebido) es la versión del **Artifact**.
Lo que se publica en la web es la carpeta **`docs\`**, que se genera con:

```bash
powershell -File hacer-publicar.ps1
```

El script saca el logo y las dos fotos a archivos sueltos (el HTML baja de 730 KB a
~64 KB, así el celular pinta la página sin esperar a que bajen las imágenes),
reemplaza las 5 primeras líneas de `index.html` por `publicar-cabecera.html`
—que trae el título largo, la descripción, las etiquetas Open Graph y la ficha
JSON-LD de Google— y escribe `robots.txt` y `sitemap.xml`.

**Correrlo después de cada cambio en `index.html`, y commitear `docs\`**: GitHub
Pages sirve los archivos tal cual están commiteados, no compila nada. Si el script
imprime un número distinto de 0 en "data URI que quedaron", alguna imagen del HTML
no coincide con la de `docs\` y hay que revisar.

### Por qué se llama `docs` y no `docs`

Es la única concesión al inglés del proyecto, y es forzada: GitHub Pages solo sabe
servir desde la raíz del repo o desde una carpeta llamada exactamente `/docs`.
Se configura en *Settings → Pages → Source: Deploy from a branch → main / docs*.

El `.nojekyll` de adentro apaga el procesador Jekyll de Pages, que no hace falta
y solo agrega demoras.

### Rutas y URLs

- Las rutas de las imágenes dentro del HTML son **relativas** (`logo.png`, no
  `/logo.png`) a propósito: Pages publica los proyectos en una **subcarpeta**
  (`/lanieve/`), así que una ruta absoluta apuntaría a la raíz del dominio y daría
  404. Con relativas el sitio anda igual en la raíz que en una subcarpeta.
- Las de `og:image`, `canonical`, el sitemap y la ficha JSON-LD **tienen que ser
  absolutas**, porque WhatsApp y Google no resuelven relativas. Están cableadas
  como `https://berchotmateo-spec.github.io/lanieve` en `publicar-cabecera.html` y
  en `hacer-publicar.ps1` (variable `$sitio`). **Si cambia el dominio, cambiarlas en
  los dos lados.**

`og.jpg` (1200×630) es la tarjeta que aparece al compartir el link; se genera aparte
con `hacer-og.ps1`.

## Fotos

Van embebidas como data URI para que `index.html` siga siendo un archivo único.
Originales en `C:\Users\k_hue\Downloads\`: `logo-lanieve.jpg` y las dos
`WhatsApp Image 2026-08-26 at 17.59.13*.jpeg`.

En esta máquina **no hay ffmpeg, ni Python, ni Node**. El procesamiento se hizo con
PowerShell + `System.Drawing`:

- **Fotos**: redimensionadas con `Graphics.DrawImage` + `HighQualityBicubic` y
  guardadas en JPEG con `EncoderParameter` de calidad (fachada 820 px de ancho al
  72, vitrina 1400 px al 70; ~160 KB cada una).
- **Logo**: el original es un JPEG con fondo blanco. Se le sacó el fondo con un
  *flood fill* desde los bordes sobre los píxeles con R, G y B ≥ 208, poniendo
  alpha 0, y se guardó como PNG. Importante: el relleno arranca **desde los bordes**
  justamente para no comerse el cuerpo blanco del payaso, que queda encerrado por
  su contorno negro. Por eso el logo también se lee bien sobre el pie oscuro.
- **`og.jpg` e `icono.png`**: los genera un script aparte que toma una banda
  horizontal de la fachada (desde `y=520` de `fachada.jpg`, que es donde entran el
  cartel, el toldo y el frente), le pone dos degradados oscuros encima para que se
  lea el texto, y encima el logo, "La Nieve", "Pizza al molde desde 1949" y la
  dirección, con una raya amarilla al pie. Está en `hacer-og.ps1` y lee las imágenes
  ya procesadas de `docs\`, así que se puede volver a correr cuando haga falta.

## Cómo probarlo localmente

Con ~730 KB, el navegador integrado ya no abre el archivo como `file://`. Servirlo:

```bash
start index.html          # Windows: doble clic funciona igual
```

Para verlo desde el navegador integrado, levantar un `HttpListener` de PowerShell
en `http://localhost:8787/` que sirva la carpeta, y abrir ahí `_preview.html`
(el `index.html` envuelto en `<html><body>`). `_preview.html` es temporal: borrarlo
al terminar.

El archivo está escrito para publicarse como Artifact, así que **no tiene**
`<html>`, `<head>` ni `<body>` propios — el servicio los agrega al publicar. Para
abrirlo suelto en el navegador funciona igual, pero si hace falta un HTML completo,
envolverlo:

```html
<!doctype html><html lang="es"><head><meta charset="utf-8"></head>
<body> <!-- contenido de index.html --> </body></html>
```

## Estructura del sitio

Portada → Ventajas → Carta (pestañas Pizzas / Empanadas y fainá / Del mostrador /
Postres + buscador) → Combos (las 9 promos) → El local → Preguntas frecuentes →
Contacto → Pie.

Arriba, barra flotante con estado del local y botón de pedido; en pantallas chicas
se reemplaza por un menú de pantalla completa.
