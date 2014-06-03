BEGIN {
    ORS="\\\\ \\hline\n";
}
{
    gsub(" m ", "&\\& ");
    gsub(/^ *[^ ]* */, "&\\& ");
    print
}
