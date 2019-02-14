#!/usr/bin/perl

use strict;
use warnings;

use 5.026;

my @names;
my @strings;

my $prefix = <STDIN>;
die "no prefix provided, starts with $prefix"
        unless $prefix =~ s/^\^//;
chomp( $prefix );

foreach my $line ( <STDIN> ) {
        chomp( $line );
        my @split = split(/\t/, $line, 2);
        my $name = shift @split;
        break   unless defined $name;
        push @names, $name;
        my $string = shift @split;
        die "no string for $name"
                unless defined $string;
        push @strings, $string;
}
print "enum KW_$prefix {", "\n\t";
my $pozycja;
$pozycja = 0;
print join ", \n\t", map {
        ++$pozycja;
        my $result = "KW_${prefix}_$_ = $pozycja";
        $result;
} @names;
my $stringsliteral = join "\", \n\t\"", @strings;
print "\n};\n\n",
        "extern const char* KWS_${prefix}[] = {", "\n",
        "\t\"$stringsliteral\"\n",
        "};\n";

my %kws;
@kws{@strings} = @names;