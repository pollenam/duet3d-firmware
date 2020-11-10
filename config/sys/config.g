; Configuration file for Duet 3 (firmware version 3)
; executed by the firmware on start-up
;
; generated by RepRapFirmware Configuration Tool v3.1.4 on Tue Nov 10 2020 12:02:53 GMT+0100 (Central European Standard Time)

; General preferences
G90                                         ; send absolute coordinates...
M83                                         ; ...but relative extruder moves
M550 P"pam-duet"                            ; set printer name
M665 R218 L421.8 B150 H300 I J200;          ; Set delta radius, diagonal rod length, printable radius and homed height. I indicate Inverse delta kineamtics (moving plate). J is the safe height.
M666 X0 Y0 Z0                               ; put your endstop adjustments here, or let auto calibration find them
;M111 P4 S1 ; motion debugging on usb / tty
;M111 P5 S1 ; heat debugging
;M111 P6 S1 ; Dda debugging (lie aux transformations)

; Network
M552 P0.0.0.0 S1                            ; enable network and acquire dynamic address via DHCP
M586 P0 S1                                  ; enable HTTP
M586 P1 S0                                  ; disable FTP
M586 P2 S0                                  ; disable Telnet

; Drives
M569 P0.0 S0                                ; physical drive 0.0 goes forwards
M569 P0.1 S0                                ; physical drive 0.1 goes forwards
M569 P0.2 S0                                ; physical drive 0.2 goes forwards
M569 P1.0 S1                                ; physical drive 1.0 goes forwards
M584 X0.0 Y0.1 Z0.2 E1.0                    ; set drive mapping
M350 X256 Y256 Z256 E256 I0                 ; configure microstepping without interpolation
M92 X1600 Y1600 Z1600 E80000.0        	    ; set steps per mm
M566 X1200.00 Y1200.00 Z1200.00 E1200.00    ; set maximum instantaneous speed changes (mm/min)
M203 X18000.00 Y18000.00 Z18000.00 E1200.00 ; set maximum speeds (mm/min)
M201 X1000.00 Y1000.00 Z1000.00 E1000.00    ; set accelerations (mm/s^2)
M906 X1800 Y1800 Z1800 E1800 I30            ; set motor currents (mA) and motor idle factor in per cent
M84 S30                                     ; Set idle timeout

; Axis Limits
; M208 Z0 S1;
M208 X588 Y588 Z588 ; set axis maxima and high homing switch positions (adjust to suit your machine)
; M208 X50 Y50 Z50 S1 ; set axis minima and low homing switch positions (adjust to make X=0 and Y=0 the edges of the bed)

; Endstops
M574 X2 S1 P"io5.in"   ; X min active high endstop switch
M574 Y2 S1 P"io8.in"   ; Y min active high endstop switch
M574 Z2 S1 P"io6.in"   ; Z min active high endstop switch

; Z-Probe
M558 P5 H5 F120 T1200 C"e0stop"              ; set Z probe type to switch and the dive height + speeds
;G31 P10 X0 Y0 Z2.5                          ; set Z probe trigger value, offset and trigger height
;M557 R85 S20                                ; define mesh grid

; Heaters
; BED
M308 S3 Y"rtd-max31865" P"spi.cs0" A"Bed"   ; define Bed temperature sensor
M950 H0 C"out9" T3 			    			; heater 0 uses the out9 pin, sensor 3
M307 H0 B0 S1.00    			    		; disable bang-bang mode for the bed heater and set PWM limit
M143 H0 S120                                ; set temperature limit for heater 0 (bed) to 120C
M140 H0                                     ; map heated bed to heater 0

;Extruder
M308 S1 Y"rtd-max31865" P"1.spi.cs1" A"Ext" ; define E0 temperature sensor.
M950 H1 C"1.out6" T1                        ; heater 1 uses the e0_heat pin, sensor 1
M143 H1 S280                                ; set temperature limit for heater 1 to 280C
M307 H1 B0 S1.00                            ; disable bang-bang mode for the nozzle heater and set PWM limit

;NOZZLE / HEAD
M308 S2 Y"rtd-max31865" P"1.spi.cs0" A"Nozzle" ; define E0 temperature sensor
M950 H2 C"1.out7" T2                           ; heater 2 uses the e1_heat pin, sensor 2
M307 H2 B0 S1.00                               ; disable bang-bang mode for the nozzle heater and set PWM limit
M143 H2 S280                                   ; set temperature limit for heater 2 to 280C

; COLD
M308 S4 Y"rtd-max31865" P"1.spi.cs2" A"Cold" ; define E0 temperature sensor
M950 F1 C"1.out3" ; sets FAN1 on pin fan1
M106 P1 T70 H4 C"Cold" ; fan1 is watching H4 and is on when temp is above 15° and is called Cold

; Fans
M950 F0 C"out4" Q500                        ; create fan 0 on pin out4 and set its frequency REFROID Carte mère
M106 P0 S1 H-1                              ; set fan 0 value. Thermostatic control is turned off
M950 F2 C"1.out4" Q500                      ; create fan 2 on pin 1.out4 and set its frequency REFROID IMPRESSION
M106 P2 S1 H1:2 T45                         ; set fan 2 value. Thermostatic control is turned on
M950 F3 C"1.out5" Q500                      ; create fan 3 on pin 1.out5 and set its frequency REFROID CARTE ELEC
M106 P3 S1 H1:2 T45                         ; set fan 3 value. Thermostatic control is turned on

; Tools
M563 P1 S"Extruder" D0 H1:2 F0              ; define tool & named Extruder, using drive 3, heaters 1/2, and Fan 0
G10 P0 X0 Y0 Z0                             ; set tool 0 axis offsets
G10 P0 R0 S0                                ; set initial tool 0 active and standby temperatures to 0C

M570 H1 P180 S10 ; Soit tolérant aux chauffes trop lentes sur h1 pendant 180 secondes
M570 H0 P180 S10 ; Soit tolérant aux chauffes trop lentes sur h1 pendant 180 secondes

M950 P0 C"out7"

; Custom settings are not defined
M501 ;use config-override.g as well
