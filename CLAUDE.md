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

**El logotipo completo** —el óvalo rojo con "La Nieve" en amarillo— **no se
usa** en el sitio: la barra y el pie escriben "LA NIEVE" con la tipografía de
la página. Si alguna vez se quiere el óvalo de verdad, está en el archivo que
mandó el dueño, a la derecha del muñeco.

## Fotos de producto — el mecanismo ya está, faltan las fotos

Un producto de la `CARTA` lleva **`f:"archivo.webp"`** y la tarjeta le dibuja la
foto arriba, a sangre, en 4:3. **Sin `f` la tarjeta se dibuja igual**, sin hueco
ni placeholder gris: la carta funciona con fotos parciales.

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

- **Al publicar el Artifact hay que mandar también las fotos**, con el parámetro
  `files` (`{"fotos/x.webp": "fotos/x.webp", ...}`). El Artifact es una página
  suelta: si no van, se ven los alt y nada más. En GitHub Pages esto no pasa,
  ahí las copia el script.
- **Conviene completar por grupo, no de a una.** Cuando un grupo tiene fotos,
  las tarjetas pasan a medir lo que necesitan (`\.prods:has(.foto-prod)`), así
  que una sola con foto entre diez sin foto queda desprolija. Mejor terminar
  todas las pizzas, después todas las tortas.

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
   - **`CALENTITO SAB` $5.900** y **`SANDWICH M Y Q` $6.500**: las abreviaturas
     no se pueden desarmar sin adivinar.
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
