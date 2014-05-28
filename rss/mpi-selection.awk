BEGIN {
    if (!divide) {
        divide= 1
    }
    arraystart = 0;
    arrayend = 0;
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
        arss[arrayend] = rss;
        adistance[arrayend] = distance;

        arrayend += 1;
        total += rss;
        count += 1;
        while (data[arraystart]["distance"] < distance - average_length_mm) {
            total -= data[arraystart]["rss"];
            count--;
            delete data[arraystart];
            arraystart++;
        }
        print distance-average_length_mm/2, total/count;
    }
}

