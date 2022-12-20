# Multi-Array Processing for Adaptive Beamforming
## Scripts
Trois scripts sont fournis et sont accessibles depuis le dossier [src](./src):
1. [filtrage_spatial](./src/filtrage_spatial.m): génère un signal composé de sous-signaux ayant différents angles d'arrivé. Puis applique le filtrage spatial [CAPON](./src/fonctions/CAPON.m) pour retrouver les angles d'origine.

2. [sous-espace](./src/sous-espace.m): même idée que le [filtrage_spatial](./src/filtrage_spatial.m) mais applique la technique [MUSIC](./src/fonctions/MUSIC.m) qui se base sur les sous-espaces.

3. [on_ne_s_entend_plus](./src/on_ne_s_entend_plus.m): applique les algorithmes testés sur des données réelles pour isoler des conversations d'une même pièce captées par plusieurs micros.

## Documentation
Le [rapport](./doc/rapport.md) explique en détails les implémentations réalisées et analyse les résultats obtenus par les trois scripts. 
