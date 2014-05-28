BEGIN {
    if (!divide) {
        divide= 1
    }
    arraystart = 1;
    arrayend = 1;
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
    if (distance > 150 && distance < 3150 + average_length_mm / 2 && rss != 127 && channel_ok && NR%divide == 0) {
        if (distance < 3300) {
            arss[arrayend] = rss;
            adistance[arrayend] = distance;

            arrayend += 1;
            total += rss;
            count += 1;
        }
        while (adistance[arraystart] < distance - average_length_mm) {
            total -= arss[arraystart];
            count--;
            delete arss[arraystart];
            delete adistance[arraystart];
            arraystart++;
        }
        items = asort(arss, sortedrss);
        print distance-average_length_mm/2, total/count, sortedrss[1], sortedrss[items], (items % 2 ? sortedrss[(items-1)/2+1] : (sortedrss[items/2+1] + sortedrss[items/2])/2);
    }
}

