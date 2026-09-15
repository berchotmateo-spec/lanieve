# -*- coding: utf-8 -*-
"""
============================================================
  Prepara las fotos de producto para la carta
------------------------------------------------------------
  Las fotos salen del celular pesando 3 o 4 MB cada una. Sesenta
  de esas son 200 MB: la página no cargaría nunca en la calle,
  con datos móviles.

  Este script las deja en ~40 KB sin que se note la diferencia
  en pantalla: recorta al centro en 4:3, achica a 900 px de ancho
  y guarda en WebP.

  Uso:
      python3 hacer-fotos.py

  Lee todo lo que haya en  fotos-originales/
  y escribe el resultado en  fotos/

  El nombre del archivo se mantiene: si entra "muzzarella.jpg",
  sale "muzzarella.webp", y en la carta el producto lleva
  f:"muzzarella.webp".
============================================================
"""
import pathlib
import sys

try:
    from PIL import Image, ImageOps
except ImportError:
    sys.exit("Falta Pillow. Instalalo con:  pip install pillow")

RAIZ = pathlib.Path(__file__).parent
ORIGEN = RAIZ / "fotos-originales"
DESTINO = RAIZ / "fotos"

ANCHO = 900          # suficiente para verse nítida en cualquier pantalla
PROPORCION = 4 / 3   # la misma que usa la tarjeta en la carta
CALIDAD = 82         # arriba de esto el archivo crece y la foto no mejora

EXTENSIONES = {".jpg", ".jpeg", ".png", ".webp", ".heic", ".HEIC"}


def main():
    if not ORIGEN.is_dir():
        ORIGEN.mkdir()
        sys.exit("Creé la carpeta %s. Poné ahí las fotos y volvé a correrme." % ORIGEN.name)

    DESTINO.mkdir(exist_ok=True)
    fotos = sorted(f for f in ORIGEN.iterdir() if f.suffix.lower() in EXTENSIONES)
    if not fotos:
        sys.exit("No hay fotos en %s." % ORIGEN.name)

    alto = round(ANCHO / PROPORCION)
    pesaban = pesan = 0

    for foto in fotos:
        salida = DESTINO / (foto.stem + ".webp")
        try:
            with Image.open(foto) as img:
                # Respeta la orientación con la que se sacó la foto: sin esto,
                # las verticales del celular salen acostadas.
                img = ImageOps.exif_transpose(img)
                img = img.convert("RGB")
                # Recorta al centro y achica en un solo paso.
                img = ImageOps.fit(img, (ANCHO, alto), Image.LANCZOS, centering=(0.5, 0.5))
                img.save(salida, "WEBP", quality=CALIDAD, method=6)
        except Exception as e:
            print("  ✗ %s — %s" % (foto.name, e))
            continue

        antes, ahora = foto.stat().st_size, salida.stat().st_size
        pesaban += antes
        pesan += ahora
        print("  ✓ %-34s %6.1f MB → %5.0f KB" % (salida.name, antes / 1e6, ahora / 1e3))

    print("\n%d fotos · %.1f MB → %.1f MB" % (len(fotos), pesaban / 1e6, pesan / 1e6))
    print("Ahora agregá  f:\"<archivo>.webp\"  al producto en la CARTA de index.html.")


if __name__ == "__main__":
    main()
