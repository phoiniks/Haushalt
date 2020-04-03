# Haushalt
Erste Notiz über die Funktionsweise der DBIx::Class-Module (ORM)

Dieses Beispiel:

1.      dbicdump -o dump_directory=./lib -o components='["InflateColumn::DateTime"]' Haushalt::Schema dbi:SQLite./haushalt.db

2.      Hauptprogramm erstellen:

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
            printf "%f\n", $messung->warmwasser;
            printf "%f\n", $messung->kaltwasser;
            printf "%f\n", $messung->heizung;
        }

