"""Recolor the grayscale anime-girl fastfetch logo to a blue palette.

Reads logo-anime.raw, maps every truecolor fg/bg pair (which is grayscale,
r==g==b) onto a blue gradient, writes logo-anime-blue.raw.
"""
import re

SRC = '/home/flash/.config/fastfetch/logo-anime.raw'
DST = '/home/flash/.config/fastfetch/logo-anime-blue.raw'

# blue gradient: dark navy -> mid blue -> light sky -> near-white (highlight)
STOPS = [
    (8, 12, 36),   # deep night blue
    (16, 32, 82),  # navy
    (28, 58, 138), # blue
    (52, 98, 190), # bright blue
    (98, 148, 228),# sky
    (158, 196, 244),# pale
    (214, 232, 252),# near white-blue
    (255, 255, 255),
]

def lum_to_rgb(v):
    t = v / 255 * (len(STOPS) - 1)
    i = int(t)
    if i >= len(STOPS) - 1:
        return STOPS[-1]
    f = t - i
    a, b = STOPS[i], STOPS[i + 1]
    return tuple(round(a[c] + (b[c] - a[c]) * f) for c in range(3))

def map_color(m):
    r, g, b = int(m.group(1)), int(m.group(2)), int(m.group(3))
    v = (r + g + b) / 3  # grayscale source: luminance
    nr, ng, nb = lum_to_rgb(v)
    return f'\x1b[{m.group(0)[2:5]}{nr};{ng};{nb}m'

data = open(SRC).read()
out = re.sub(r'\x1b\[(38|48);2;(\d+);(\d+);(\d+)m',
             lambda m: f'\x1b[{m.group(1)};2;{lum_to_rgb((int(m.group(2)) + int(m.group(3)) + int(m.group(4))) / 3)[0]};{lum_to_rgb((int(m.group(2)) + int(m.group(3)) + int(m.group(4))) / 3)[1]};{lum_to_rgb((int(m.group(2)) + int(m.group(3)) + int(m.group(4))) / 3)[2]}m',
             data)
open(DST, 'w').write(out)

# verify: count saturated blue pixels in output
blue = len(re.findall(r'\x1b\[[34]8;2;(\d+);(\d+);(\d+)m', out))
blue_px = 0
for mm in re.finditer(r'\x1b\[[34]8;2;(\d+);(\d+);(\d+)m', out):
    r, g, b = int(mm.group(1)), int(mm.group(2)), int(mm.group(3))
    if b > r + 20 and b > 40:
        blue_px += 1
print(f'wrote {DST}: {len(out)} bytes, {blue} color codes, {blue_px} blue-tinted')
