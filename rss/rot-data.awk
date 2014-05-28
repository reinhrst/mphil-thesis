/BEACON HEADING/ {
    beacon_heading = $3;
}
/0a000101 05010044 44550003/ {
    time_divider=.5;

    channel = $3;
    rotation = ($9-beacon_heading+360+180)%360-180;
    rss=$8;

    if (rss != 127) {
        if(!starttime) {
            starttime = $1;
            lasttime = 0;
        }
        time = int((starttime - $1)/time_divider);
        if (time != lasttime) {
            print rotationtotal / count, total/count max_rot, max;
            count=0;
            total = 0;
            rotationtotal=0;
            lasttime = time;
            max=rss;
            max_rot=rotation;
        }
        count++;
        total += rss;
        if (rotationtotal > 0 && rotation < -90) {
            rotation += 360;
        }
        if (rotationtotal < 0 && rotation > 90) {
            rotation -= 360;
        }
        rotationtotal += rotation;
        if (rss > max) {
            max = rss;
            max_rot = rotation
        }
    }
}
