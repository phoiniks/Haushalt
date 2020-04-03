use utf8;
package Haushalt::Schema::Result::WasserUndHeizung;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Haushalt::Schema::Result::WasserUndHeizung

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<wasser_und_heizung>

=cut

__PACKAGE__->table("wasser_und_heizung");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 warmwasser

  data_type: 'real'
  is_nullable: 1

=head2 kaltwasser

  data_type: 'real'
  is_nullable: 1

=head2 heizung

  data_type: 'real'
  is_nullable: 1

=head2 zeit

  data_type: 'date'
  default_value: DATETIME('NOW', 'LOCALTIME')
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "warmwasser",
  { data_type => "real", is_nullable => 1 },
  "kaltwasser",
  { data_type => "real", is_nullable => 1 },
  "heizung",
  { data_type => "real", is_nullable => 1 },
  "zeit",
  {
    data_type     => "date",
    default_value => \"DATETIME('NOW', 'LOCALTIME')",
    is_nullable   => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-04-03 10:48:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oT11PniBI0OJ6Jjc/K3kxQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
