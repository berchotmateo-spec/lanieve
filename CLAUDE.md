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
| Teléfono | 0223 495-0104 — ⚠️ **NO va en el sitio**, el dueño pidió sacarlo el 15/09/2026 |
| Horario | Todos los días, 08:00 a 00:00 (confirmado por el dueño el 11/09/2026) |
| Desde | 1949 (dice el toldo de la fachada) |
| Especialidad | Pizza al molde |
| Servicios | Salón (mostrador y mesas), take away, delivery **por Pedidos Ya** |
| Pago | Efectivo, tarjeta de **débito**, Mercado Pago y QR. **Crédito no** (dueño, 11/09/2026) |
| Pedidos online | https://www.pedidosya.com.ar/restaurantes/mar-del-plata/la-nieve-pizzeria-menu |
| Instagram | https://www.instagram.com/lanieve_oficial/ — @lanieve_oficial, ~4.800 seguidores, activo |
| Facebook | https://www.facebook.com/pages/La-Nieve/159752137433973 — ⚠️ **NO va en el sitio**, el dueño pidió sacarlo el 15/09/2026 |

**El local no tiene delivery propio ni WhatsApp.** Todo lo que sea pedido a domicilio
pasa por Pedidos Ya (dato de Mateo, 03/09/2026). Por eso el sitio no arma pedidos:
la carta es un catálogo con precios y los botones llevan a la app.

**El teléfono NO se publica.** El dueño pidió sacarlo el 15/09/2026 y se quitó de
los ocho lugares donde aparecía, incluido el `telephone` del JSON-LD (si queda
ahí, Google lo sigue mostrando en la ficha aunque no esté a la vista en la
página). Quedan **dos canales**: Pedidos Ya y el mostrador. Ojo al escribir
textos nuevos: las respuestas del FAQ sobre retiro, pedidos grandes y dudas
**decían "llamanos"** y hubo que reescribirlas. No volver a ofrecer el teléfono
como canal sin que el dueño lo pida.

### Redes sociales (agregadas el 15/09/2026)

Los botones salen de la constante **`REDES`**, arriba de todo en el `<script>`,
al lado de `PEDIDOS_YA`. Aparecen en dos lugares: **Contacto** (botón con
nombre, bajo "Seguínos") y el **pie** (solo el ícono, en la columna de la
marca). El JSON-LD suma un **`sameAs`** con las dos direcciones: es lo que le
dice a Google que esas cuentas son del mismo local.

Para sacar una red basta con dejarla en `""`: el `forEach` de `[data-red]`
borra el botón del HTML. Nunca queda un enlace apuntando a `#`.

Los botones vienen con el atributo `hidden` puesto en el HTML y el JS los
muestra solo si tienen link. Es a propósito: sin eso, en un celular lento se
alcanza a ver el botón de una red que un instante después desaparece.

**El Instagram está verificado** (@lanieve_oficial, sale en la búsqueda de
Google del local y lo pasó Mateo).

**El Facebook se sacó el 15/09/2026**, por pedido del dueño. `REDES.facebook`
quedó en `""` y la línea salió del `sameAs` de `publicar-cabecera.html`. El
HTML del botón sigue ahí, oculto: si algún día lo quieren de vuelta, alcanza
con volver a poner el link en `REDES`. **No reponerlo sin que lo pida el
dueño.**

**No hay TikTok ni X.** Se buscó y no aparecieron. Si algún día abren una,
agregarla a `REDES`, al `sameAs`, y copiar el bloque de botón con un
`data-red="tiktok"`.

### El botón "Sitio web" de Google

El enlace que Google muestra en la ficha del local **no sale de esta página**:
sale del **perfil de Google Business** del local, que se administra en
business.google.com con la cuenta del dueño. Nosotros no lo podemos cambiar
desde acá, por más que el sitio esté perfecto. El dueño (o quien tenga el
perfil reclamado) tiene que entrar y poner la URL a mano. El `sameAs` y el
`canonical` ayudan a que Google entienda que el sitio es del local, pero **no
reemplazan ese paso**.

### Fotos de producto — decidido el 15/09/2026, pendiente de ejecutar

El dueño quiere **una foto por producto en la carta**. Mateo las saca en el
local junto con la lista definitiva de precios.

**Son 63 fotos, no 85.** La carta tiene 85 productos, pero las **22 pizzas
están cargadas dos veces** (entera y por porción, nombres distintos, mismo
producto). Una foto de la porción sirve para las dos filas. El resto: 4
empanadas, 6 fainás, 8 del mostrador, 16 postres, 7 bebidas.

**Las fotos NO van como data URI.** El `index.html` ya pesa 734 KB con solo
tres imágenes embebidas. Sesenta y tres más lo harían inusable. Van como
archivos sueltos en `docs/`, en WebP, redimensionadas a ~800 px de lado y con
`loading="lazy"`. En el Artifact se publican con el parámetro `files`, que
acepta archivos al lado de la página.

**La carta tiene que soportar fotos parciales.** Es muy probable que vuelva
con 20 y no con 63. El diseño de `tarjeta()` debe verse bien con foto y sin
foto en la misma grilla — no dejar huecos ni placeholders grises.

Campo previsto en `CARTA`: `f:"muzzarella.webp"`, opcional. Sin `f`, la
tarjeta se dibuja como hasta ahora.

## La carta sale del rollo del sistema (16/09/2026)

Mateo trajo **la impresión del listado de precios del sistema del local**, por
rubros. El dueño dijo que **eso es lo correcto**: ante cualquier diferencia,
manda el rollo, no el pizarrón ni Pedidos Ya.

La lectura se verificó de tres formas independientes y **cerró en las tres**:

1. Los **44 precios de pizza** que ya teníamos (leídos del pizarrón y de los
   televisores del salón) coinciden uno por uno con el rollo.
2. En el rubro pizzas, **cada media es la mitad exacta de la entera y cada
   porción es un octavo exacto**, en las 92 líneas. Sin un solo redondeo raro.
3. El **"Total del Rubro"** impreso al pie de cada rubro coincide con la
   cantidad de líneas transcriptas: 92, 22, 24, 14, 18 y 5. Eso descarta que se
   haya salteado o duplicado una línea.

**Ojo al leer las fotos del rollo**: por el ángulo de la cámara, el par
`Cod. PV` de cada renglón queda impreso **una línea más arriba** que su
descripción. Si se lee "en la misma línea" sale todo corrido en uno, y las
cuentas de la mitad y el octavo dejan de cerrar. Esa es la forma de verificar
que se está leyendo bien.

### Lo que cambió en la carta

- **Una tarjeta por producto con hasta tres precios** (entera, media y porción),
  en vez de repetir la misma pizza en dos grupos. `tarjeta()` lee `p` (entera),
  `m` (media) y `c` (porción); si no hay `m` ni `c`, dibuja el precio solo como
  antes. Bajó de 44 tarjetas a 30 en pizzas y de paso son 30 fotos y no 44.
- **Dos pestañas nuevas**: `Tartas saladas` y `Cafetería`. Son siete pestañas,
  la barra ya scrollea sola en el celular.
- Los `data-tab` del pie apuntan a los índices nuevos. Si se agrega o se saca
  una pestaña, **hay que revisarlos**: son índices, no nombres.
- Se sumó una pregunta al FAQ sobre el desayuno, y la descripción para Google
  y el `servesCuisine` ahora nombran la cafetería y las tartas.

### Productos que NO se cargaron, a propósito

- **`POLBLAPROVO` $33.600** (media $16.800, porción $4.200). Es la única pizza
  con precio distinto al resto. No se carga hasta saber cómo se llama: poner
  "POLBLAPROVO" en una carta para clientes es peor que no ponerla.
- **`ROSCA PASCUA` $27.000**: es de temporada, no va en septiembre.
- **`PORCION TORTA` $8.000 y `PORC TORTA ESP` $8.500** son códigos genéricos del
  sistema, no productos: son el precio con el que se cobran las tortas que en la
  carta tienen nombre propio (María Renée, pistacho Dubai y las demás).

## El logo (cambiado el 16/09/2026)

El que estaba era **el del Mundial**: el muñeco con la camiseta de Argentina y
el 10. Era de temporada. El dueño mandó el original y es el que va: **gorra
verde, bufanda amarilla a cuadros rojos, la pizza humeante en la mano**.

**No volver a poner el del Mundial** sin que lo pida el dueño.

Salió del archivo oficial, que trae el muñeco y el óvalo rojo del logotipo uno
al lado del otro sobre fondo blanco. Para quedarse solo con el muñeco:

- **El fondo se saca con un relleno desde los bordes, nunca borrando el
  blanco.** El muñeco *es* blanco: un borrado por color lo deja hecho un
  fantasma con el contorno flotando.
- **El óvalo se corta midiendo, no a ojo.** Desde `x=1300`, que siempre cae
  adentro del óvalo, se camina hacia la izquierda hasta el blanco que lo separa
  de la pizza: eso da el borde exacto fila por fila. Las puntas del óvalo son
  tan finas que ahí `x=1300` ya es blanco, así que esas filas se limpian con un
  borde fijo bien a la derecha.
- **Primero se borra el óvalo y después se saca el fondo.** Al revés queda un
  bloque blanco opaco: el hueco entre el muñeco y el óvalo está encerrado y el
  relleno desde los bordes no llega.
- **Se guarda con paleta** (`quantize(64, FASTOCTREE)`). El dibujo es de colores
  planos: pasa de 100 KB a 11 KB y en pantalla es idéntico. Como el logo va
  embebido **tres veces** en `index.html`, eso solo bajó el archivo de 755 KB a
  554 KB.

Se rehicieron los tres archivos: `docs/logo.png` (244×300), `docs/icono.png`
(180×180, el de la pestaña) y `docs/og.jpg` (la tarjeta que se ve al compartir
el link, que también tenía el muñeco del Mundial abajo a la izquierda).

`hacer-og.ps1` lee `docs/logo.png`, así que si el logo vuelve a cambiar,
alcanza con reemplazar ese archivo y correrlo.

Hay **tres piezas de marca**, cada una para su tamaño:

| Archivo | Dónde | Tamaño en pantalla |
|---|---|---|
| `logotipo.png` (750×420) | portada, clase `.logotipo` | 104 a 142 px de alto |
| `logo.png` (244×300) | barra y pie, el muñeco solo | 34 y 40 px |
| `ovalo.png` (510×200) | barra y pie, al lado del muñeco | 26 y 30 px |

**El nombre ya no se escribe con texto en la barra ni en el pie**: era "LA
NIEVE" en la tipografía de la página y ahora es el óvalo rojo del cartel. Se
probó primero el logotipo entero ahí y no sirve: a 42 px de alto, "La Nieve"
adentro del óvalo queda en 5 px y no se lee. Separado en dos piezas —el muñeco
a 34 px y el óvalo a 26— se lee bien, y encima la marca ocupa **menos** ancho
que el texto que había (103 px contra 122), que en el celular es lo que
importa.

El `alt` del óvalo dice "La Nieve": el nombre del local tiene que seguir
estando para un lector de pantalla y para Google, aunque a la vista sea una
imagen.

`hacer-publicar.ps1` lo saca a archivo suelto igual que el logo, así que si se
agrega otra imagen embebida **hay que sumarla al `$mapa`**, si no queda un data
URI en el HTML de `docs/`. El script avisa al final cuántos quedaron: tiene que
decir 0.

Las imágenes llevan `width`/`height` con las medidas **reales** del archivo.
Cuando cambió el logo quedaron las del viejo (204×192 contra 244×300) y el
navegador reservaba mal el lugar: la página saltaba sola al terminar de cargar.

## Fotos de producto — el mecanismo ya está, faltan las fotos

Un producto de la `CARTA` lleva **`f:"archivo.webp"`** y la tarjeta le dibuja
la foto **al costado**, como miniatura cuadrada de 76 a 104 px. **Sin `f` la
tarjeta se dibuja igual**, sin hueco ni placeholder gris.

**La primera versión ponía la foto arriba, a lo ancho de la tarjeta, y estaba
mal.** Lo cazó Mateo mirándolo en el celular: la tarjeta pasaba de 140 px a
más de 400, o sea **un producto por pantalla en vez de cuatro**. Una carta se
recorre, no se contempla: la foto acompaña al nombre, no lo reemplaza. Con la
miniatura al costado la tarjeta pasa de 140 a 162 px y entran los cuatro.

De paso eso resolvió solo el problema de las fotos parciales: como con foto y
sin foto miden casi lo mismo, ya **no hace falta completar grupo por grupo**.

**Al tocar la miniatura se abre la foto grande** (`#visor`), con el nombre y la
descripción abajo. Cierra con Escape, con el botón o tocando afuera, y le
devuelve el foco a la miniatura que lo abrió.

**Las fotos NO van embebidas como data URI.** Van sueltas en `fotos/`, y
`hacer-publicar.ps1` las copia a `docs/fotos/`. Sesenta fotos embebidas dejarían
el HTML inservible. Van con `loading="lazy"` y `width`/`height` puestos, para
que el navegador reserve el lugar y la página no salte mientras bajan.

### De la foto del celular a la carta

1. Tirar las fotos crudas en **`fotos-originales/`** (está en el `.gitignore`:
   pesan 3 o 4 MB cada una y no van al repo).
2. Correr **`python3 hacer-fotos.py`**. Recorta al centro en 4:3, achica a
   900 px y guarda WebP calidad 82, en `fotos/`, con el mismo nombre.
   De ~4 MB a ~40 KB. Necesita Pillow (`pip install pillow`).
3. Agregar `f:"<archivo>.webp"` al producto en la `CARTA`.
4. Correr `hacer-publicar.ps1` como siempre.

El script respeta el `exif_transpose`: sin eso, las fotos verticales del celular
salen acostadas en la web y no se nota hasta que alguien las mira en el celular.

### Dos cosas para no olvidar

- **Al publicar el Artifact hay que mandar TODOS los archivos de `docs/`**, con el
  parámetro `files`: no solo `fotos/`, también `logo.png`, `logotipo.png`,
  `ovalo.png`, `icono.png`, `og.jpg`, `fachada.jpg` y `vitrina.jpg`. El Artifact
  es una página suelta: lo que no se manda, no existe. En GitHub Pages esto no
  pasa, ahí los copia el script.

  Ya me equivoqué una vez (16/09/2026, v29): publiqué el `docs/index.html` y solo
  las fotos de producto, y Mateo vio la portada llena de cuadraditos rotos. El
  motivo es fácil de pasar por alto: el `index.html` **de origen** lleva el logo y
  las fotos de fondo incrustadas dentro del HTML, así que se publica solo y
  funciona; el de `docs/` las tiene afuera, como archivos aparte, porque el script
  de publicar justamente las saca del HTML para que la página pese menos. Al
  cambiar de uno a otro hay que acordarse de llevar los archivos.

  La forma segura de armar la lista, sin ir a mano:

  ```bash
  cp -r docs/. <carpeta-de-publicar>/          # todo junto, tal cual sube a Pages
  find <carpeta-de-publicar> -type f           # y de ahí sale el mapa de files
  ```
- **La miniatura es un `<button>`, no un `<div>`.** Se puede tocar, así que
  tiene que llegarle el foco y el teclado, y anunciarse al lector de pantalla.

- **Cuidado con `visibility` en transición.** El visor abría con
  `transition:visibility .22s` y el foco no le llegaba al botón de cerrar:
  `visibility` no se desvanece, cambia de golpe y **por omisión a la mitad de
  la transición**, así que durante 110 ms el visor seguía invisible, y un
  elemento invisible ignora `focus()` sin dar ningún error. Se arregla con
  `visibility 0s` al abrir y `visibility 0s linear .22s` al cerrar. El
  `.overlay` del menú del celular tiene el mismo patrón viejo; hoy no molesta
  porque nadie le maneja el foco, pero si alguna vez se le maneja, es el
  mismo problema.

### Las fotos de Drive (16/09/2026)

Mateo subió **149 fotos** a la carpeta "La nieve" de su Drive, todas HEIC del
iPhone con nombre `IMG_XXXX`, sin ninguna pista de qué producto es cada una.

**Cómo se bajaron.** La red del entorno **bloquea `drive.google.com` y
`googleapis.com`**, así que no sirve `curl`: la única vía es la herramienta de
Drive, de a un archivo. Devuelve el contenido en base64 (2,6 a 4,3 MB de texto
por foto), que no entra en la conversación: el runtime lo guarda solo en un
archivo de `tool-results/` y de ahí lo levanta `procesar.py`, que lo convierte
a JPG y **borra el volcado**. Se pueden pedir 12 a 16 en paralelo.

**Ojo con el paralelismo**: el nombre del archivo de volcado lleva un
timestamp en milisegundos, y con 12 pedidos a la vez **dos pueden caer en el
mismo milisegundo y uno pisa al otro**. Por eso está `faltan.sh`, que compara
`ids.txt` contra lo convertido y lista lo que hay que volver a pedir.

**Cómo se identifican.** De a una es carísimo. `hoja.py` arma **hojas de
contacto** de 24 fotos numeradas: se miran 6 hojas en vez de 149 imágenes.

**La carpeta tiene muchísimas repeticiones**: hasta cinco tomas del mismo
producto (las fainás, por ejemplo). De 149 fotos salen unos 40 productos.

**Lo que se puede identificar mirando y lo que no.** Sale solo: zepelín (se ve
el relleno en el corte), pizza especial (jamón, morrón, huevo y aceitunas),
calabresa (la longaniza), flan, mousse, pasta frola (el enrejado), tarta de
frutilla, cheese cake. **No sale**: distinguir fugazzetta especial de
fugazzetta super, María Renée de torta especial, una pascualina de una tarta
de cebolla y queso vistas desde arriba, ni una fugazza (sin queso) de una
fugazzetta (con queso adentro) sin ver el corte. Esas hay que preguntarlas,
no adivinarlas.

### Las dos fuentes que dan el nombre junto a la foto

Mirar la foto sola lleva a equivocarse. Hay dos fuentes donde el producto
**viene con su nombre al lado**, y conviene consultarlas antes de asignar:

1. **Las capturas de Pedidos Ya** que mandó Mateo el 03/09/2026. Son fotos
   reales del local, cada una con su nombre, su descripción y su precio.
   Cubren pizzas, tartas, fainá, postres y promos. **No cubren** empanadas ni
   panes rellenos: esas solapas no se capturaron.
2. **La foto de la vitrina dulce** del 05/09/2026: cada torta tiene su cartel
   escrito a mano con el nombre y los ingredientes.

Las imágenes que manda Mateo no siempre quedan como archivo: las viejas están
**adentro del registro de la conversación**, en base64. Para sacarlas:

```bash
python3 fotos-del-chat.py            # lista qué imágenes hay, con su línea y su texto
python3 fotos-del-chat.py 716 873    # saca las de esas líneas a fotos-del-chat/
```

Las capturas de Pedidos Ya están en las **líneas 716 y 873**; la vitrina
dulce, en la **954**. Ojo: el script apunta al registro de *esta* sesión; si
cambia, hay que corregir la constante `REGISTRO` de arriba de todo.

### REGLA DEL DUEÑO: la comida no se recorta nunca

Mateo lo pidió el 16/09/2026 y vale para siempre: **ninguna foto de producto
puede quedar cortada**, ni la miniatura de la carta ni la del visor grande.

Hasta ese día se recortaba **dos veces**, y ninguna de las dos se veía en el
código a simple vista:

1. `hacer-fotos.py` hacía `ImageOps.fit` a 4:3. Como **casi todas las fotos
   del celular son verticales**, eso les comía cerca de la mitad.
2. La miniatura era un cuadrado (`aspect-ratio:1` + `object-fit:cover`), así
   que volvía a recortar lo que quedaba.

Ahora:

- `hacer-fotos.py` usa `thumbnail((900,900))`, que **achica y mantiene la
  proporción**. Nunca agranda y nunca corta. Cada foto queda con su forma:
  675x900 si es vertical, 900x675 si es horizontal.
- La miniatura lleva el ancho fijo y `height:auto`, así que se adapta.
- Como cada foto tiene su forma, el navegador ya no puede dar por hecho el
  alto. Por eso existe el bloque **`MEDIDAS`** de `index.html`, que
  `hacer-fotos.py` escribe solo entre `MEDIDAS-EMPIEZA` y `MEDIDAS-TERMINA`.
  **No editarlo a mano.** Si falta la medida de una foto, la tarjeta pega un
  salto cuando la imagen termina de cargar y el dedo toca el producto de al
  lado.

Si alguna vez hay que uniformar las miniaturas, la salida **no** es recortar:
es pedirle al dueño fotos con la misma orientación.

### Cómo se distingue una tarta de una pizza rellena

Lo pregunté el 16/09/2026 y Mateo lo confirmó en el local: en La Nieve las
**tartas saladas van en molde de pizza negro, cerradas, con el borde plegado
a mano** en pliegues gruesos alrededor de todo el canto. Vistas de arriba
parecen una pizza cerrada, y ese fue justamente el error que cometí antes de
preguntar: puse tartas donde iban pizzas.

La diferencia no está en el molde ni en la forma. Está en **el repulgue
plegado del borde** y en el corte: la tarta tiene tapa de masa fina arriba y
abajo, con el relleno entre las dos.

Con eso quedaron resueltas la pascualina (acelga con huevo entero a la
vista), la de pollo (pollo y cebolla, sin nada verde) y la de humita (los
granos de choclo se ven amarillos en el corte).

Lo que **sigue sin resolverse** mirando: la pascualina contra la pascualina
especial, que sólo se diferencian en que la especial lleva ricota. Eso hay
que preguntarlo.

### La misma foto puede volver con otro nombre

El 19/09/2026 Mateo mandó una foto rotulada "Tarta de albahaca". Era **la
misma toma** que había mandado el día anterior como "Pollo especial", y que
ya estaba cargada como `tarta-pollo-especial`: mismas manchas de horno,
mismas dos porciones en el mismo ángulo, mismas motas del granito. Cambiaba
sólo el encuadre, porque el chat la recomprime.

Dos cosas que dejó esto:

1. **Antes de asignar una foto nueva, compararla contra las que ya están.**
   Las fotos del Drive son de una sola visita, así que hay varias tomas del
   mismo producto y es fácil cargarlas dos veces con nombres distintos. Un
   `md5sum` no alcanza — el chat las recomprime y el hash cambia —; hay que
   mirarlas lado a lado.
2. **Cuando el rótulo pelea con lo que se ve, gana lo que se ve.** Esa tarta
   tiene el corte verde de hoja: no puede ser pollo especial. Y "Tarta de
   albahaca" no existe en la carta. Se lo planteé a Mateo con las tres
   salidas posibles y eligió la segunda: es la **Pascualina especial**, que
   era justamente la que faltaba y también lleva verde. El archivo pasó a
   llamarse `pascualina-especial` y **Tarta de pollo especial volvió a la
   lista de pendientes**.

### El flan casero, resuelto

El 19/09/2026 Mateo mandó la foto correcta: **nueve flanes individuales en
tarteras de aluminio**, sobre la bandeja. Nada que ver con el budín, que es
una pieza entera en molde savarín. Con eso queda cerrado el error del
16/09/2026, y ahora los dos se ven uno al lado del otro en "De la heladera",
bien distintos.

### Recortar el fondo sí, la comida no

La regla del dueño es que **la comida** no puede quedar cortada. Sacarle
mesada vacía a los costados no la viola: la comida sigue entera y encima se
ve más grande, que es justo lo que el dueño pidió para Postres.

La del flan venía 4:3 con casi un cuarto de granito muerto a la derecha. Se
recortó a 2009x1855 (de 2576x1932): entran los nueve flanes con margen, no
se toca ninguno. En la caja 3:4 de Postres la foto pasó de 900x675 a
900x831, así que llena bastante más.

Cuándo hacerlo: sólo si sobra fondo y **después de verificar el recorte
mirándolo**, con el rectángulo dibujado encima antes de aplicarlo. Nunca
automático, nunca para forzar una proporción. Si para llegar al 3:4 hay que
comerse un pedazo de comida, no se recorta y la foto queda con franjas: la
franja es el precio de la regla, y está bien pagarlo.

### Postres lleva la foto grande, el resto no

Lo pidió el dueño el 16/09/2026 y vale solo para esa solapa: en **Postres** la
foto va **arriba y a todo el ancho** de la tarjeta; en el resto de la carta
sigue de miniatura al costado.

No es una inconsistencia, es la diferencia entre las dos secciones. Una carta
de pizzas se **recorre**: el cliente ya sabe lo que es una muzzarella y lo que
busca es el precio, así que la miniatura al costado deja entrar tres o cuatro
productos por pantalla. Una vitrina de tortas se **mira**: nadie elige un
rogel por el nombre. Ahí la foto es el producto.

Cómo está hecho: `pintarCarta()` le pone la clase `fotos-grandes` a la grilla
cuando `seccion.tab === "Postres"`, y el CSS da vuelta la tarjeta a columna con
`order:-1` en la foto. **No hay que tocar `tarjeta()`**: arma siempre lo mismo
y el orden lo decide el CSS.

Dos detalles que costaron:

- La grilla lleva `align-items:start`. Sin eso, en una fila de tres, la
  tarjeta **sin** foto se estira hasta el alto de la que sí tiene y queda un
  hueco enorme entre el nombre y el precio.
- Por lo mismo, ahí `.precios` pierde el `margin-top:auto`, que es el que
  empuja el precio al fondo de la tarjeta.

Si algún día quieren la foto grande en otra solapa, se agrega el nombre de esa
solapa a la condición y listo. La regla de no recortar sigue valiendo: en
Postres una foto vertical hace la tarjeta más alta, y está bien.

### En Postres todas las fotos van en un cuadro 3:4

Las fotos del celular son casi todas verticales, pero algunas salieron
horizontales, y con la foto grande eso hacía tarjetas de alturas distintas:
la del cheese cake medía 413 y sus vecinas 608, con el hueco a la vista.

En Postres la foto va dentro de un cuadro fijo de **3:4** —la proporción de
una vertical de celular— con `object-fit:contain`. **Contain, no cover**: la
foto entra entera, no se recorta. Una horizontal deja aire arriba y abajo, y
ese aire lleva el color de la tarjeta, así que se lee como margen.

`cover` llenaría el cuadro sin bordes, pero recortando: está prohibido.

### En Postres, lo que no tiene foto va al final del grupo

Con la foto grande, una tarjeta sin foto mide 130 px y una con foto 600. Si
quedan mezcladas en la grilla de tres columnas, la chica deja **medio metro de
hueco** debajo. Por eso `pintarCarta()` reordena: en Postres primero los que
tienen `f`, después los que no. Solo en esa solapa, y solo para mirar — no
cambia ningún precio ni ningún nombre.

Cuando estén todas las fotos el reordenamiento no hace nada, porque no va a
quedar ninguna sin foto.

### Ojo con el budín de pan y el flan

Son parecidos de arriba: los dos salen del mismo molde con agujero, los dos
vienen nadando en caramelo oscuro. Puse una foto de budín en el **flan casero**
y Mateo lo cazó (16/09/2026).

Se distinguen **en el corte**: el budín tiene miga y **pasas de uva** adentro;
el flan es liso. La que era IMG_8697 de Drive tiene pasas: era budín.

### Todo lo que dice "Pedir" tiene que ir a Pedidos Ya

El botón **"Pedir ahora"** de la barra de arriba era el único que no lo hacía:
bajaba a la carta, como el de la portada. Decía una cosa y hacía otra, y Mateo
lo reportó como roto el 16/09/2026. Ahora lleva `data-py`, igual que los otros
catorce.

La regla, para no volver a mezclarlos:

- **Dice "Pedir"** → `data-py href="#" target="_blank" rel="noopener"`. El link
  real lo pone `$$("[data-py]")` desde la constante `PEDIDOS_YA`, así que el
  día que cambie el link se toca en **un solo lugar**.
- **Dice "Ver la carta"** → ancla común a `#carta`. Ese es el de la portada y
  está bien así.

En el celular el de la barra sigue oculto a propósito (`.nav-fin > .btn
{display:none}`): abajo está la barra fija de Pedidos Ya, siempre a la vista.

Para comprobarlo de una: buscar en el navegador todos los `<a>` cuyo texto diga
"pedir" y ver que el href tenga `pedidosya`. Son quince.

### El dominio propio: cómo está armado

**pizzerialanieve.com.ar**, en vivo desde el 18/09/2026. La cadena tiene tres
eslabones y conviene saber cuál toca cada uno:

1. **NIC.ar** — ahí se compró. NIC **no** guarda registros A: lo único que se
   configura es la **delegación**, o sea a qué servidores DNS responde el
   dominio. Apunta a los de Cloudflare.
2. **Cloudflare** — sirve el DNS, gratis. Tiene cargados los **cuatro
   registros A** del apex hacia `185.199.108.153`, `.109.153`, `.110.153` y
   `.111.153` (las IP de GitHub Pages), más un **CNAME `www` →
   `berchotmateo-spec.github.io`**.
3. **GitHub Pages** — publica desde `main` / `docs`, y lee `docs/CNAME` para
   saber qué dominio servir.

**Los registros van en "DNS only" (nube gris), nunca proxiados.** No es
estética: GitHub **renueva el certificado solo cada tres meses** y para eso
necesita alcanzar el dominio directo. Con el proxy de Cloudflare en el medio
esa validación puede fallar, y el síntoma aparece meses después, cuando el
certificado vence y el navegador muestra la pantalla de "sitio no seguro". A
cambio no se gana nada: GitHub ya da HTTPS y CDN. Si algún día se prende igual,
antes hay que pasar SSL/TLS de **Full** a **Full (strict)**.

**Si la web deja de responder en el dominio**, mirar en este orden: que
`docs/CNAME` siga existiendo (lo borra cualquiera que edite `docs/` a mano),
que los cuatro registros A sigan en gris, y que en Settings → Pages el dominio
siga escrito.

### Google: qué está hecho y qué falta

**Hecho el 18/09/2026, por Mateo:**

- **Search Console verificado** sobre `pizzerialanieve.com.ar`, como **propiedad
  de dominio** (no de prefijo de URL). Google lo verificó **solo**, por su
  integración con Cloudflare: no hubo código que copiar, agregó él mismo el
  registro TXT `google-site-verification=…`.
- **Sitemap enviado** y **indexación solicitada** para la portada.

**Dos cosas para no romper sin querer:**

1. **El TXT de verificación no se borra nunca.** Google lo revisa cada tanto,
   no solo la primera vez. Si desaparece, se pierde el acceso al panel.
   Borrar una propiedad en Search Console **no** toca el DNS, así que se puede
   limpiar el panel sin miedo.
2. **En una propiedad de dominio el sitemap se manda con la dirección
   completa**, `https://pizzerialanieve.com.ar/sitemap.xml`. Poner solo
   `sitemap.xml` da "Dirección de sitemap no válida": como la propiedad cubre
   todos los subdominios y los dos protocolos, Google no puede adivinar el
   prefijo.

**Lo que falta, y es del dueño, no nuestro:** el **Perfil de Empresa de
Google**. Para las búsquedas que de verdad traen gente a una pizzería —"la
nieve mar del plata"— lo que aparece primero es la ficha con el mapa, no la
web. Reclamarla, poner el sitio, las fotos y el horario vale más que cualquier
cosa que podamos tocar en el HTML.

### Un producto cerrado no afirma nada sobre su relleno

Los calentitos de panceta y de carne salen del horno cerrados: en la foto no
se ve qué tienen adentro. Mateo mandó dos tomas iguales y dijo que eligiera yo
cuál iba en cuál.

Se puede hacer, y no es inventar: la foto muestra **un calentito del local**,
que es exactamente lo que es. Como el relleno no se ve, la imagen no le está
diciendo al cliente nada que pueda ser falso. Distinto sería usar una foto
donde se viera panceta para el de carne — eso sí sería mentir.

La regla, entonces: **si el producto está cerrado y el relleno no se ve, una
toma cualquiera del mismo producto sirve**. Si algún día el dueño quiere que
se distingan, hace falta una foto abierta o cortada de cada uno.

### PROVISORIO: la foto de la pizza rellena

`pizza-rellena.webp` es **la única foto de la carta que no está confirmada por
el dueño.** Salió de una deducción mía que Mateo aceptó el 18/09/2026 con un
"de última lo modificamos si está mal".

Qué se sabe con certeza: **no es la pascualina** (no hay nada verde en el
corte), y **no es de la familia de las tartas** (va en bandeja de aluminio y
masa lisa, no en molde negro con el borde plegado a mano). En el corte hay
jamón, queso y una línea anaranjada que parece tomate, y el único producto de
la carta que encaja con eso es la pizza rellena.

**Si aparece alguien que sepa, preguntar por esta primero.** Son tres fotos del
mismo producto: la que mandó Mateo y las IMG_8628 e IMG_8630 del Drive, que
estaban sin nombre desde el principio.

**El antecedente que obliga a la cautela**: en este mismo proyecto ya puse
tartas donde iban pizzas, justamente por confiar en cómo se veían de arriba.

### Una foto puede ir en varios productos

No hace falta una foto por producto. Cuando por fuera son todos iguales, el
dueño usa una sola y se repite. Ya pasa en dos grupos, los dos por pedido de
Mateo:

- **`zepelin.webp`** en el súper, el variado y el de pollo. Es una bandeja con
  varios tipos mezclados, que es como salen.
- **`empanadas.webp`** en las **doce** empanadas (las ocho por unidad y las
  cuatro por docena). Cerradas y sin hornear del todo, el relleno no se ve:
  una foto sirve para todas.

En la carta no molesta porque la miniatura va al costado, chica. Si alguna vez
el dueño saca una foto propia de un producto, se le pone la suya y listo.

**Un error que ya cometí (16/09/2026).** Tenía puesta como *fainá común* una
foto de fainá **con muzzarella y orégano por encima** (IMG_8598). La captura
de Pedidos Ya lo dejó claro de una: la fainá común es lisa, dorada, sin nada
arriba (IMG_8607), tal como dice su propia descripción, "sin relleno". Con la
foto sola las dos parecen lo mismo; con el nombre al lado, no.

## PENDIENTE — lo que falta para terminar

0. ~~Horario~~ **RESUELTO el 11/09/2026**: el dueño confirmó **08:00 a 00:00,
   todos los días**. Está cargado en las **ocho** menciones de `index.html`, en
   `estadoLocal()` y en `publicar-cabecera.html`. Tres cosas que conviene saber
   si el horario vuelve a cambiar:

   - **Ojo al buscar: dos de las ocho menciones están escritas en palabras**,
     no en números — "de 8 de la mañana a medianoche", en la tarjeta "Abierto
     los 7 días" de Ventajas y en el último párrafo de "El local". Un
     `grep "08:00"` no las encuentra, y por eso quedaron sin corregir hasta el
     11/09. Buscar también por `madrugada`, `de la mañana` y `medianoche`.

   - **La fórmula de `estadoLocal()` depende de si el horario cruza la
     medianoche.** Cerrar a las 00:00 es cerrar al final del día, así que
     alcanza con `h >= 8`. Si alguna vez cierran **después** de medianoche (la
     versión vieja cerraba a la 01:00), hay que volver a
     `(h >= apertura || h < cierre)`. No es la misma cuenta.
   - En el JSON-LD el cierre va como **`"closes": "23:59"`**, no `"00:00"`, a
     propósito: con `opens` 08:00, un `closes` de 00:00 queda antes de la
     apertura y hay parsers que lo leen como que el local sigue abierto al día
     siguiente. `23:59` es la convención que no se presta a confusión.

1. ~~Precios de mostrador~~ **RESUELTO el 16/09/2026 con el rollo completo.**
   **No queda ni un producto sin precio en la carta.** Los rubros 07 a 16
   cerraron lo que faltaba: fainá (rubro 09), cerveza y vino (08 y 13), agua
   (07), sándwiches y calentitos (11), extras (14).

2. ~~Link de Pedidos Ya~~ **sigue abierto**: en la app hay **dos fichas** de La
   Nieve, la que usamos (`.../mar-del-plata/la-nieve-pizzeria-menu`) y otra bajo
   la zona Santa Celina. Confirmar con el dueño cuál atiende.

3. ~~Precios a re-chequear~~ **RESUELTOS**, con una corrección importante:

   - **`Fugazzín` era $5.200, no $2.200.** La duda estaba bien planteada: el
     precio leído del cartel a mano estaba mal y durante un día la web lo
     mostró a menos de la mitad. Lección: cuando un precio queda raro al lado
     de sus vecinos (el calentito sale $5.200 y son productos parecidos), **es
     raro de verdad**, no una ganga.
   - `Tarteleta` $4.200 y `empanadas de carne / jamón y queso` $2.700:
     confirmados, estaban bien.
   - `Cerveza Stella`: el sistema dice **lata de 500 cc, $6.000**. Se cambió el
     nombre y se sacó el "473 ml" que venía de Pedidos Ya.
   - `Fatay picante` $4.200, `fugazzetta roquefort` y `fugazzetta pepperoni`
     $32.000: aparecieron en el rollo y están cargados.
   - **Las nueve promos del pizarrón coinciden una por una** con el rubro 12
     ("promos para llevar"), Promo 1 incluida: **$44.000**, contra $49.900 en
     Pedidos Ya. El pizarrón estaba bien y la app cobra +13,4 %.
   - **Por qué la Promo 1 aparece dos veces en la app**: en el sistema está
     cargada con dos códigos, el 117 (`PROMO1 P/LLEVAR`) y el 901
     (`PRO 3 MUZZA ENT`), los dos a $44.000. No es un error de la app.
   - `Muzzarella`: sigue sin confirmar si lleva **aceitunas** (lo que dicen los
     televisores del salón, y lo que usa la web) u **orégano** (lo que dice
     Pedidos Ya). El rollo no trae descripciones, así que esto solo lo contesta
     el dueño.

3b. **Lo que el rollo trae y NO se cargó, esperando al dueño:**

   - **`POLBLAPROVO` $33.600** (media $16.800, porción $4.200). Falta el nombre.
   - ~~**`SANDWICH M Y Q` $6.500**~~ **RESUELTO el 16/09/2026**: es
     **milanesa y queso**. Mateo confirmó que el local hace sándwich de
     milanesa, y en la carpeta de Drive hay cuatro fotos (IMG_8572 a 8575) de
     pan casero con milanesa, jamón, tomate y queso. Eso también explica por
     qué había dos sándwiches a precios distintos: el de jamón y queso a
     $6.000 y este a $6.500. Cargado con el precio del rollo. **Falta que el
     dueño confirme cómo lo llama**, porque el nombre lo armé yo a partir de
     la abreviatura.
   - **`CALENTITO SAB` $5.900**: la abreviatura no se puede desarmar sin
     adivinar. `SAB` podría ser "sabroso", pero es una suposición.
   - **`CERVEZ STOUT/BO` $7.500**: no se sabe si es botella o qué formato. Sí se
     cargó la `LATA STOUT 500CC` a $5.500, que no tiene ambigüedad.
   - **Rubro 15, seis helados** a $2.400, $3.000, $3.100, $4.200, $4.500 y
     $7.800. Los seis se llaman "HELADO" en el sistema. Faltan los nombres.
   - **Rubro 10, "PROMOCIONES"**: ocho promos de $22.000 a $32.000, más una
     "PROMO INDIVIDUAL" de $6.700. **No son las del pizarrón** — esas son las
     del rubro 12. Preguntar qué son antes de mostrarlas.
   - **`ROSCA PASCUA` $27.000**: de temporada.
   - Códigos internos que no son productos: `BEBIDA S/C PROMO MUNDIAL` ($1),
     `DELIVERY`, `FUERA DE MENU 1 y 2`, `VINO 3/8` y `CERVEZA PORRON` (los dos

     sin precio cargado), y los genéricos `PORCION TORTA` / `PORC TORTA ESP`.
4. **Más fotos.** Ya están embebidas el logo, la fachada y la vitrina de tortas
   (ver "Fotos"). Falta la **vitrina de salados** (fainá, calentitos, fatay) — la
   foto existe pero no quedó guardada en disco. Cuando aparezca, iría como segunda
   imagen en "El local" o arriba de la pestaña "Del mostrador".
5. Zona de delivery y costo de envío: ya no los decide el local, los muestra Pedidos
   Ya al cargar la dirección. El FAQ lo dice así, sin inventar zonas.

6. ~~Reseñas~~ **LISTAS — probadas de punta a punta por Mateo el 14/09/2026.**
   Se deja una reseña en el sitio publicado, aparece sola al instante, y se
   borra desde el Table Editor. Ver "Reseñas" para cómo está armado.

   Ojo si hay que tocarlo de nuevo: **desde la sesión no se puede probar la
   conexión real**, la red del entorno bloquea `supabase.co` (403 del proxy).
   Lo que sí se puede es interceptar los pedidos en Chrome y responder como
   respondería Supabase: así se verifica qué URL, qué cabeceras y qué cuerpo
   salen, y qué hace la página con la respuesta. El ida y vuelta de verdad
   siempre lo tiene que confirmar Mateo.

   Dos cosas de contexto que conviene no perder:

   - **La Nieve ya tiene 4,3 ★ con más de 11.000 reseñas en Google** (dato de
     agregadores tipo Yelp/Wanderlog, **sin confirmar en la ficha directa** —
     la red de la sesión bloquea google.com). Se le propuso a Mateo aprovechar
     eso en vez de un sistema propio, pero **el dueño pidió expresamente
     reseñas en la web**, así que se hizo eso. Si alguna vez se quiere sumar,
     un bloque con la nota de Google y un botón "Dejanos tu reseña" convive
     bien con el formulario propio.
   - **Nada de reseñas inventadas** (regla del proyecto, ver "Decisiones de
     diseño"). La sección arranca vacía a propósito, con un estado de "todavía
     no hay reseñas". No cargar ninguna a mano para "que no se vea pelada".

## Reseñas

Sección `#resenas`, entre Preguntas y Contacto. El dueño pidió que la gente
deje reseñas **en la web** (no las de Google), así que se armó de cero.

### Los dos modos

El sitio es estático y GitHub Pages no guarda nada, así que las reseñas viven
en **Supabase** (plan gratis, se habla por HTTP común, sin librerías nuevas).
La configuración es la constante `RESENAS`, arriba de `CARTA`:

- **Con `url` y `clave` cargadas** → modo real. Se muestran sólo las reseñas
  con `aprobada = true`.
- **Vacías** → modo local: la reseña queda en el `localStorage` del visitante
  y no la ve nadie más. La página lo aclara con un cartel rojo que desaparece
  al cargar las claves. Sirve para mostrarle el sistema al dueño.

### Alta en Supabase — **YA HECHA** (14/09/2026)

Proyecto `cisswzxdgeeaapfbzuky`, tabla creada y claves cargadas en `RESENAS`.
Panel: https://supabase.com/dashboard/project/cisswzxdgeeaapfbzuky

Los pasos quedan escritos por si hay que rehacerlo o montar otro local:

1. Crear cuenta en supabase.com → **New project**. Anotar la contraseña.
2. **SQL Editor** → pegar y correr:

```sql
create table resenas (
  id        bigint generated always as identity primary key,
  nombre    text not null check (char_length(nombre) between 2 and 40),
  estrellas int  not null check (estrellas between 1 and 5),
  texto     text not null check (char_length(texto) between 10 and 500),
  fecha     timestamptz not null default now(),
  aprobada  boolean not null default false
);

alter table resenas enable row level security;

-- Cualquiera puede leer, pero sólo lo que está publicado.
create policy "leer aprobadas" on resenas
  for select to anon using (aprobada = true);

-- Cualquiera puede escribir. Se publica sola, pero sin links.
create policy "dejar resena" on resenas
  for insert to anon
  with check (
    aprobada = true
    and texto  !~* '(https?://|www\.|[a-z0-9-]+\.(com|net|org|ar|io|co|me|ly|info|shop|site|xyz)(/|[[:space:]]|$))'
    and nombre !~* '(https?://|www\.|[a-z0-9-]+\.(com|net|org|ar|io|co|me|ly|info|shop|site|xyz)(/|[[:space:]]|$))'
  );
```

> El `default` de `aprobada` arrancó en `false` (aprobar una por una) y se dio
> vuelta el 14/09/2026: el dueño de una pizzería no va a estar tildando
> casillas. Ahora se publica todo y se borra lo que moleste. La columna
> `aprobada` **queda igual**, pero cambia de rol: ya no es "aprobar para que
> salga", es un interruptor para **ocultar** algo sin borrarlo.

3. **Settings → API** → copiar *Project URL* y la clave **anon public**, y
   pegarlas en `RESENAS` en `index.html`. Regenerar `docs\` y commitear.

### Moderar

**Las reseñas se publican solas.** No hay nada que aprobar: el dueño no tiene
que entrar a menos que algo moleste. Cuando pasa, Supabase → **Table Editor**
→ tabla `resenas`, y sobre la fila:

- **Borrarla**: botón derecho → *Delete row*. Desaparece de la web al recargar.
- **Ocultarla sin borrarla**: destildar `aprobada`. Sirve cuando se quiere
  conservar el registro (por ejemplo, un reclamo real que ya se resolvió).

Vale la pena que Mateo le muestre esto al dueño una vez y le deje el link del
panel a mano. Son dos clics.

**Lo que frena el spam sin que nadie mire:**

1. **No se admiten links**, ni en el texto ni en el nombre. Casi todo el spam
   trae una dirección adentro. Se valida en el navegador (para avisarle a la
   persona con un mensaje claro) **y en la política de la base**, que es la
   que vale: lo del navegador se saltea con cuatro líneas de consola.
2. **Trampa para robots**: un campo escondido que la gente no ve. Si viene
   lleno, no se envía.
3. **Dos minutos de espera** entre envíos del mismo navegador.
4. Los `check` de la tabla: nombre de 2 a 40, texto de 10 a 500, estrellas
   de 1 a 5. Un cliente hecho a mano tampoco puede saltearlos.

Lo que **no** cubre nada de esto es un agravio escrito a mano por una persona.
Para eso está el borrado. Es la contracara de publicar sin revisar, y fue una
decisión tomada a propósito.

### Por qué está armado así

- **La clave pública es pública a propósito**: viaja al navegador de cualquiera.
  Lo que cuida los datos son las políticas RLS de arriba, no que la clave sea
  secreta. **Nunca** poner la `service_role` (o `secret`) en el HTML: esa
  saltea las políticas y deja la base abierta.
- **Hay dos formatos de clave y no se mandan igual.** La vieja es un JWT
  (arranca con `eyJ`) y va en `apikey` **y** en `Authorization: Bearer`. La
  nueva (`sb_publishable_...`, que es la que usamos) va **sólo** en `apikey`:
  si se la mete en `Authorization`, el servidor intenta leerla como JWT, no
  puede, y contesta 401. De eso se encarga `cabecerasResenas()`, que mira el
  prefijo de la clave. Si algún día se rota la clave y vuelve una `eyJ...`,
  funciona igual sin tocar nada.
- **El filtro de links vive en el `with check` de la política**, no sólo en el
  navegador. Cualquiera puede abrir la consola y saltear la validación de
  JavaScript; la de la base no.
- **Todo lo que escribe el visitante se pinta con `textContent`**, nunca con
  `innerHTML`. Es lo único que separa un campo de comentarios de dejar que
  cualquiera meta HTML en la página del cliente. Hay una prueba de esto.
- Contra el spam hay una **trampa para robots** (campo `web` escondido: si
  viene lleno, no se envía) y una **espera de 2 minutos** entre envíos del
  mismo navegador. No son a prueba de todo; el filtro de verdad es la
  aprobación manual.
- **En el Artifact las reseñas no cargan.** Ese visor bloquea los pedidos de
  red a dominios de afuera, así que contra Supabase no puede hablar. En GitHub
  Pages anda bien. Para mostrarle el sistema al dueño, usar el sitio publicado.
- **No marcar `aggregateRating` en el JSON-LD** con el promedio de estas
  reseñas: Google no admite que un negocio publique su propia calificación
  agregada y puede penalizar la ficha.

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
  horario 08:00–00:00, refrescado cada minuto.

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
  como `https://pizzerialanieve.com.ar` en `publicar-cabecera.html` y
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

## El carrusel de fotos del local

Lo pidió Mateo el 19/09/2026: el dueño le pasó fotos que quiere en la web.
Vive en la sección `#galeria`, entre "El local" y "Preguntas".

**Cómo se agrega una foto**, los tres pasos:

1. el archivo va a `fotos-originales/` con nombre `local-algo.jpg`
2. `python3 hacer-fotos.py`
3. una línea más en el array `GALERIA` de `index.html`

Las fotos del carrusel viven en `fotos/` como las de producto, a propósito:
los dos scripts de publicación ya copian esa carpeta entera, así que no hubo
que tocarlos. Y `hacer-fotos.py` les escribe la medida en `MEDIDAS`, que el
carrusel usa para reservar el lugar de cada una antes de bajarla.

**La regla de no recortar, resuelta al revés.** En la carta se fija el ancho
de la tarjeta y cada foto se lleva el alto que le pide su forma. En el
carrusel es al revés: la tira tiene **alto fijo** y cada foto se lleva el
**ancho** que le pide la suya. Una foto parada sale angosta, una acostada
sale ancha, y las dos entran enteras. Por eso `.marco img` va con
`height:100%;width:auto` y la tarjeta lleva el `aspect-ratio` puesto desde
JS: sin eso la tira pega un salto cada vez que una foto termina de cargar.

**Dos trampas que ya costaron una vuelta:**

- `.galeria-pie` tiene `display:flex`, que le gana al `display:none` del
  atributo `hidden`. Sin la regla `.galeria-pie[hidden]{display:none}` los
  controles se esconden "a medias": siguen ocupando lugar y se ven igual.
- El observador que marca el menú apagaba **todos** los enlaces al pasar por
  una sección que no está en el menú. Ahora, si ninguna coincide, deja lo
  último marcado.

Si `GALERIA` queda vacía la sección entera no aparece, así que nunca hay un
título con un hueco abajo. Y si entran todas las fotos de una en la pantalla,
las flechas y los puntos se esconden solos: no controlarían nada.

**Las fotos son las del dueño**, llegadas el 19/09/2026 en dos tandas. Son
ocho y todas del frente: cinco de noche (el cartel iluminado con las mesas
ocupadas, la cola en la puerta, la esquina llena, la galería techada con
lluvia, la esquina) y tres de día (la esquina, el frente y el cartel de
cerca). Van en ese orden a propósito: primero el bloque de noche, que es el
más fuerte, y después el de día. Las dos provisorias (fachada y vitrina) se
borraron al poner las primeras, no se sumaron.

**Lo que falta ahí: una foto de adentro.** Las ocho son del frente. Una del
mostrador, del horno o de la vitrina le daría variedad. Hay que pedírsela al
dueño.

Son las únicas fotos del local que no salieron del Drive de la visita de
Mateo: las dos de noche parecen de un fotógrafo. Si alguna vez hay que
recortarlas o retocarlas, preguntar antes.

### Deslizar la tira

Con el dedo la tira ya se corría sola desde el principio: eso lo hace el
navegador con `overflow-x:auto`, y lo hace mejor que cualquier cosa escrita a
mano — tiene inercia y frena como corresponde. **No hay que tocarlo.** Lo que
faltaba, y Mateo pidió el 19/09/2026, era poder **agarrarla con el mouse** en
la compu.

El arrastre se engancha sólo cuando el puntero **no es un dedo**
(`e.pointerType === "touch"` y se sale). Si no, pelearía con el scroll nativo
del celular y lo empeoraría.

Tres cosas que hubo que resolver, las tres reales:

1. **`setPointerCapture` rompe el clic.** Parece lo correcto para un arrastre,
   pero con la captura puesta el `click` que sigue al soltar le llega a la
   tira en vez de a la foto: tocar una foto dejaba de abrirla. La solución es
   no capturar y escuchar `pointermove`/`pointerup` en `window`, que además
   hace que el arrastre siga andando si el cursor se va de la tira.
2. **Distinguir arrastrar de clickear.** Si no, cada vez que alguien corre la
   tira se le abre la foto que tenía abajo. Se mide cuánto se movió y, si pasó
   de 6 px, un listener en fase de captura corta el clic antes de que llegue
   al botón.
3. **El navegador se lleva la imagen.** Al tirar de una foto arranca su propio
   arrastre de imagen y la tira se queda clavada. Por eso `img.draggable =
   false` y `user-select:none` mientras se arrastra.

**Lo que no se pudo probar acá:** el deslizar con el dedo. En este entorno el
navegador va sin pantalla y `Input.synthesizeScrollGesture` no mueve nada, ni
siquiera la página para abajo, así que el gesto táctil no se puede simular. Lo
que sí se verificó: que la tira llega al dedo con `touch-action:auto` y
`overflow-x:auto`, que de siete `touchmove` **ninguno** queda bloqueado por la
página, y que el código del arrastre no se activa con el dedo. O sea, nada de
lo que agregamos lo estorba. La prueba final es un celular de verdad.

Un detalle del carrusel que costó verlo: al principio de la tira, la foto
más cercana al centro de la pantalla puede ser la **segunda**, y el punto
marcado quedaba en el 2 con la tira sin mover. Por eso `actual()` devuelve
el primero o el último de una cuando la tira está en un extremo, en vez de
medir distancias al centro.

## El visor pasa fotos (el álbum)

Lo pidió Mateo el 19/09/2026 mirando la web en el celular: una vez abierta la
foto grande, quería poder deslizar ahí adentro para ir viendo las demás sin
volver a la página.

El visor ahora muestra un **álbum**: una lista de fotos. `abrirFoto(src,
nombre, detalle)` sigue existiendo igual que antes y abre un álbum de una
sola foto — por eso **las fotos de producto de la carta no cambiaron nada**:
sin flechas, sin cartelito, exactamente como estaban. Las del local llaman a
`abrirAlbum(albumGaleria(), i)` y traen las ocho.

Se pasa de cuatro maneras: con el dedo, arrastrando con el mouse, con las
flechas de los costados y con las teclas ← y →. Da la vuelta: de la última se
pasa a la primera.

**Acá el dedo SÍ se maneja a mano**, al revés que en la tira del carrusel. La
diferencia: en la tira hay un scroll de verdad, que el navegador hace mejor
que nosotros; en el visor no hay nada que scrollear, sólo un gesto que
significa "la que sigue". Por eso el visor lleva `touch-action:none`, que es
lo que hace que el gesto llegue al JavaScript en vez de que el navegador se
lo quede creyendo que es un scroll.

Detalles que importan:

- **`width:auto` en la imagen del visor.** Con `width:100%` una foto parada
  quedaba con dos franjas oscuras a los costados, porque el marco medía 880
  px y la foto no. Ahora el marco mide lo mismo que la foto.
- **Las flechas no se muestran en el celular** (`max-width:640px`): taparían
  la foto. Ahí se pasa con el dedo y el "3 / 8" de abajo dice en cuál va.
- **Se precargan la anterior y la siguiente** mientras el visitante mira la
  actual, así al pasar no queda un cuadro en blanco.
- Acá `setPointerCapture` **sí** va, al revés que en la tira: adentro del
  visor no hay ningún clic que quede mal apuntado, y la captura hace que el
  gesto siga si el dedo se va de la foto.
