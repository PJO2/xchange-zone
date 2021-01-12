trex

En lab, il est essentiel d'avoir le bon outil pour valider les configurations produites.
Etonnemment, le simpliste *ping* suffit dans un bon nombre de cas. Mais dans les autres cas, la validation requiert des outils plus complexes, en particulier dans les cas suivants :
- Mesure de performances
- Etablissement d'un grand nombre de sessions 
- Re-jeu d'un trafic donné
- Validation d'un routage applicatif (PBR ou SD-WAN) 
- Simulation d'équipements réseau 

Jusqu'à présent j'utilisais plusieurs outils, opensource ou non, plus ou moins adaptés ([D-ITG](http://traffic.comics.unina.it/software/ITG/), [iperf](https://iperf.fr/), [udpgen](https://github.com/PJO2/udpgen), Spirent) pour répondre aux besoins ci-dessus.

Il se trouve que Cisco a créé un outil qui couvre l'ensemble des cas cités, que Cisco a placé cet outil sous une license open source et que mon collègue Christophe m'a mentionné son existence.

Ainsi, pour débuter cette année 2021, je veux vous parler de trex, générateur de trafic développé par Cisco et donner un exemple de sa mise en oeuvre. En effet, l'outil vise des fonctionnalités très étendues et son utilisation n'est pas évidente.

# Notre lab

Nous partons d'une capture d'une session HTTP au format pcap. Elle a été réalisée par l'outil tcpdump pendant le téléchargement d'un fichier de taille réduite.
Ici, nous cherchons à rejouer le trafic capturé en boucle et en changeant les adresses source et destination pour les adpater à notre lab.

Le 



