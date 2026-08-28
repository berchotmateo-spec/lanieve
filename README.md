# Pizzería La Nieve — sitio web

Sitio de una página para la **Pizzería La Nieve**, Rivadavia 3002 esq. La Rioja,
Mar del Plata. Pizza al molde desde 1949.

La carta y las promos son las reales del local, relevadas en persona el 26/08/2026
de los televisores del salón, el pizarrón de la vereda y las vitrinas del mostrador.

**En vivo:** https://berchotmateo-spec.github.io/lanieve/

> Se publica con GitHub Pages desde la carpeta `docs/` de la rama `main`
> (*Settings → Pages → Source: Deploy from a branch → main / docs*).

## Qué hace

- Carta completa con precios: pizzas enteras y por porción, empanadas, fainá,
  la vitrina del mostrador y los postres.
- Buscador que filtra las cuatro pestañas a la vez.
- Las nueve "súper promos" del pizarrón.
- **Pedido por WhatsApp**: se arma tocando el `+` de cada producto y genera el
  mensaje con el detalle, el total y el tipo de entrega. El pedido queda guardado
  en `localStorage` entre visitas.
- Cartel de "Abierto ahora / Cerrado" calculado contra el horario 08:00–01:00.

Sin dependencias, sin build, sin framework. HTML, CSS y JavaScript a mano.

## Estructura

| | |
|---|---|
| `index.html` | El sitio entero en un archivo, con el logo y las fotos embebidas como data URI. Se abre con doble clic. |
| `docs/` | La misma página lista para publicar: el HTML baja a ~64 KB y las imágenes van sueltas, así el celular pinta la página sin esperarlas. Es lo que sirve GitHub Pages. **Generada** — no editar a mano. |
| `hacer-publicar.ps1` | Arma `docs/` a partir de `index.html`. Correr después de cada cambio. |
| `hacer-og.ps1` | Genera la imagen de vista previa para compartir y el ícono. |
| `publicar-cabecera.html` | El `<head>` de la versión publicada: título, descripción, Open Graph y la ficha JSON-LD para Google. |
| `index-v1-pizarron.html`, `index-v2-azul.html` | Versiones anteriores del diseño. |
| `CLAUDE.md` | Notas del proyecto: decisiones de diseño, datos del local y qué falta. |

## Actualizar la carta

Todo vive en el array `CARTA`, al final del `<script>` de `index.html`. No hace
falta tocar HTML ni CSS:

```js
{ n:"Muzzarella", d:"Salsa, muzzarella y aceitunas.", p:16000 }
//  n = nombre     d = descripción (puede ir "")       p = precio, número entero
```

El campo `n` es la clave del pedido: no puede repetirse en toda la carta.

Después de editar:

```
powershell -File hacer-publicar.ps1
```

Los detalles están en [CLAUDE.md](CLAUDE.md).
