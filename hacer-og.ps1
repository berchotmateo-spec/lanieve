# ============================================================
#  Genera docs\og.jpg y docs\icono.png
#  ------------------------------------------------------------
#  og.jpg (1200x630) es la tarjeta que aparece cuando alguien
#  comparte el link por WhatsApp, Facebook o Instagram.
#  icono.png (180x180) es el icono de la pestaña del navegador
#  y de la pantalla de inicio del celular.
#
#  Lee docs\fachada.jpg y docs\logo.png, asi que correr
#  esto DESPUES de que esas dos existan.
#
#      powershell -File hacer-og.ps1
# ============================================================

Add-Type -AssemblyName System.Drawing

$raiz = Split-Path -Parent $MyInvocation.MyCommand.Path
$dir  = Join-Path $raiz "docs"

$W = 1200
$H = 630

$card = New-Object System.Drawing.Bitmap -ArgumentList $W, $H
$g = [System.Drawing.Graphics]::FromImage($card)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

# Banda horizontal de la fachada. Arranca en y=520 porque ahi entran
# el cartel de La Nieve, el toldo del "desde 1949" y el frente del local.
$fach = [System.Drawing.Image]::FromFile((Join-Path $dir "fachada.jpg"))
$ratio = [double]$W
$ratio = $ratio / [double]$H
$bandH = [int][math]::Round([double]$fach.Width / $ratio)
$srcRect = New-Object System.Drawing.Rectangle -ArgumentList 0, 520, $fach.Width, $bandH
$dstRect = New-Object System.Drawing.Rectangle -ArgumentList 0, 0, $W, $H
$g.DrawImage($fach, $dstRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
$fach.Dispose()

# Dos degradados oscuros encima: uno largo y otro mas corto sobre el tercio
# de abajo, que es donde va el texto y donde la foto es mas clara.
$scrimRect = New-Object System.Drawing.Rectangle -ArgumentList 0, 140, $W, 490
$c1 = [System.Drawing.Color]::FromArgb(0, 26, 16, 12)
$c2 = [System.Drawing.Color]::FromArgb(252, 26, 16, 12)
$brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush -ArgumentList $scrimRect, $c1, $c2, ([System.Drawing.Drawing2D.LinearGradientMode]::Vertical)
$g.FillRectangle($brush, $scrimRect)
$brush.Dispose()

$scrim2 = New-Object System.Drawing.Rectangle -ArgumentList 0, 350, $W, 280
$d1 = [System.Drawing.Color]::FromArgb(0, 26, 16, 12)
$d2 = [System.Drawing.Color]::FromArgb(205, 26, 16, 12)
$brush2 = New-Object System.Drawing.Drawing2D.LinearGradientBrush -ArgumentList $scrim2, $d1, $d2, ([System.Drawing.Drawing2D.LinearGradientMode]::Vertical)
$g.FillRectangle($brush2, $scrim2)
$brush2.Dispose()

$logo = [System.Drawing.Image]::FromFile((Join-Path $dir "logo.png"))
$lh = 172
$lw = [int][math]::Round([double]$lh * [double]$logo.Width / [double]$logo.Height)
$logoY = $H - 62 - $lh
$g.DrawImage($logo, 62, $logoY, $lw, $lh)
$logo.Dispose()

# Plus Jakarta Sans no esta instalada en Windows; para la tarjeta alcanza Segoe UI.
try { $fam = New-Object System.Drawing.FontFamily -ArgumentList "Segoe UI" }
catch { $fam = [System.Drawing.FontFamily]::GenericSansSerif }

$tx = 62 + $lw + 30
$px = [System.Drawing.GraphicsUnit]::Pixel
$fTit = New-Object System.Drawing.Font -ArgumentList $fam, 82, ([System.Drawing.FontStyle]::Bold), $px
$fSub = New-Object System.Drawing.Font -ArgumentList $fam, 31, ([System.Drawing.FontStyle]::Bold), $px
$fPie = New-Object System.Drawing.Font -ArgumentList $fam, 26, ([System.Drawing.FontStyle]::Regular), $px

$blanco   = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::White)
$amarillo = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 199, 44))
$suave    = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(215, 255, 255, 255))

$g.DrawString("La Nieve", $fTit, $blanco, $tx, 398)
$g.DrawString("Pizza al molde desde 1949", $fSub, $amarillo, ($tx + 4), 494)
$g.DrawString("Rivadavia 3002, esq. La Rioja - Mar del Plata", $fPie, $suave, ($tx + 4), 538)

# Raya amarilla de marca al pie de la tarjeta.
$g.FillRectangle($amarillo, 0, ($H - 9), $W, 9)
$g.Dispose()

$codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
$ep = New-Object System.Drawing.Imaging.EncoderParameters -ArgumentList 1
$ep.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter -ArgumentList ([System.Drawing.Imaging.Encoder]::Quality), ([int64]82)
$card.Save((Join-Path $dir "og.jpg"), $codec, $ep)
$card.Dispose()

# Icono cuadrado, con el logo centrado y un poco de aire alrededor.
$logo2 = [System.Drawing.Image]::FromFile((Join-Path $dir "logo.png"))
$S = 180
$ico = New-Object System.Drawing.Bitmap -ArgumentList $S, $S, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gi = [System.Drawing.Graphics]::FromImage($ico)
$gi.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$escala = [double]($S - 16)
$escala = $escala / [double]$logo2.Height
$iw = [int][math]::Round([double]$logo2.Width * $escala)
$ih = [int][math]::Round([double]$logo2.Height * $escala)
$gi.DrawImage($logo2, [int](($S - $iw) / 2), [int](($S - $ih) / 2), $iw, $ih)
$gi.Dispose()
$ico.Save((Join-Path $dir "icono.png"), [System.Drawing.Imaging.ImageFormat]::Png)
$ico.Dispose()
$logo2.Dispose()

Write-Output "Listo: og.jpg e icono.png regenerados."
