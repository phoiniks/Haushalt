# Haushalt
Erste Notiz über die Funktionsweise der DBIx::Class-Module (ORM) unter Debian Buster

Natürlich findet man mit Hilfe von perldoc DBIx::Class eine Menge hilfreicher Informationen.
Und natürlich weiß man danach immer alles besser...
Aber ein paar einfachere Beispiele -- unter Einsatz von dbicdump wären für den Anfang nützlicher,
um die Funktionsweise zu verdeutlichen.

Daher dieses Beispiel:

1.      cd /home/$USER/Haushalt

2.      dbicdump -o dump_directory=./lib -o components='["InflateColumn::DateTime"]' Haushalt::Schema dbi:SQLite./haushalt.db

3.      Hauptprogramm erstellen:

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

