# Pizzería La Nieve — sitio web

Contexto para cualquier sesión de Claude Code que retome este proyecto.

## Qué es

Sitio web de una página para la **Pizzería La Nieve**, Mar del Plata (Argentina).
Forma parte de un negocio de Mateo: crear páginas web para locales de Mar del Plata
y vendérselas. La Nieve es el primer cliente objetivo — es una pizzería muy conocida
en la ciudad y **no tiene web ni Instagram** (solo una página de Facebook vieja y su
ficha en Pedidos Ya, que es por donde toma los pedidos a domicilio).

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
| Horario | ⚠️ **MAL. No cierran a la 01:00** (lo dijo el dueño el 05/09/2026). Falta el real. |
| Desde | 1949 (dice el toldo de la fachada) |
| Especialidad | Pizza al molde |
| Servicios | Salón (mostrador y mesas), take away, delivery **por Pedidos Ya** |
| Pago | Efectivo y tarjeta |
| Pedidos online | https://www.pedidosya.com.ar/restaurantes/mar-del-plata/la-nieve-pizzeria-menu |

**El local no tiene delivery propio ni WhatsApp.** Todo lo que sea pedido a domicilio
pasa por Pedidos Ya (dato de Mateo, 03/09/2026). Por eso el sitio no arma pedidos:
la carta es un catálogo con precios y los botones llevan a la app.

## PENDIENTE — lo que falta para terminar

0. **FALTA EL HORARIO DE CIERRE REAL.** El dueño avisó el 05/09/2026 que **no
   cierran a la 01:00** (el 08:00 de apertura no lo desmintió, pero conviene
   confirmarlo igual). Mientras tanto, **ya se neutralizó** todo el "01:00"
   inventado — no queda a la vista de nadie — y quedó así:

   - Las seis menciones de horario en `index.html` (portada, "El local",
     FAQ, contacto, pie) dicen ahora **"Desde las 08:00"**, sin hora de cierre.
   - El cartel `#estado` de la barra de navegación (el puntito verde de
     "Abierto ahora / Cerrado") quedó fijo en **"Abre 08:00"**. La función
     `estadoLocal()` está vaciada a propósito — no hay forma de calcular
     abierto/cerrado sin saber cuándo cierran, y mostrar un estado en vivo
     calculado con un horario inventado es peor que no mostrar nada.
   - `publicar-cabecera.html`: la `description`, el `og:description` y el
     JSON-LD para Google. Se sacó del todo el bloque
     `openingHoursSpecification` en vez de dejarlo con un `closes` inventado
     — eso es dato estructurado que Google puede mostrar como un hecho.

   **Cuando Mateo traiga el horario real**, hay que:
   1. Reponer el horario completo en las seis menciones de `index.html`.
   2. Reescribir `estadoLocal()` con la condición correcta. Si el cierre
      **cruza la medianoche** (como el 01:00 original), la condición es
      `(h >= apertura || h < cierre)`; si cierra **antes de las 24:00**, es
      `(h >= apertura && h < cierre)`. No es la misma fórmula.
   3. Volver a poner `openingHoursSpecification` en `publicar-cabecera.html`
      con los valores reales.

1. **Precios de mostrador de lo que salió de Pedidos Ya.** Los productos con
   `p:null` se muestran como "Consultar en el local" (ver "Productos sin precio").
   Son las **bebidas** enteras, las cuatro fainás nuevas, la torta de ricota y la
   pasta frola. Nombres y descripciones ya están; falta que el dueño pase el precio
   del mostrador. **No copiar el de Pedidos Ya**: trae la comisión de la app arriba
   (ver "Precios de Pedidos Ya" más abajo).
2. **Link de Pedidos Ya.** Está en la constante `PEDIDOS_YA`. En la app hay **dos
   fichas** de La Nieve: la que usamos (`.../mar-del-plata/la-nieve-pizzeria-menu`)
   y otra bajo la zona Santa Celina. Confirmar con el dueño cuál es la que atiende.
3. **Precios a re-chequear** (los carteles escritos a mano salieron con reflejo
   del vidrio o quedaron fuera de foco):
   - `Fugazzín` $2.200 — sospechosamente barato al lado del calentito ($5.200).
   - `Tarteleta` $4.200 y su descripción, medio tapada por el reflejo.
   - `Empanada de carne` y `Empanada de jamón y queso`: cargadas a $2.700 **por
     analogía** con las de verdura y cebolla, que sí se leen. Confirmar.
   - `Budín de pan` $4.300: **resuelto**, era eso y no $8.300 (en Pedidos Ya sale
     $4.600, que con la comisión encima cierra con $4.300).
   - Siguen faltando: fatay picante, pizza de pollo, fugazzetta roquefort y
     fugazzetta pepperoni. De la pestaña Pizzas de la app solo tenemos las seis
     primeras; falta bajar el resto, y la pestaña Empanadas entera.
   - `Muzzarella`: nuestra descripción dice "salsa, muzzarella y **aceitunas**" (sale
     de los TV del salón) y la app dice "salsa de tomate, muzzarella y **orégano**".
     Se deja la nuestra. Preguntar cuál va.
   - En Pedidos Ya hay dos categorías que la carta del sitio **no tiene**: las
     **tartas saladas enteras** (jamón, queso y huevo; pascualina; pascualina
     especial; cebolla y muzzarella; pollo; pollo especial; atún) y **sándwiches**.
     Preguntar si se venden también por mostrador antes de sumarlas.
   - `Cerveza Stella Artois`: en la app el título dice 473 ml y la descripción
     500 cc. Cargada como 473 ml. Confirmar.
4. **Más fotos.** Ya están embebidas el logo, la fachada y la vitrina de tortas
   (ver "Fotos"). Falta la **vitrina de salados** (fainá, calentitos, fatay) — la
   foto existe pero no quedó guardada en disco. Cuando aparezca, iría como segunda
   imagen en "El local" o arriba de la pestaña "Del mostrador".
5. Zona de delivery y costo de envío: ya no los decide el local, los muestra Pedidos
   Ya al cargar la dirección. El FAQ lo dice así, sin inventar zonas.

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

**### Productos sin precio

`p:null` en vez de un número muestra **"Consultar en el local"** en gris chico, en
lugar del precio. Es para los productos que salieron de la carta de Pedidos Ya y
todavía no tienen precio de mostrador confirmado. Cuando el dueño lo pase, se
reemplaza el `null` por el número y listo.

### Precios de Pedidos Ya

**No sirven como precio de mostrador**: la app suma su comisión. Comparando lo que
tenemos relevado contra la app (captura del 03/09/2026), el recargo ronda el 7–11 %:

| Producto | Mostrador | Pedidos Ya | Recargo |
|---|---|---|---|
| Muzzarella | $16.000 | $17.900 | +11,9 % |
| Fugazzetta | $20.000 | $22.400 | +12,0 % |
| Salsa de tomate y anchoas | $22.400 | $25.000 | +11,6 % |
| Fugazzetta especial | $28.000 | $31.300 | +11,8 % |
| Pizza especial | $27.200 | $30.400 | +11,8 % |
| Muzzarella, jamón y palmitos | $32.000 | $35.800 | +11,9 % |
| Budín de pan | $4.300 | $4.600 | +7,0 % |
| Flan casero | $3.700 | $4.000 | +8,1 % |
| Mousse de chocolate | $3.700 | $4.000 | +8,1 % |
| Medialuna gigante | $6.000 | $6.700 | +11,7 % |
| Promos 2 a 9 (las nueve del pizarrón) | — | — | +6 a 8 % |

Las **pizzas** llevan un recargo parejo de ~11,8 %; los **combos**, de 6 a 8 %.
Que doce productos den un porcentaje tan constante confirma que los precios
relevados de los carteles están bien leídos.

Sirve para **validar** un precio dudoso (así se resolvió el budín de pan), no para
cargarlo. La carta avisa de esta diferencia en una nota amarilla arriba de los
productos (`.nota-precios`).

### Los nueve combos, verificados

Las nueve promos del pizarrón coinciden **una por una** con las de Pedidos Ya, en
número y contenido (captura del 03/09/2026). Dos cosas para mirar:

- **Promo 1** (tres muzzarellas) es la única que se sale del rango: $44.000 contra
  $49.900 en la app, +13,4 % donde el resto va de 6 a 8 %. O el $44.000 del pizarrón
  quedó mal leído, o la app la cobra distinto. Confirmar con el dueño.
  Ojo además: en la app **la misma promo aparece dos veces**, como "Promo1 – 3
  muzzarellas enteras" a $49.900 y como "Promoción 1 – 3 pizzas muzzarella" a
  $57.000 con 12 % off ($50.160).
- **Promo 3**: nuestra ficha dice "1 fugazzetta **o napolitana**"; la app dice solo
  fugazzeta. Confirmar si la napolitana sigue siendo opción.

La app tiene además promos que **no** están en el pizarrón: muzzarella + 2 cervezas
(Quilmes/Brahma o Stella) y muzzarella + Pepsi 1,5 l. Preguntar si son solo de la
app o también se venden en el mostrador. Las de cerveza están detrás de la
validación de edad de Pedidos Ya.

**El campo `n` no se repite en toda la carta.** Ya no es una obligación técnica
—el carrito que indexaba por nombre se fue con el cambio a Pedidos Ya— pero se
mantiene: el buscador filtra las cinco pestañas a la vez y dos productos con el
mismo nombre no se distinguirían. Por eso las porciones se llaman
`"Porción de muzzarella"` y no `"Muzzarella"`.

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
- **La nevada** es el chiste visual con el nombre del local. Va **a rachas, no
  continua**: una tanda cada 10 segundos que cae y se termina sola, así sorprende
  en vez de distraer. Es un `<canvas id="nieve">` fijo, `pointer-events:none`, en
  `z-index:50` — por delante del contenido y por detrás de la barra de navegación
  (60) y la del pedido (70).
  Los copos van en **gris azulado** (`124,144,176`), la única nota fría de la
  paleta: sobre blanco la nieve blanca no se ve, y la nieve es fría igual que el
  punto verde es un semáforo. Da ~2,5:1 de contraste, suficiente en movimiento.
  Se regula con cuatro constantes arriba del bloque: `CADA_NEVADA`, `COPOS`,
  `COLOR_COPO` y `FUERZA_COPO` (opacidad mínima y cuánto suma al azar).
  El bucle **se apaga solo** cuando cae el último copo, así entre nevada y nevada
  no queda nada consumiendo batería; no arranca si el visitante pidió
  `prefers-reduced-motion`, ni si la pestaña está tapada.

  > Ojo al probarla: el navegador integrado **no corre `requestAnimationFrame`**
  > (0 cuadros por segundo), así que ahí la animación no se ve moverse aunque el
  > código esté bien. Hay que mirarla en un navegador de verdad.
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

El pedido no se arma en el sitio: se hace en Pedidos Ya. La carta es un catálogo
con precios y todos los botones de pedido abren la misma URL en una pestaña nueva.

- La URL vive en una sola constante, `PEDIDOS_YA`. Los botones del HTML llevan el
  atributo `data-py` y el script les carga el `href` al arrancar; los de los combos
  se crean por JS con la misma constante. Para cambiar el link se toca un solo lugar.
- Ese `href` se asigna **antes** del bloque de scroll suave, que engancha los `a`
  cuyo `href` empieza con `#`: si se asignara después, los botones scrollearían en
  vez de abrir la app.
- Barra fija abajo con el botón de Pedidos Ya, siempre visible. El `body` compensa
  su alto con `padding-bottom` (112px, 170px en pantallas chicas).
- No hay carrito, ni `localStorage`, ni chips de tipo de entrega: eso lo resuelve
  la app. Retiro por el local y pedidos grandes van por teléfono.
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
Postres / Bebidas + buscador) → Combos (las 9 promos) → El local → Preguntas frecuentes →
Contacto → Pie.

Arriba, barra flotante con estado del local y botón de pedido; en pantallas chicas
se reemplaza por un menú de pantalla completa.
