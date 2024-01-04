NOTICE: This work is incomplete. 

  Flightgear Lancair 235 model from http://helijah.free.fr/flightgear/hangar.htm with updated
KNS80 Nav Radio and KAP140 Autopilot instruments from https://github.com/reiszner?tab=repositories.

  Navigation Instrument Displays: 
  At panel lower-left the RMI display with the pushbutton switches display pointers to NAV[0] (NAV1 Button), 
KNS80 ( NAV2 Button )  and TAC ( Unused / Untested ).  With NAV2 selected the pointer will depend on
KNS80 Nav mode: with KNS80 in VOR modes 0, 1 the RMI pointer will show direction to the KNS80's active VOR
station.  With the KNS80 in RNAV modes 2, 3 the RMI pointer will show direction to the waypoint, possibly 
offset by radial and distance waypoint attributes. 
    At panel lower-centre the KCS55 sysytem uses the KI525 display ( some plane models refer to KI252 which 
is assumed to be a typo).  There is only one Course Devitation Indicator, it is switched between NAV1, 
radio, KNS80 RNAV and 'GPS' by setting the property: /instrumentation/nav-source/selector to 0, 1, 2.
With nav-source/selector set to 1 the CDI will respond to either KNS80 VOR or RNAV waypoint according
to KNS80 Nav Mode setting.  There are no push-buttons on the panel for KI525 nav source selection. 
GPS mode for the KCS55 has not been tested.

nav-source-panel
  This instrument is a three-way radio push-button to set nav-source index for HSI and autopilot.
It's based on the RMI instrument from Helijah's Lancair-235 with the'TAC' label replaced with 'GPS'
for nav-source index value 2; this is the only change to the png image so the image file shows the 
full RMI face and pointers.  The .xml and .ac file are chopped so that only the pushbutton switches
are displayed. 
 
  
  


