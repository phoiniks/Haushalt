#!/usr/bin/perl
use Modern::Perl;
use diagnostics;

use FindBin;

BEGIN {
    use lib "$FindBin::Bin/lib";
}

use File::Copy;
use File::HomeDir qw( home );
use Haushalt::Schema;


print "Kaltwasserzähler: ";
chomp (my $kaltwasser = <STDIN>);

print "Warmwasserzähler: ";
chomp (my $warmwasser = <STDIN>);

print "Heizung: ";
chomp (my $heizung    = <STDIN>);

my $schema = Haushalt::Schema->connect("dbi:SQLite:dbname=haushalt.db", "", "", { PrintError => 1, RaiseError => 1 });

my $messung = $schema->resultset( 'WasserUndHeizung' )->new( { warmwasser => $warmwasser, kaltwasser => $kaltwasser, heizung => $heizung } );

$messung->insert;

copy("haushalt.db", home());
