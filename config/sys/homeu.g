;M400
;M913 U40
;; Si le moteur est en bas lors du homing
;M400 G91
;G1 H2 U1 F200
;G1 H1 U-20 F200
;G1 H2 U-1 F200
;G90
;G92 U0
;M400
;; Si le moteur a besoin d'un homing normal et de finir son homing en haut
M400
M913 U20
M400 G91
G1 H2 U-22 F600
G1 H1 U20 F600; ligne non exécutée car sonde activée en permanence 
M400
M913 U100
M400
G1 H2 U15 F600
G90
G92 U8
