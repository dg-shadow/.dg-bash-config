#!/usr/bin/perl

# usage: find | grep cpp/py/h/whatever$ | git_years.pl


use strict;


chomp(my @files = <>) ;



for (@files)
{
    my %years;
    chomp (my @lines = split (/\n/, `git log $_ | grep Date`));

    for (@lines)
    {
        if (/(\d{4})/)
        {
            $years{$1} = 1;
        }
    }
    if (@lines)
    {
        my $new_years = join(", ", sort(keys(%years)));
        my $old = `grep -i "Copyright (C)" $_`;
        $old =~ /(copyright \(c\) )(.*?)( shadow)/i;
        `sed -i 's/$1$2$3/$1$new_years$3/' $_`;
            
    }
        
}

#
