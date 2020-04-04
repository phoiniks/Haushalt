#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;

use utf8;

use FindBin;

BEGIN {
    use lib "$FindBin::Bin/lib";
}

use Haushalt::Schema;

use Modern::Perl;

print "Kaltwasserzähler: ";
chomp (my $kaltwasser = <STDIN>);

print "Warmwasserzähler: ";
chomp (my $warmwasser = <STDIN>);

print "Heizung: ";
chomp (my $heizung    = <STDIN>);

my $schema = Haushalt::Schema->connect("dbi:SQLite:dbname=haushalt.db", "", "", { PrintError => 1, RaiseError => 1 });

my $messung = $schema->resultset( 'WasserUndHeizung' )->new( { warmwasser => $warmwasser, kaltwasser => $kaltwasser, heizung => $heizung } );

$messung->insert;
