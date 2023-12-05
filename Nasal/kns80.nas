var config = io.read_properties("Aircraft/Lancair-235/Models/Interior/Panel/Instruments/kns80/kns80-config.xml");

var kns80_vor         = props.globals.initNode("instrumentation/kns80/event/button-vor",       0, "BOOL");
var kns80_rnav        = props.globals.initNode("instrumentation/kns80/event/button-rnav",      0, "BOOL");
var kns80_hold        = props.globals.initNode("instrumentation/kns80/event/button-hold",      0, "BOOL");
var kns80_use         = props.globals.initNode("instrumentation/kns80/event/button-use",       0, "BOOL");
var kns80_dsp         = props.globals.initNode("instrumentation/kns80/event/button-dsp",       0, "BOOL");
var kns80_data        = props.globals.initNode("instrumentation/kns80/event/button-data",      0, "BOOL");
var kns80_volume      = props.globals.initNode("instrumentation/kns80/event/knob-volume",      0, "INT");
var kns80_volume_pull = props.globals.initNode("instrumentation/kns80/event/knob-volume-pull", 0, "BOOL");
var kns80_outer       = props.globals.initNode("instrumentation/kns80/event/knob-outer",       0, "INT");
var kns80_inner       = props.globals.initNode("instrumentation/kns80/event/knob-inner",       0, "INT");
var kns80_inner_pull  = props.globals.initNode("instrumentation/kns80/event/knob-inner-pull",  0, "BOOL");

#var dme_distance      = props.globals.getNode(config.getValue("params/dme-indicated-distance-nm"),0);
var dme_distance      = props.globals.getNode("instrumentation/kns80/nav/nav-distance-nm",0);

setlistener(dme_distance, func(dist) {
    if (dist.getValue() > 0.0) {
        var dme_dist      = dist.getValue();
        var dme_dist_last = getprop("instrumentation/kns80/dme/last-distance-nm") or 0;
        var dme_time      = getprop("sim/time/elapsed-sec") or 0;
        var dme_time_last = getprop("instrumentation/kns80/dme/last-time") or 0;
        var dT =  (dme_time - dme_time_last);
        if ( dT > 0.99 ) {
            # printf("D: %.3f  pD: %.3f  dD: %.3f   Tc: %.3f  pT: %.3f dT: %.3f", dme_dist, \
            #  dme_dist_last, (dme_dist - dme_dist_last), dD, dme_time, dme_time_last, dT);
            var factor        = abs(dme_dist - dme_dist_last) / dT;
            var speed         = factor * 3600;
            var minute        = dme_dist / (factor * 60);
            if (speed <   0.0) speed = 0.0;
            if (speed > 999.0) speed = 999.0;
            if (minute <  0.0) minute = 0.0;
            if (minute > 99.0) minute = 99.0;
            setprop("instrumentation/kns80/dme/indicated-distance-nm", dme_dist);
            setprop("instrumentation/kns80/dme/indicated-ground-speed-kt", speed);
            setprop("instrumentation/kns80/dme/indicated-time-min", minute);
            setprop("instrumentation/kns80/dme/last-distance-nm", dme_dist);
            setprop("instrumentation/kns80/dme/last-time", dme_time);
        }    
    }
},0,0);

setlistener(kns80_vor, func(vor) {
    if (vor.getBoolValue()) {
        if (getprop("instrumentation/kns80/powered")) {
            if (getprop("instrumentation/kns80/nav-mode")) {
                setprop("instrumentation/kns80/nav-mode", 0);
            }
            else {
                setprop("instrumentation/kns80/nav-mode", 1);
            }
        }
    }
},0,0);

setlistener(kns80_rnav, func(rnav) {
    if (rnav.getBoolValue()) {
        if (getprop("instrumentation/kns80/powered")) {
            if (getprop("instrumentation/kns80/nav-mode") == 2) {
                setprop("instrumentation/kns80/nav-mode", 3);
            }
            else {
                setprop("instrumentation/kns80/nav-mode", 2);
            }
        }
    }
},0,0);

setlistener(kns80_hold, func(hold) {
    if (hold.getBoolValue()) {
        if (getprop("instrumentation/kns80/powered")) {
            if (getprop("instrumentation/kns80/dme-hold")) {
                setprop("instrumentation/kns80/dme-hold", 0);
            }
            else {
                setprop("instrumentation/kns80/dme-hold", 1);
            }
        }
    }
},0,0);

setlistener(kns80_use, func(use) {
    if (use.getBoolValue()) {
        if (getprop("instrumentation/kns80/powered")) {
            setprop("instrumentation/kns80/use", getprop("instrumentation/kns80/display"));
            setprop("instrumentation/kns80/data-mode", 0);
        }
    }
},0,0);

setlistener(kns80_dsp, func(dsp) {
    if (dsp.getBoolValue()) {
        if (getprop("instrumentation/kns80/powered")) {
            var disp = getprop("instrumentation/kns80/display") + 1;
            if (disp > 3) disp = 0;
            setprop("instrumentation/kns80/display", disp);
            setprop("instrumentation/kns80/data-mode", 0);
            setprop("instrumentation/kns80/display-timer", getprop("sim/time/elapsed-sec"));
        }
    }
},0,0);

setlistener(kns80_data, func(data) {
    if (data.getBoolValue()) {
        if (getprop("instrumentation/kns80/powered")) {
            var data = getprop("instrumentation/kns80/data-mode") + 1;
            if (data > 2) data = 0;
            setprop("instrumentation/kns80/data-mode", data);
        }
    }
},0,0);

setlistener(kns80_volume, func(volume) {
    if (volume.getValue()) {
        var nav_volume = config.getValue("params/nav-volume");
        var nav_power  = config.getValue("params/nav-power-btn");
        var volume = getprop(nav_volume) + volume.getValue() * 0.1;
        #print('kns80_volume: ', volume);
        if (volume < 0.0) volume = 0.0;
        if (volume > 1.0) volume = 1.0;
        if (volume) setprop(nav_power, 1);
        else setprop(nav_power, 0);
        setprop(nav_volume, volume);
        kns80_volume.setValue(0);
    }
},0,0);

setlistener(kns80_volume_pull, func(volume_pull) {
    var nav_audio  = config.getValue("params/nav-audio-btn");
    setprop(nav_audio, volume_pull.getBoolValue());
},0,0);


setlistener(kns80_inner, func(inner) {
    if (inner.getValue()) {
        var pos = (getprop("instrumentation/kns80/knob-inner-pos") or 0)  + inner.getValue() * 15;
        if (pos < 0  ) pos = pos + 360;
        if (pos > 359) pos = pos - 360;
        setprop("instrumentation/kns80/knob-inner-pos", pos);

        if (getprop("instrumentation/kns80/powered")) {
            var wpt = getprop("instrumentation/kns80/display");
            if (getprop("instrumentation/kns80/data-mode") == 0) {
                var freq = getprop("instrumentation/kns80/wpt["~wpt~"]/freq2") + inner.getValue() * 5;
                if (freq < 0 ) freq = freq + 100;
                if (freq > 95) freq = freq - 100;
                setprop("instrumentation/kns80/wpt["~wpt~"]/freq2", freq);
                setprop("instrumentation/kns80/wpt["~wpt~"]/frequency", getprop("instrumentation/kns80/wpt["~wpt~"]/freq1") + getprop("instrumentation/kns80/wpt["~wpt~"]/freq2") * 0.01);
            }
            if (getprop("instrumentation/kns80/data-mode") == 1) {
                if (getprop("instrumentation/kns80/select-pulled")) {
                    var rad = getprop("instrumentation/kns80/wpt["~wpt~"]/rad3") + inner.getValue();
                    if (rad < 0) rad = rad + 10;
                    if (rad > 9) rad = rad - 10;
                    setprop("instrumentation/kns80/wpt["~wpt~"]/rad3", rad);
                }
                else {
                    var rad = getprop("instrumentation/kns80/wpt["~wpt~"]/rad2") + inner.getValue();
                    if (rad < 0) rad = rad + 10;
                    if (rad > 9) rad = rad - 10;
                    setprop("instrumentation/kns80/wpt["~wpt~"]/rad2", rad);
                }
                setprop("instrumentation/kns80/wpt["~wpt~"]/radial", getprop("instrumentation/kns80/wpt["~wpt~"]/rad1") * 10 + getprop("instrumentation/kns80/wpt["~wpt~"]/rad2") + getprop("instrumentation/kns80/wpt["~wpt~"]/rad3") * 0.1);
            }
            if (getprop("instrumentation/kns80/data-mode") == 2) {
                if (getprop("instrumentation/kns80/select-pulled")) {
                    var dist = getprop("instrumentation/kns80/wpt["~wpt~"]/dist3") + inner.getValue();
                    if (dist < 0) dist = dist + 10;
                    if (dist > 9) dist = dist - 10;
                    setprop("instrumentation/kns80/wpt["~wpt~"]/dist3", dist);
                }
                else {
                    var dist = getprop("instrumentation/kns80/wpt["~wpt~"]/dist2") + inner.getValue();
                    if (dist < 0) dist = dist + 10;
                    if (dist > 9) dist = dist - 10;
                    setprop("instrumentation/kns80/wpt["~wpt~"]/dist2", dist);
                }
                setprop("instrumentation/kns80/wpt["~wpt~"]/distance", getprop("instrumentation/kns80/wpt["~wpt~"]/dist1") * 10 + getprop("instrumentation/kns80/wpt["~wpt~"]/dist2") + getprop("instrumentation/kns80/wpt["~wpt~"]/dist3") * 0.1);
            }
        }
        kns80_inner.setValue(0);
    }
},0,0);

setlistener(kns80_inner_pull, func(inner_pull) {
    setprop("instrumentation/kns80/select-pulled", inner_pull.getBoolValue());
},0,0);

setlistener(kns80_outer, func(outer) {
    if (outer.getValue()) {
        var pos = (getprop("instrumentation/kns80/knob-outer-pos") or 0)+ outer.getValue() * 24;
        if (pos < 0  ) pos = pos + 360;
        if (pos > 360) pos = pos - 360;
        setprop("instrumentation/kns80/knob-outer-pos", pos);
        if (getprop("instrumentation/kns80/powered")) {
            var wpt = getprop("instrumentation/kns80/display");
            if (getprop("instrumentation/kns80/data-mode") == 0) {
                var freq = getprop("instrumentation/kns80/wpt["~wpt~"]/freq1") + outer.getValue();
                if (freq < 108) freq = freq + 11;
                if (freq > 118) freq = freq - 11;
                setprop("instrumentation/kns80/wpt["~wpt~"]/freq1", freq);
                setprop("instrumentation/kns80/wpt["~wpt~"]/frequency", getprop("instrumentation/kns80/wpt["~wpt~"]/freq1") + getprop("instrumentation/kns80/wpt["~wpt~"]/freq2") * 0.01);
            }
            if (getprop("instrumentation/kns80/data-mode") == 1) {
                var rad = getprop("instrumentation/kns80/wpt["~wpt~"]/rad1") + outer.getValue();
                if (rad < 1 ) rad = rad + 36;
                if (rad > 36) rad = rad - 36;
                setprop("instrumentation/kns80/wpt["~wpt~"]/rad1", rad);
                setprop("instrumentation/kns80/wpt["~wpt~"]/radial", getprop("instrumentation/kns80/wpt["~wpt~"]/rad1") * 10 + getprop("instrumentation/kns80/wpt["~wpt~"]/rad2") + getprop("instrumentation/kns80/wpt["~wpt~"]/rad3") * 0.1);
            }
            if (getprop("instrumentation/kns80/data-mode") == 2) {
                var dist = getprop("instrumentation/kns80/wpt["~wpt~"]/dist1") + outer.getValue();
                if (dist < 0 ) dist = dist + 20;
                if (dist > 19) dist = dist - 20;
                setprop("instrumentation/kns80/wpt["~wpt~"]/dist1", dist);
                setprop("instrumentation/kns80/wpt["~wpt~"]/distance", getprop("instrumentation/kns80/wpt["~wpt~"]/dist1") * 10 + getprop("instrumentation/kns80/wpt["~wpt~"]/dist2") + getprop("instrumentation/kns80/wpt["~wpt~"]/dist3") * 0.1);
            }
        }
        kns80_outer.setValue(0);
    }
},0,0);
