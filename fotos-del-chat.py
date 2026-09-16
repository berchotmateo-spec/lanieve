# -*- coding: utf-8 -*-
"""
============================================================
  Recupera las fotos que Mateo mandó por chat
------------------------------------------------------------
  Las imágenes de una conversación no siempre quedan como
  archivo suelto: las viejas viven adentro del registro de la
  charla, en base64. Ahí están, por ejemplo, las capturas de
  Pedidos Ya, que son la fuente más confiable para saber qué
  producto es cada foto, porque traen el nombre al lado.

  Uso:
      python3 fotos-del-chat.py                 lista qué hay
      python3 fotos-del-chat.py 716 873 954     saca esas líneas

  Listar primero, mirar el texto que acompaña cada imagen para
  darse cuenta de cuál es cuál, y recién después sacar las que
  interesan. Van a parar a  fotos-del-chat/
============================================================
"""
import base64
import io
import json
import pathlib
import sys

# El registro de la conversación. Cambia por sesión: si no existe,
# buscar el .jsonl más nuevo dentro de ~/.claude/projects/.
REGISTRO = pathlib.Path(
    "/root/.claude/projects/-home-user-Pizzeria-la-nieve"
    "/7fc0d04f-74e0-51bc-927e-cfb2f9541df2.jsonl"
)
DESTINO = pathlib.Path(__file__).parent / "fotos-del-chat"


def recorrer():
    """Devuelve (nro_de_linea, imagen, texto) por cada imagen que mandó Mateo."""
    if not REGISTRO.exists():
        sys.exit("No encuentro el registro en %s.\n"
                 "Buscá el .jsonl más nuevo en ~/.claude/projects/ y corregí REGISTRO."
                 % REGISTRO)

    with io.open(REGISTRO, encoding="utf-8", errors="replace") as f:
        for i, linea in enumerate(f):
            # Filtro barato antes de parsear: el registro pesa cientos de MB.
            if '"image"' not in linea:
                continue
            try:
                d = json.loads(linea)
            except ValueError:
                continue
            msg = d.get("message") or {}
            if d.get("type") != "user" or not isinstance(msg.get("content"), list):
                continue
            partes = msg["content"]
            imgs = [c for c in partes
                    if isinstance(c, dict) and c.get("type") == "image"]
            if not imgs:
                continue
            txt = " ".join(c.get("text", "") for c in partes
                           if isinstance(c, dict) and c.get("type") == "text")
            for img in imgs:
                yield i, img, " ".join(txt.split()), (d.get("timestamp") or "")[:16]


def listar():
    n = 0
    for linea, img, txt, cuando in recorrer():
        src = img.get("source") or {}
        n += 1
        print("%3d | linea %-7d | %s | %-10s | %6.2f MB | %s"
              % (n, linea, cuando, src.get("media_type", "?"),
                 len(src.get("data") or "") * 3 / 4 / 1e6, txt[:120]))
    print("\n%d imágenes. Para sacar las de una línea:  python3 %s <linea> [linea...]"
          % (n, pathlib.Path(__file__).name))


def sacar(lineas):
    DESTINO.mkdir(exist_ok=True)
    n = 0
    for linea, img, _txt, _cuando in recorrer():
        if linea not in lineas:
            continue
        src = img["source"]
        n += 1
        salida = DESTINO / ("%02d.%s" % (n, src["media_type"].split("/")[-1]))
        salida.write_bytes(base64.b64decode(src["data"]))
        print("  ✓ %s  %d KB" % (salida, salida.stat().st_size // 1024))
    if not n:
        sys.exit("Ninguna de esas líneas tiene imágenes. Corré sin argumentos para ver la lista.")
    print("\n%d imágenes en %s/" % (n, DESTINO.name))


if __name__ == "__main__":
    if len(sys.argv) > 1:
        sacar({int(a) for a in sys.argv[1:]})
    else:
        listar()
