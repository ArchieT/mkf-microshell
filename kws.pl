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
print << "END";
#ifndef KWH_$prefix\n
#define KWH_$prefix\n\n
END
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
        "extern const char* const KWS_${prefix}[] = {", "\n",
        "\t\"$stringsliteral\"\n",
        "};\n";

my %kws;
@kws{@strings} = @names;
my %kwt;
while ((my $string, my $name) = each (%kws)) {
        my $kwtref = \%kwt;
        for(; length $string > 0; $string = substr $string, 1) {
                $$kwtref{ord $string} = {}
                        unless exists($$kwtref{ord $string});
                $kwtref = $$kwtref{ord $string};
        }
        $$kwtref{0} = $name;

}

use Storable qw(dclone);

my %kwtpoppy = %{ dclone (\%kwt) };
my @kwtsor;
my @kwtpoista;
sub kwt_trav {
        # ukladamy liste nodow
        # wartosc dlugosc_syna&co syn&co [brat&co]...
        # wrzucajac node'a trzeba miec calkowita jego wielkosc
        # chcemy posortowane node'y leksykograficznie
        #my $kwtref
}

use Data::Dumper;
print STDERR Dumper(%kwt);

print "\n#endif // KWH_$prefix\n";