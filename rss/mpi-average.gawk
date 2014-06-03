BEGIN {
    arraystart = 1;
    arrayend = 1;
}
{
    rss=$3;
    channel=$2;
    timestamp = $1;
    distance = timestamp - 10 + 150;
    if (distance > 150 && distance < 3150 + average_length_mm / 2) {
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

