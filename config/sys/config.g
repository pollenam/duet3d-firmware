; Configuration file for Duet 3 (firmware version 3)
; executed by the firmware on start-up
;
; generated by RepRapFirmware Configuration Tool v3.1.4 on Tue Nov 10 2020 12:02:53 GMT+0100 (Central European Standard Time)

; General preferences
G21                                         ; set units to mm
G90                                         ; send absolute coordinates...
M83                                         ; ...but relative extruder moves
M550 P"pam-duet"                            ; set printer name
M665 X-30 Y-30 Z-30 R218 L421.8 B150 H300 I J200           ; Set delta radius, diagonal rod length, printable radius and homed height. I indicate Inverse delta kineamtics (moving plate). J is the safe height.
M666 X0 Y0 Z0                               ; put your endstop adjustments here, or let auto calibration find them
;M111 P4 S1                                  ; motion debugging on usb / tty
;M111 P5 S1                                  ; heat debugging
;M111 P6 S1                                  ; Dda debugging (lie aux transformations)

; Network
M552 P0.0.0.0 S1                            ; enable network and acquire dynamic address via DHCP
M586 P0 S1                                  ; enable HTTP
M586 P1 S0                                  ; disable FTP
M586 P2 S0                                  ; disable Telnet

; Drives
M569 P0.0 S1                                ; physical drive 0.0 goes forwards Z
M569 P0.1 S1                                ; physical drive 0.1 goes forwards X
M569 P0.2 S1                                ; physical drive 0.2 goes forwards Y
M569 P1.0 S1                                ; physical drive 1.0 goes forwards EXTRUSION
M569 P1.1 S1                                ; physical drive 1.0 goes forwards LEVAGE
;M569 P1.2 S1                                ; physical drive 1.0 goes forwards TALC

M584 X0.1 Y0.2 Z0.0 E1.0:1.2                 ; set drive mapping 
;M584 S1 V1.1 P4						;set rotational LEVAGE et TALC

M350 X256 Y256 Z256 E256:256 V1 I0                  ; configure microstepping without interpolation
M92 X3200 Y3200 Z3200 E80000.0:51200 V20        	    ; set steps per mm
M566 X1200.00 Y1200.00 Z1200.00 E1200.00               ; set maximum instantaneous speed changes (mm/min)
M203 X18000.00 Y18000.00 Z18000.00 E1200.00 V200    ; set maximum speeds (mm/min)
M201 X1000.00 Y1000.00 Z1000.00 E1000.00               ; set accelerations (mm/s^2)
M906 X1800 Y1800 Z1800 E1800:200 I30                ; set motor currents (mA) and motor idle factor in per cent
M84 S30                                             ; Set idle timeout

; Axis Limits
; M208 Z0 S1;
M208 X588 Y588 Z588 ; set axis maxima and high homing switch positions (adjust to suit your machine)
; M208 X50 Y50 Z50 S1 ; set axis minima and low homing switch positions (adjust to make X=0 and Y=0 the edges of the bed)

; Endstops
M574 Z1 S1 P"io5.in"   ; X min active high endstop switch
M574 X1 S1 P"io8.in"   ; Y min active high endstop switch
M574 Y1 S1 P"io6.in"   ; Z min active high endstop switch
M574 U1 S1 P"io6.in"   ; Z min active high endstop switch
M574 V1 S1 P"io6.in"   ; Z min active high endstop switch

; Z-Probe
M558 P8 H5 F120 T1200 C"1.io0.in"            ; set Z probe type to switch and the dive height + speeds
G31 P10 X0 Y0 Z32.24                          ; set Z probe trigger value, offset and trigger height
;M557 R85 S20                                ; define mesh grid

; Heaters
; BED
M308 S0 Y"rtd-max31865" P"spi.cs0" A"Bed"              ; define Bed temperature sensor
M950 H0 C"out9" T0 			    			           ; heater 0 uses the out9 pin, sensor 3
M307 H0 B0 S1.00    			    		           ; disable bang-bang mode for the bed heater and set PWM limit
M143 H0 S120                                           ; set temperature limit for heater 0 (bed) to 120C
M140 H0                                                ; map heated bed to heater 0
M307 H0 R2.429 C140.000:140.000 D5.50 S1.00 V0.0 B0    ; Automatic PID results

;Extruder
M308 S1 Y"rtd-max31865" P"1.spi.cs1" A"Ext"            ; define E0 temperature sensor.
M950 H1 C"1.out6" T1                                   ; heater 1 uses the 1.out6 pin, sensor 1
M143 H1 S280                                           ; set temperature limit for heater 1 to 280C
M307 H1 B0 S1.00                                       ; disable bang-bang mode for the nozzle heater and set PWM limit
M307 H1 R0.869 C456.959:456.959 D14.95 S1.00 V22.3 B0  ; Autotune result (M303 H1 S167)

;NOZZLE / HEAD
M308 S2 Y"rtd-max31865" P"1.spi.cs0" A"Nozzle"           ; define E0 temperature sensor
M950 H2 C"1.out7" T2                                     ; heater 2 uses the 1.out7 pin, sensor 2
M307 H2 B0 S1.00                                       ; disable bang-bang mode for the nozzle heater and set PWM limit
M143 H2 S280                                           ; set temperature limit for heater 2 to 280C
M307 H2 R2.327 C131.111:131.111 D4.93 S1.00 V22.3 B0   ; Autotune result (M303 H2 S185)

; COLD
M308 S4 Y"rtd-max31865" P"1.spi.cs2" A"Cold"   ; define E0 temperature sensor
;M950 F1 C"!1.out3" Q25000                       ; sets FAN1 on pin 1.out3
;M106 P1 T62 H4 C"Cold" S1.0                    ; fan1 is watching H4 and is on when temp is above 45° and is called Cold
M950 H4 C"!1.out3" Q25000 T4                       ; sets FAN1 on pin 1.out3
M143 H4 S90
M307 H4 B0 S1.0 I1

; Fans
M950 F0 C"!out4" Q25000                        ; create fan 0 on pin out4 and set its frequency REFROID Carte mère
M106 P0 S1.0                                  ; set fan 0 value. Thermostatic control is turned off
M950 F2 C"1.out4" ;Q25000                      ; create fan 2 on pin 1.out4 and set its frequency REFROID IMPRESSION
;M106 P2 S0 H-1
;M950 F3 C"!1.out5" Q25000                      ; create fan 3 on pin 1.out5 and set its frequency REFROID CARTE ELEC
;M106 P3 S1 H4 T45                           ; ERREUR ? set fan 3 value. Thermostatic control is turned on

; Tools
M563 P1 S"Extruder" D0:1 H1:2:4 F2              ; define tool & named Extruder, using drive 0, heaters 1 & 2, and fan 0 mapped to FAN2
M567 P1 E1.00:0.50                               ; set mixing ratio of tool 1 drivers, driver 0 (Extrusion) at 100%, driver 1 (Talc) at 50%
G10 P0 X0 Y0 Z0                                 ; set tool 0 axis offsets
G10 P0 R0 S0                                    ; set initial tool 0 active and standby temperatures to 0C
M563 P2 S"TALC" D1              ; define tool & named TALC, using drive 1


M570 H1 P180 S10 ; Soit tolérant aux chauffes trop lentes sur h1 pendant 180 secondes
M570 H0 P180 S10 ; Soit tolérant aux chauffes trop lentes sur h1 pendant 180 secondes

M950 P0 C"out7"                             ; Create output 0 on pin out7 SSR MISE EN VEILLE

; Custom settings are not defined
M501 ;use config-override.g as well
