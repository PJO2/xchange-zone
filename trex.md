trex

En lab, il est essentiel d'avoir le bon outil pour valider les configurations produites.
Etonnemment, le simpliste *ping* suffit dans un bon nombre de cas. Mais dans les autres cas, la validation requiert des outils plus complexes, en particulier dans les cas suivants :
- Mesure de performances
- Etablissement d'un grand nombre de sessions (test de charge ou de répartition de trafic)
- Re-jeu d'un trafic donné
- Validation d'un routage applicatif (PBR ou SD-WAN) 
- Simulation d'équipements réseau 

Jusqu'à présent j'utilisais plusieurs outils, opensource ou non, plus ou moins adaptés ([D-ITG](http://traffic.comics.unina.it/software/ITG/), [iperf](https://iperf.fr/), [udpgen](https://github.com/PJO2/udpgen), Spirent) pour répondre aux besoins ci-dessus.

Il se trouve que Cisco a créé un outil qui couvre l'ensemble des cas cités, que Cisco a placé cet outil sous une license open source et que mon collègue Christophe m'a mentionné son existence.

Ainsi, pour débuter cette année 2021, je veux vous parler de trex, générateur de trafic développé par Cisco et donner un exemple de sa mise en oeuvre. En effet, l'outil vise des fonctionnalités très étendues et son utilisation n'est pas évidente.

# Notre lab

Nous partons d'une capture d'une session HTTP au format pcap. Elle a été réalisée par l'outil tcpdump pendant le téléchargement d'un fichier de taille réduite.
Ici, nous cherchons à rejouer le trafic capturé en boucle et en changeant les adresses source et destination pour les adpater à notre lab.

Nous nous plaçons dans un environnement 100% virtuel avec deux machines virtuelles :
- la première nommée DUT (pour Device Under Test) représente notre équipement réseau
- la seconde fera tourner le générateur de trafic trex

Conformément au schéma ci-dessous, chaque VM possède 3 interfaces Ethernet : 
- une interface d'administration Out Of band pour l'utilsation
- une interface dans le LAN In
- une interface dans le LAN Out


Pour faire simple, ma VM DUT est une VM alpine linux, [configurée en routeur](https://linuxhint.com/enable_ip_forwarding_ipv4_debian_linux/), sur laquelle le réseau 20/8 est routé vers l'interface In, et le réseau 30/8 vers l'interface Out.
J'ai ajouté le logiciel iftop pour inspecter le trafic entrant et sortant, ce qui me permettra de valider l'outil de validation !

# Préparation de la VM trex

trex s'utilise selon deux modes :
- un mode utilisant le kernel linux pour bypasser les API réseau et communiquer directement avec le bus PCI
- un mode dit low_end utilsant les API réseau classiques

Le premier mode nécessite 2 coeurs CPU par interface réseau plus un supplémentaire pour le programme lui-même. En revanche, dans un environnement *bare metal* (non virtuel), les concepteurs indiquent des performances de l'ordre de 10 millions de paquets par seconde par coeur, ce qui force le respect.

Le second mode est utilisé pour une plus grande compatibilité et une plus grande simplicité d'utilisation. A priori, n'importe quelle variante de linux peut être utilisée, mais la variante Red HAt ou CentOS est préférée.
Nous partons donc d'une version CentOS 8 serveur toute neuve dotée de 3 coeurs, de 1 Gb de RAM  et de 20 Gb de disque.
Les packages suivants seront installés :

Le programme trex est installé depuis le site :

# Configuration des interfaces réseau
La configuration matérielle se fait dans un fichier yaml nommé /etc/trex-cfg. Dans le mode low_end, il suffit de nommer les interfaces  





