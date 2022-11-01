#!/usr/bin/perl

# usage: find | grep cpp/py/h/whatever$ | git_years.pl


use strict;


chomp(my @files = <>) ;



for (@files)
{
    my $file = $_;
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
        my @years = sort(keys(%years));
        my @out_years;

        while (@years)
        {
            my $run = 0;
            while ($run < @years && $years[$run + 1] == $years[0] + $run + 1)
            {
                $run++
            }
            if ($run >= 2)
            {
                push(@out_years, "$years[0]-$years[$run]");
                for (0..$run)
                {
                    shift(@years);
                }
            }
            else
            {
                push(@out_years, shift(@years));
            }
        }


        my $new_years = join(", ", @out_years); #sort(keys(%years)));
        my $old = `grep -i "Copyright (C)" $_`;
        $old =~ /(copyright \(c\) )(.*?)( shadow)/i;
        print "$file\n";
        `sed -i 's/$1$2$3/$1$new_years$3/' $_`;

    }

}

#
