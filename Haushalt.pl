#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;

use FindBin;

BEGIN {
    use lib "$FindBin::Bin/lib";
}

use Haushalt::Schema;

my $schema = Haushalt::Schema->connect("dbi:SQLite:dbname=haushalt.db", "", "", { PrintError => 1, RaiseError => 1 })
    or die "Fehler: ", $!;

my @all_messungen = $schema->resultset( 'WasserUndHeizung' )->all;

foreach my $messung ( @all_messungen ){
    printf "%d\n", $messung->id;
    printf "\t%.3f\n", $messung->warmwasser;
    printf "\t%.3f\n", $messung->kaltwasser;
    printf "\t%.3f\n", $messung->heizung;    
}

