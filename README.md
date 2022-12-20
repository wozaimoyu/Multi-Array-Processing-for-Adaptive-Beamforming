# Multi Array Processing for Adapttive Beamforming
## Scripts
Trois scripts sont fournis et sont accessibles depuis le dossier [src](./src):
1. [filtrage_spatial](./src/filtrage_spatial.m): génère un signal composé de sous-signaux ayant différents angles d'arrivés. Puis applique le filtrage spatial [CAPON](./src/fonctions/CAPON.m) pour retrouver les angles d'origine.

2. [sous-espace](./src/sous-espace.m): même idée que [filtrage_spatial](./src/filtrage_spatial.m) mais applique la technique [MUSIC](./src/fonctions/MUSIC.m) qui se base sur les sous-espaces.

3. [on_ne_s_entend_plus](./src/on_ne_s_entend_plus): applique les algorithmes testés sur des données réelles pour isoler des conversations d'une même pièce captées par plusieurs micros.

## Documentation
Le [rapport](./doc/rapport) explque plus en détails les implémentations réalisées et analyse les résultats obtenus par les trois scripts fournis. 
