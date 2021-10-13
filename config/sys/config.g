; Configuration file for Duet 3 (firmware version 3) executed by the firmware on start-up
; generated by RepRapFirmware Configuration Tool v3.1.4 on Tue Nov 10 2020 12:02:53 GMT+0100 (Central European Standard Time)
; NOTES : The heating chamber is being fully taken care of by the Duet and no Michel card is required. 
; The current heating elements maximum temperature is set up at line 103 and 104 by the M143 commands
; the heating room fans will start up after 35°C and this parameter is set up at line 126 by the M106 command
; The heating elements of the heating chamber are temperature regulated, and that's cool (hot, but you get the point) 

; General preferences
G21                                         ; set units to mm
G90                                         ; send absolute coordinates...
M83                                         ; ...but relative extruder moves
M550 P"dudu"                            ; set printer name
M665 X-30 Y-30 Z-30 R218 L421.8 B150 H300 I J200           ; Set delta radius, diagonal rod length, printable radius and homed height. I indicate Inverse delta kineamtics (moving plate). J is the safe height.
M666 X0 Y0 Z0                               ; put your endstop adjustments here, or let auto calibration find them
M208 Z290                                   ; limits the bed fro going too low when moving the bed in idle state
;M111 P4 S1                                 ; motion debugging on usb / tty
;M111 P5 S1                                 ; heat debugging
;M111 P6 S1                                 ; Dda debugging (lie aux transformations)

; Network
M552 P10.0.1.235 S1                         ; enable network and acquire dynamic address via DHCP
;M552 P0.0.0.0 S1
;M554 P10.0.1.236
M586 P0 S1                                  ; enable HTTP
M586 P1 S0                                  ; disable FTP
M586 P2 S0                                  ; disable Telnet

; Drives
M569 P0.0 S0 ;T1:1:1:1                                 ; physical drive 0.0 goes forwards Z
M569 P0.1 S0 ;T1:1:1:1                                 ; physical drive 0.1 goes forwards X
M569 P0.2 S0 ;T1:1:1:1                                 ; physical drive 0.2 goes forwards Y
M569 P1.0 S1 ;T1:1:1:1                                 ; physical drive 1.0 goes forwards EXTRUSION
M569 P1.1 S1                                ; physical drive 1.0 goes forwards LEVAGE
;M569 P1.2 S1                                ; physical drive 1.0 goes forwards TALC

M584 X0.1 Y0.2 Z0.0 E1.0:1.2 U1.1              ; set drive mapping 
;M584 S1 V1.1 P4						;set rotational LEVAGE et TALC

;M92 X200 Y200 Z200 E5000:3200 U320        	    ; set steps per mm NOTE: These value are adjusted for x16 microstepping as M350 will be used in the next line
M92 X100 Y100 Z100 E5000:3200 U320 ;23KM-H043CT13CN        	    ; set steps per mm NOTE: These value are adjusted for x16 microstepping as M350 will be used in the next line
M350 X32 Y32 Z32 E128:64 U1 I1 ;MICROSTEPPING                     ; configure microstepping without interpolation NOTE: Using M350 after M92 means the Duet will adjust the steps/mm automatically if the microstepping is changed
;Interpolation can be used from full step to 128x microstep, it can be used to let the drivers do the smoothing of the motor rotation instead of having the cpu do all the microsteps generation/calculation. This can help avoid "hiccups" when printing a big and/or fast part.
M566 X1200.00 Y1200.00 Z1200.00 E80.00;E20.00                  ; set maximum instantaneous speed changes (mm/min)
M203 X18000.00 Y18000.00 Z18000.00 E3600.00 U600        ; set maximum speeds (mm/min)
M201 X1000.00 Y1000.00 Z1000.00 E500.00;E20.00                  ; set accelerations (mm/s^2) ORIGINAL VALUES : 1000.00
M906 X2500 Y2500 Z2500 E2500:400 U120 I60;I30               ; set motor currents (mA) and motor idle factor in per cent ORIGINAL VALUES : 1800.00
M84 S30                                                 ; Set idle timeout

; Axis Limits
;M564 H0
; M208 Z0 S1;
M208 X290 Y290 Z290 U-10:8 ; set axis maxima and high homing switch positions (adjust to suit your machine) Original value X588 Y588 Z588
; M208 X50 Y50 Z50 S1 ; set axis minima and low homing switch positions (adjust to make X=0 and Y=0 the edges of the bed)

; Endstops
M574 Z1 S1 P"io5.in"   ; X min active high endstop switch
M574 X1 S1 P"io8.in"   ; Y min active high endstop switch
M574 Y1 S1 P"io6.in"   ; Z min active high endstop switch
;M574 X1 Y1 Z1 S2 P"!1.io3.in" ;Old command to try to use the piezo as a endstop for all axes
;M574 U0 S3  ; Z min active high endstop switch
;M915 X Y Z S0 R3 F0 ;  Configure motor stall detection EXPERIMENTAL, DO NOT USE, Homing does not succeed and it doesn't detect missed steps for some reason
M574 U1 S1 P"1.io1.in"   ; Z min active high endstop switch

; Z-Probe
M558 P8 H10 F1000 T1200 C"1.io0.in"    ;M558 P8 H5 F120 T1200 C"1.io0.in"            ; set Z probe type to switch and the dive height + speeds R0.6 avant changements du 280921 PIEZO;M558 P8 R0.2 A2 S-1 H10 F1500 C"!1.io3.in" 
G31 P10 X0 Y0 Z32.24;-Z0.5Hugues's command    G31 P10 X0 Y0 Z32.24  ;                  ; set Z probe trigger value, offset and trigger height PIEZO;G31 P10 X-8.89 Y-13.31 Z0
;M557 R85 S20                                ; define mesh grid

; Heaters
; BED
M308 S0 Y"rtd-max31865" P"spi.cs0" A"Bed"              ; define Bed temperature sensor
M950 H0 C"out9" T0 			    			           ; heater 0 uses the out9 pin, sensor 3
M307 H0 B0 S1.00    			    		           ; disable bang-bang mode for the bed heater and set PWM limit
M143 H0 S260                                           ; set temperature limit for heater 0 (bed) to 120C
M140 H0                                                ; map heated bed to heater 0
M307 H0 R2.429 C140.000:140.000 D5.50 S1.00 V0.0 B0    ; Automatic PID results

;Extruder
M308 S1 Y"pt1000" P"1.temp1" A"Ext"                    ; define extruder temperature sensor.
M950 H1 C"1.out6" T1                                   ; heater 1 uses the 1.out6 pin, sensor 1
M143 H1 S280                                           ; set temperature limit for heater 1 to 280C
M307 H1 B0 S1.00                                       ; disable bang-bang mode for the nozzle heater and set PWM limit
M307 H1 R0.869 C456.959:456.959 D14.95 S1.00 V22.3 B0  ; Autotune result (M303 H1 S167)

;NOZZLE / HEAD
M308 S2 Y"pt1000" P"1.temp2" A"Nozzle"                 ; define nozzle temperature sensor
M950 H2 C"1.out7" T2                                   ; heater 2 uses the 1.out7 pin, sensor 2
M307 H2 B0 S1.00                                       ; disable bang-bang mode for the nozzle heater and set PWM limit
M143 H2 S280                                           ; set temperature limit for heater 2 to 280C
M307 H2 R2.327 C131.111:131.111 D4.93 S1.00 V22.3 B0   ; Autotune result (M303 H2 S185)

; COLD
M308 S4 Y"pt1000" P"1.temp0" A"Cold"                   ; define cold temperature sensor
;M950 F1 C"!1.out3" Q25000                             ; sets FAN1 on pin 1.out3
;M106 P1 T62 H4 C"Cold" S1.0                           ; fan1 is watching H4 and is on when temp is above 45° and is called Cold
M950 H4 C"!1.out3" Q25000 T4                           ; sets FAN1 on pin 1.out3
M143 H4 S90 
M307 H4 B0 S1.0 I1

; ROOM 1
M308 S10 Y"rtd-max31865" P"1.spi.cs0" A"Room heater 1"      ; define room heater 1 temperature sensor
M308 S11 Y"rtd-max31865" P"1.spi.cs1" A"Room heater 2"      ; define room heater 2 temperature sensor
M308 S5 Y"rtd-max31865" P"1.spi.cs2" A"Room"                ; define room temperature sensor
M950 H5 C"1.out8" T5 ;Q10000    			                ; heater 0 uses the out5 pin, sensor 3
M307 H5 B0    			    		                        ; disable bang-bang mode for the bed heater and set PWM limit
; ROOM RULES
M143 H5 S70                ; set temperature limit for heater 5 (room) to 90C
M143 H5 S150 T10 C0 A2 P1  ; ROOM HEATER 1 PROTECTION : Regulate (A2) room heater 1 (H5) to have room heater 1 sensor (T10) below 160°C (S160). Display the sensor in the "extra" tab as the first sensor (P1) 
M143 H5 S150 T11 C0 A2 P2  ; ROOM HEATER 2 PROTECTION : Regulate (A2) room heater 1 (H5) to have room heater 2 sensor (T11) below 160°C (S160). Display the sensor in the "extra" tab as the second sensor (P2) 



;M143 P100 H5 X104 A2 C0 S65
M141 H5   											   ; set heater 5 to be the chamber heater and be declared like so in the interface
M307 H5 R2.429 C140.000:140.000 D5.50 S1.00 V0.0 B0    ; Automatic PID results

; RADIANT
M308 S6 Y"rtd-max31865" P"1.spi.cs3" A"Radiant"         ; define radiant temperature sensor
M950 H6 C"out8" T6			    			            ; heater 6 uses the out8 pin, sensor 6
M307 H6 B0 S1.00    			    		            ; disable bang-bang mode for the bed heater and set PWM limit
M143 H6 S200     									    ; set temperature limit for heater 0 (bed) to 200C
M307 H6 R2 C456.959:456.959 D14.95 S1.00 V22.3 B0       ;R2.429 C140.000:140.000 D5.50 S1.00 V0.0 B0    ; Automatic PID results DO : (M303 H6 S150)
;M301 H6 P12 I700 D800 ;PID 


; Fans
M950 F0 C"!out4" Q25000       ; create fan 0 on pin out4 and set its frequency REFROID Carte mère
M106 P0 S1.0 C"Carte mère"                 ; set fan 0 value. Thermostatic control is turned off
M950 F2 C"1.out4" Q60
M106 P2 C"Ventilateurs tête"; create fan 2 on pin 1.out4 and set its frequency REFROID IMPRESSION
;M950 F2 C"!1.out4+1.out4.tach" ;Q25000     ; create fan 2 on pin 1.out4 and set its frequency REFROID IMPRESSION PWM COMAND
;M950 F2 C"1.out4" ;Q25000     ; create fan 2 on pin 1.out4 and set its frequency REFROID IMPRESSION PWM COMAND

;M950 F3 C"1.out5" Q1000       ; ROOM HEATER FANS CONFIGURATION : Frequency is 1000 Hz and the fan pin is "1.out5", the two fans are currently wired in parallel
;M106 P3 T35 S1 H10:H11        ; ROOM HEATER FANS BEHAVIOR : If any of the room heater sensors (H10:11) go above 35°C (T35) then activate the room heater fans (P3) at max PWM (S1)

;M106 P2 S0 H-1
;M950 F3 C"!1.out5" Q25000                    ; create fan 3 on pin 1.out5 and set its frequency REFROID CARTE ELEC
;M106 P3 S1 H4 T45                            ; ERREUR ? set fan 3 value. Thermostatic control is turned on

; Tools
M563 P1 S"Extruder" D0:1 H1:2:4:6 F2          ; define tool & named Extruder, using drive 0, heaters 1, 2, 3 (fan) and 4 (radiant), fan 0 mapped to FAN2
M567 P1 E1.00:0.25                            ; set mixing ratio of tool 1 drivers, driver 0 (Extrusion) at 100%, driver 1 (Talc) at 50%
G10 P1 X-8.89 Y-13.31 Z0                      ; set tool 0 axis offsets
G10 P0 R0 S0                                  ; set initial tool 0 active and standby temperatures to 0C
;M563 P2 S"PL20" D1             			  ; define tool & named TALC, using drive 1
;M563 P2 H5:7 

;M563 P3 S"Room" H3
;M563 P4 S"Radiant" H6


M570 H1 P180 S10 	; Soit tolérant aux chauffes trop lentes sur h1 pendant 180 secondes
M570 H0 P500000 S10 T150; Soit tolérant aux chauffes trop lentes sur h0 pendant 180 secondes
M570 H2 P180 S10 	; Soit tolérant aux chauffes trop lentes sur h2 pendant 180 secondes
M570 H4 P180 S10 	; Soit tolérant aux chauffes trop lentes sur h2 pendant 180 secondes
M570 H6 P180 T50 	; RADIANT Soit tolérant aux chauffes trop lentes sur h6 pendant 180 secondes et au différences de 50°C
M570 H5 P500000 T100; ROOM Soit tolérant aux chauffes trop lentes sur h5 pendant 500000 secondes et au différences de 100°C 
;M572 D0 S0.2        ;preassure advance, not great right now, need to tune retraction and jerk before using it again

M950 P0 C"out7"     ; Create output 0 on pin out7 SSR MISE EN VEILLE
;M80 ; Pour afficher le bouton "ATX Power" dans le dashboard, pratique pour controler le SSR de mise en veille avec un bouton et non une macro. Il faut brancher le SSR sur le pin 
G29 S1 ; load previous compensation map

; Custom settings are not defined
M501 ;use config-override.g as well



