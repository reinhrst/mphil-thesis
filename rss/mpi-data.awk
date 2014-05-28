BEGIN {
    if (!divide) {
        divide= 1
    }
}
/0a000101 05010044 445500/ {
    rss=$8;
    channel=$3;
    channel_ok = (!filter_channel) || (filter_channel == channel);
    timestamp = $1;
    if (!starttime) {
        starttime = timestamp;
    }
    distance = timestamp-starttime - 10 + 150;
    if (distance > 150 && rss != 127 && channel_ok) {
        nr+=1
        if ((nr % divide) == 0) {
            print distance, rss+(rand()-0.5)*.1;
        }
    }
}

