# Haushalt
Erste Notiz über die Funktionsweise der DBIx::Class-Module (ORM) unter Debian Buster

Natürlich findet man mit Hilfe von perldoc DBIx::Class eine Menge hilfreicher Informationen.
Und natürlich weiß man danach immer alles besser...
Aber ein paar einfachere Beispiele -- unter Einsatz von dbicdump wären für den Anfang nützlicher,
um die Funktionsweise und den unglaublichen Komfort des objektrelationalen Mappints unter Perls
DBIx zu verdeutlichen.

Daher dieses Beispiel:

1.      cd /home/$USER/Haushalt

2.      dbicdump -o dump_directory=./lib -o components='["InflateColumn::DateTime"]' Haushalt::Schema dbi:SQLite./haushalt.db
        Dieser Befehl erstellt im Verzeichnis Haushalt -- in dem natürlich die SQLite3-Datenbank haushalt.db liegen muss --
        eine Verzeichnishierarchie:

        lib--|
             Haushalt--|
                       Schema--|
                               Result

        Im Verzeichnis Schema befindet sich darüber hinaus das automatisch (durch dbicdump) generierte Modul Schema.pm
        und im Verzeichnis Result WasserUndHeizung.pm (dass dbicdump aus einer Tabelle namens wasser_und_heizung generiert hat.
        Dieses Modul enthält die Klasse 'WasserUndHeizung', die ihrerseits die Felder der Tabelle abbildet.
        Die Datenbank lege ich der Einfachheit halber bei. Um sich die Funktionsweise zu verdeutlichen, sollte man die
        Prozedur vielleicht kurz durchspielen: Per git clone https://github.com/phoiniks/Haushalt das Verzeichnis auf die
        eigene Platte befördern. Dann lib rekursiv löschen (rm -rf lib) und den unter 1. angegebenen Befehl eintippen sowie
        per Return alles Weitere veranlassen...

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

=============================================================================================================================================================

Weiteres Beispiel, diesmal für eine auf localhost (127.0.0.1) installierte MariaDB:

dbicdump -o dump_directory=./ -o components='["InflateColumn"]' \\ \n
Bewerbungen::Schema 'dbi:MariaDB:database=datenbank;host=127.0.0.1;port=3306' \\ \n
benutzer passwort

(Backslash zur Verhinderung des Zeilenumbruchs im Befehl)
