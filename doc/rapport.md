# Multi Array Processing for Adaptive Beamforming

<p align="center">
     <img src="https://github.com/Adrial-Knight/Multi-Array-Processing-for-Adaptive-Beamforming/blob/main/doc/fig/Logo_ENSEIRB-MATMECA-Bordeaux_INP.svg" width=50% height=50% title="Logo ENSEIRB">
</p>

[1. Localisation par filtrage spatial](#localisation-par-filtrage-spatial)\
       [1.1 Principes](#principes)\
       [1.2 Energie estimée sur une source](#energie-estimee-sur-une-source)\
       [1.3 Séparation de plusieurs sources](#Separation-de-plusieurs-sources)\
[2. Localisation par la méthode des sous-espaces](#localisation-par-la-methode-des-sous-espaces)\
       [2.1 Principes](#principes)\
       [2.2 Estimation visuelle du nombre de sources](#estimation-visuelle-du-nombre-de-sources)\
       [2.3 Comparaison avec la méthode CAPON](#comparaison-avec-la-methode-capon)\
[3. On ne s’entend plus !](#decodage-mmse)


## Localisation par filtrage spatial

### Principes
La localisation consiste à estimer un angle d'élévation pour chacune des sources arrivant sur un système multi-antennes. Pour y parvenir, un filtre spatial est mis en place sur l'ensemble des antennes afin d'en concentrer l'écoute selon une direction particulière. Dès lors, toutes les directions possibles sont passées en revue une à une afin d'en étudier leurs puissances respectives. Une fois la fonction de la puissance selon la direction établie, il ne reste plus qu'à en étudier les maximums locaux. Leurs arguments indiquent la position des sources recherchées.

Les méthodes existantes diffèrent sur le filtre spatial utilisé. Dans le cadre de la méthode CAPON, celui-ci minimise la puissance globale du signal à l'exception d'une direction d'intérêt $\theta$. Il est la solution du problème d'optimisation suivant:

$$
    \min_{\textbf{w} \in C} \mathbb{E}|\textbf{w}^* \textbf{y}_n|^2 \quad \text{sous la contrainte} \quad C = \{\textbf{w} \in \mathcal{C}^M: |\textbf{w}^*\textbf{a}(\theta)| = 1\}
$$

où $\textbf{y}_n$ désigne l'ensemble des observations sur l'ensemble des $M$ capteurs, et $\textbf{a}(\theta)$ le vecteur directionnel défini par $\textbf{a}(\theta) = [1, \exp(-i\pi\sin(\theta)), ..., \exp(-i\pi(M-1)\sin(\theta))]^T$.


### Energie estimee sur une source
La figure suivante donne l'énergie estimée à la sortie du filtre de CAPON selon pour une plage d'angle allant de 0 à 90 degrés. L'angle de la source se retrouve grâce au pic d'énergie observé.
<p align="center">
     <img src="https://github.com/Adrial-Knight/Multi-Array-Processing-for-Adaptive-Beamforming/blob/main/doc/fig/q2.svg" width=50% height=50% title="Energie estimée selon l'élevation">
</p>

Lorsque la quantité de capteurs augmente, le vecteur directionnel $\textbf{a}(\theta)$ se compose de plus d'éléments. La résolution augmente en conséquence. Sur les figures ci-dessous, le nombre de capteurs a été quadruplé; et l'incertitude autour de l'angle d'élévation de la source a significativement diminué.
<p align="middle">
     <img src="https://github.com/Adrial-Knight/Multi-Array-Processing-for-Adaptive-Beamforming/blob/main/doc/fig/q2.svg" width=45% height=45% title="Influence de la quantité de capteurs, M=5">
     <img src="https://github.com/Adrial-Knight/Multi-Array-Processing-for-Adaptive-Beamforming/blob/main/doc/fig/q3.svg" width=45% height=45% title="Influence de la quantité de capteurs, M=20">
</p>


### Separation de plusieurs sources
#### Nombre minimal de capteurs
Lorsque plusieurs sources parviennent au réseau d'antennes, il est possible de les distinguer si elles sont suffisamment éloignées les unes des autres ou lorsque la quantité de capteurs assure une résolution suffisante. Par exemple, dans le cas de deux sources distinctes de 5° et de même énergie, il est nécessaire de disposer d'au moins 12 sources. La prochaine figure présente deux maximas locaux atteints aux alentours des valeurs 40° et 45° permettant l'identification des deux sources générées.
<p align="center">
     <img src="https://github.com/Adrial-Knight/Multi-Array-Processing-for-Adaptive-Beamforming/blob/main/doc/fig/q2.svg" width=50% height=50% title="Séparation de deux sources">
</p>

#### Niveau d’énergie différent
Lorsqu'une source possède une énergie plus importante, elle vient perturber la détection des autres. Sur la figure qui suit, la source en 50° degrés est 10 fois plus énergétique que la seconde. L'analyse des résultats, sans connaissances à priori sur le nombre de sources, peut alors être erronée en catégorisant la source faible énergie comme bruit.
<p align="center">
     <img src="https://github.com/Adrial-Knight/Multi-Array-Processing-for-Adaptive-Beamforming/blob/main/doc/fig/q5.svg" width=50% height=50% title="Sensibilité à la puissance des sources">
</p>

#### Influence du bruit
En faisant varier la puissance du bruit, la sensibilité du réseau d'antenne diminue car l'énergie apportée par ce bruit crée des sources factices. La prochaine figure illustre ce phénomène avec un niveau de bruit de croissant autour de deux sources de même puissance.
<p align="center">
     <img src="https://github.com/Adrial-Knight/Multi-Array-Processing-for-Adaptive-Beamforming/blob/main/doc/fig/q6.svg" width=50% height=50% title="Perte de sensibilité">
</p>



## Localisation par la methode des sous-espaces
### Principes
Le signal reçu sur les $M$ antennes forme un espace de dimension M. Si ce nombre de dimensions est supérieur au nombre de sources ($K$) alors il existe une représentation de l'espace dans laquelle les sources du signal sont séparables. L'objectif est donc de caractériser un sous-espace signal dont chaque vecteur directeur représente une unique source. Pour cela, une hypothèse supplémentaire est ajoutée: la matrice de covariance du signal est de rang plein. Ainsi, les cas d'écho, de multi-trajet et de sources cohérentes ne sont pas considérés. Enfin, le sous-espace complémentaire de dimension $(M-K$) représente le bruit.

Les sous-espaces se caractérisent par les valeurs propres de la matrice de covariance du signal reçu. En particulier, le sous-espace bruit est engendré par les $(M-K)$ vecteurs propres associés aux valeurs propres les moins énergétiques. Dans le cadre de la méthode MUSIC, l'objectif est de projeter des vecteurs directionnels $\textbf{a}(\theta)$ sur ce sous-espace bruit. Les résultats les plus faibles en norme sont ensuite repérés. Ils traduisent la présence d'une source sur les directions associées au vecteur $\textbf{a}(\theta)$.

### Estimation visuelle du nombre de sources
Pour estimer le nombre de sources, une méthode simple consiste à tracer le spectre de la matrice de covariance estimée du signal. On repère alors un point de rupture entre les valeurs propres afin de former deux groupes. Le nombre de valeurs propres dans le groupe le plus énergétique est interprété comme le nombre de sources.

Avoir une idée de la variance du bruit aide, car les valeurs propres faibles sont de cette ordre de grandeur. Sur la figure suivante, nous sommes en mesure de tracer la délimitation en seuillant à 5 fois la variance du bruit. Le nombre de source est alors évaluée à 8.
<p align="center">
     <img src="https://github.com/Adrial-Knight/Multi-Array-Processing-for-Adaptive-Beamforming/blob/main/doc/fig/estimation_source.svg" width=50% height=50% title="Estimation du nombre de source">
</p>


### Comparaison avec la methode CAPON
#### Nombre minimal de capteurs
Avec la méthode MUSIC, il est possible de séparer deux sources avec seulement 7 capteurs contre 12 pour la méthode CAPON. Ce résultat est établi à partir de la figure qui suit où deux minimums locaux se distinguent.
<p align="center">
     <img src="https://github.com/Adrial-Knight/Multi-Array-Processing-for-Adaptive-Beamforming/blob/main/doc/fig/nombre_cap_MUSIC.svg" width=50% height=50% title="Séparation de deux sources (MUSIC)">
</p>

#### Résistance au bruit
La prochaine figure compare les méthodes MUSIC et CAPON sur leur capacité à séparer deux sources d'énergie 1 en présence d'un bruit dont la variance croît, tout en conservant constant le nombre de capteurs ($M=15$). On en conclut que MUSIC est plus robuste dans un environnement bruité.
<p align="middle">
     <img src="https://github.com/Adrial-Knight/Multi-Array-Processing-for-Adaptive-Beamforming/blob/main/doc/fig/localisation_s_0.1.svg" width=45% height=45% title="σ^2=0.1">
     <img src="https://github.com/Adrial-Knight/Multi-Array-Processing-for-Adaptive-Beamforming/blob/main/doc/fig/localisation_s_0.25.svg" width=45% height=45% title="σ^2=0.25">
</p>
<p align="middle">
     <img src="https://github.com/Adrial-Knight/Multi-Array-Processing-for-Adaptive-Beamforming/blob/main/doc/fig/localisation_s_0.5.svg" width=45% height=45% title="σ^2=0.5">
     <img src="https://github.com/Adrial-Knight/Multi-Array-Processing-for-Adaptive-Beamforming/blob/main/doc/fig/localisation_s_1.svg" width=45% height=45% title="σ^2=1">
</p>



## On ne s’entend plus !
La stratégie mise en œuvre se déroule en quatre temps:
1. estimation de la variance du bruit
2. estimation du nombre de sources
3. estimation des directions
4. projection spatiale

La variance du bruit est estimée sur les deux premières secondes de l'enregistrement car il est supposé que les conversations n'ont pas encore démarré sur cet intervalle. Grâce à cette valeur, il est possible d'évaluer le [nombre de sources](#estimation-visuelle-du-nombre-de-sources).

Puis, la méthode MUSIC est utilisée pour détecter ces 8 sources. Néanmoins, seuls 4 minimums locaux ont été trouvés. Les 4 autres doivent provenir de sources images. L'ensemble des minimums sont visibles sur la figure ci-dessous en doublant le champ d'études.
<p align="center">
     <img src="https://github.com/Adrial-Knight/Multi-Array-Processing-for-Adaptive-Beamforming/blob/main/doc/fig/MUSIC_data.svg" width=50% height=50% title="Estimation des directions des conversations">
</p>

Enfin, le signal reçu est projeté sur les 4 vecteurs directionnels $\textbf{a}(\theta)$ afin d'extraire 4 conversations. On peut alors écouter le résultat. La conversation provenant de la direction 20° semble parasitée par les autres, car l'énergie parvenue aux capteurs semble être moins importante que les autres sources.
