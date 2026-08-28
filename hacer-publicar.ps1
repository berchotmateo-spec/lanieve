# ============================================================
#  Arma la carpeta publicar\ a partir de index.html
#  ------------------------------------------------------------
#  index.html es la version de un solo archivo (la del Artifact):
#  lleva el logo y las dos fotos embebidas como data URI.
#
#  Para hosting eso es peor: el navegador no puede pintar nada
#  hasta bajar los 730 KB enteros. Asi que aca las imagenes se
#  sacan a archivos sueltos, y el HTML queda en ~65 KB.
#
#  Correr despues de cada cambio en index.html:
#      powershell -File hacer-publicar.ps1
# ============================================================

$raiz = Split-Path -Parent $MyInvocation.MyCommand.Path
$dest = Join-Path $raiz "publicar"
$sitio = "https://lanieve-mdp.netlify.app"

$html = [System.IO.File]::ReadAllText((Join-Path $raiz "index.html"), [System.Text.Encoding]::UTF8)

# Las mismas imagenes que estan embebidas viven tambien sueltas en publicar\.
# Reconstruimos su data URI para poder cambiarla por el nombre de archivo.
function Get-Uri([string]$archivo, [string]$tipo) {
  $bytes = [System.IO.File]::ReadAllBytes((Join-Path $dest $archivo))
  return "data:image/$tipo;base64," + [Convert]::ToBase64String($bytes)
}

$mapa = @(
  @{ uri = (Get-Uri "logo.png"    "png");  archivo = "logo.png" },
  @{ uri = (Get-Uri "fachada.jpg" "jpeg"); archivo = "fachada.jpg" },
  @{ uri = (Get-Uri "vitrina.jpg" "jpeg"); archivo = "vitrina.jpg" }
)

foreach ($img in $mapa) {
  if (-not $html.Contains($img.uri)) {
    Write-Warning ("No encontre embebida la imagen {0}. Quedo un data URI sin reemplazar." -f $img.archivo)
    continue
  }
  $html = $html.Replace($img.uri, $img.archivo)
}

# Las 5 primeras lineas de index.html (title, viewport y las fuentes) las
# reemplaza la cabecera, que ademas trae las etiquetas de Google y de WhatsApp.
$lineas = $html -split "`r?`n"
$cuerpo = ($lineas[5..($lineas.Length - 1)]) -join "`n"

$cabecera = [System.IO.File]::ReadAllText((Join-Path $raiz "publicar-cabecera.html"), [System.Text.Encoding]::UTF8)
$salida = $cabecera + $cuerpo + "`n</body>`n</html>`n"

$utf8 = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText((Join-Path $dest "index.html"), $salida, $utf8)

$robots = "User-agent: *`nAllow: /`n`nSitemap: $sitio/sitemap.xml`n"
[System.IO.File]::WriteAllText((Join-Path $dest "robots.txt"), $robots, $utf8)

$hoy = (Get-Date).ToString("yyyy-MM-dd")
$sitemap = @"
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>$sitio/</loc>
    <lastmod>$hoy</lastmod>
    <changefreq>monthly</changefreq>
  </url>
</urlset>
"@
[System.IO.File]::WriteAllText((Join-Path $dest "sitemap.xml"), $sitemap, $utf8)

Write-Output "Listo. Contenido de publicar\:"
Get-ChildItem $dest | Sort-Object Name | Select-Object Name, @{n = "KB"; e = { [math]::Round($_.Length / 1KB, 1) } }
$quedan = ([regex]::Matches($salida, "data:image/")).Count
Write-Output ("data URI que quedaron en el HTML: {0} (tiene que ser 0)" -f $quedan)
