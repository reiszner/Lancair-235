The Bendix/King KNS 80 (version 1.1)
------------------------------------

This implementation is build according to the user manual.
The meaning of course deviation is depending on the active mode:
- VOR: deviation represent +/-10° (like a normal NAV radio)
       (if ILS is dedected it represent +/-4°)
- VOR PAR: deviation represent +/-5nm (parallel mode)
- RNV ENR: deviation represent +/-5nm (Areal NAV en-route)
- RNV APR: deviation represent +/-1.25nm (Areal NAV approach)
Every mode normalize the representation to +/-1 in
    '/instrumentation/kns80/nav/heading-needle-deflection-norm'.

If you want bind a CDI, HSI, DG to the system,
you will find all needed values under '/instrumentation/kns80/nav/'.

All buttons (except HOLD) are normal push buttons.
The HOLD button is a two state button.
The volume knob can be rotated with the mouse wheel and
pushed/pulled with shift+click.
The outer knob can be rotated with the mouse wheel
The inner knob can be rotated with the mouse wheel and
pushed/pulled with shift+click.
The ILS annunciator will lit if the radio receive a ILS frequency.
The HLD annunciator (for HOLD) will only lit if the DME and NAV frequency are differ!


Include the KNS 80 in your aircraft:
------------------------------------

- copy the 'kns80' directory inside your aircraft tree
    (as example to 'Models/Interior/Panel/Instruments/')

- add the 'kns80.xml' to your panel (like every other model)

- add a 'nav-radio' and a 'dme' in your instrumentation
    (under <sim> … <instrumentation>)

- open the file 'kns80-config.xml' and configure all aliases to the right nav and dme

- add the file 'kns80-proprules.xml' as property rule under '<sim> … <systems>' in your set-file

- add the following lines under '<instrumentation>' in your set-file:

<!-- kns80 begin -->
    <kns80>
      <powered type="bool">false</powered>
      <serviceable type="bool">true</serviceable>
      <nav-mode type="int">0</nav-mode>
      <data-mode type="int">0</data-mode>
      <dme-hold type="bool">false</dme-hold> <!-- should be saved -->
      <select-pulled type="bool">false</select-pulled> <!-- should be saved -->
      <use type="int">0</use>
      <display type="int">0</display>
      <display-timer type="double">0.0</display-timer>
      <displayed-digits type="double">0.0</displayed-digits>
      <displayed-frequency type="double">0.0</displayed-frequency>
      <displayed-distance type="double">0.0</displayed-distance>
      <displayed-radial type="double">0.0</displayed-radial>
      <displayed-indicated-nm type="int">0</displayed-indicated-nm>
      <used-frequency type="double">0.0</used-frequency>
      <used-distance type="double">0.0</used-distance>
      <used-radial type="double">0.0</used-radial>
      <config>
        <power-nominal type="double">12.0</power-nominal> <!-- used power system on the aircraft-->
      </config>
      <nav>
        <heading-deflection-deg type="double">0.0</heading-deflection-deg>
        <heading-deg type="double">0.0</heading-deg>
        <heading-needle-deflection type="double">0.0</heading-needle-deflection>
        <heading-needle-deflection-nm type="double">0.0</heading-needle-deflection-nm>
        <heading-needle-deflection-norm type="double">0.0</heading-needle-deflection-norm>
        <nav-distance-nm type="double">0.0</nav-distance-nm>
        <from-to type="double">0.0</from-to>
        <from-flag type="bool">false</from-flag>
        <to-flag type="bool">false</to-flag>
        <internal>
          <aircraft-station-x type="double"/>
          <aircraft-station-y type="double"/>
          <aircraft-waypoint-x type="double"/>
          <aircraft-waypoint-y type="double"/>
          <station-declination type="double"/>
          <station-waypoint-x type="double"/>
          <station-waypoint-y type="double"/>
        </internal>
      </nav>
      <dme>
        <indicated-distance-nm type="double"/>
        <indicated-ground-speed-kt type="double"/>
        <indicated-time-min type="double"/>
        <internal>
          <run n="0" type="bool">false</run>
          <run n="1" type="bool">false</run>
          <run n="2" type="bool">false</run>
          <run n="3" type="bool">false</run>
          <run n="4" type="bool">false</run>
          <run n="5" type="bool">false</run>
          <run n="6" type="bool">false</run>
          <distance-old type="double"/>
          <time type="double"/>
          <time-old type="double"/>
        </internal>
      </dme>
<!-- all values in waypoints should be saved -->
      <wpt n="0">
        <freq1 type="int">8</freq1>
        <freq2 type="int">0</freq2>
        <frequency type="double">108.0</frequency>
        <rad1 type="int">0</rad1>
        <rad2 type="int">0</rad2>
        <rad3 type="int">0</rad3>
        <radial type="double">0.0</radial>
        <dist1 type="int">0</dist1>
        <dist2 type="int">0</dist2>
        <dist3 type="int">0</dist3>
        <distance type="double">0.0</distance>
      </wpt>
      <wpt n="1">
        <freq1 type="int">8</freq1>
        <freq2 type="int">0</freq2>
        <frequency type="double">108.0</frequency>
        <rad1 type="int">0</rad1>
        <rad2 type="int">0</rad2>
        <rad3 type="int">0</rad3>
        <radial type="double">0.0</radial>
        <dist1 type="int">0</dist1>
        <dist2 type="int">0</dist2>
        <dist3 type="int">0</dist3>
        <distance type="double">0.0</distance>
      </wpt>
      <wpt n="2">
        <freq1 type="int">8</freq1>
        <freq2 type="int">0</freq2>
        <frequency type="double">108.0</frequency>
        <rad1 type="int">0</rad1>
        <rad2 type="int">0</rad2>
        <rad3 type="int">0</rad3>
        <radial type="double">0.0</radial>
        <dist1 type="int">0</dist1>
        <dist2 type="int">0</dist2>
        <dist3 type="int">0</dist3>
        <distance type="double">0.0</distance>
      </wpt>
      <wpt n="3">
        <freq1 type="int">8</freq1>
        <freq2 type="int">0</freq2>
        <frequency type="double">108.0</frequency>
        <rad1 type="int">0</rad1>
        <rad2 type="int">0</rad2>
        <rad3 type="int">0</rad3>
        <radial type="double">0.0</radial>
        <dist1 type="int">0</dist1>
        <dist2 type="int">0</dist2>
        <dist3 type="int">0</dist3>
        <distance type="double">0.0</distance>
      </wpt>
    </kns80>
<!-- kns80 end -->

Finish!
Happy flying :)
Sascha Reißner
2019

