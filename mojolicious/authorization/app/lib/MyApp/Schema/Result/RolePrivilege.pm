use utf8;
package MyApp::Schema::Result::RolePrivilege;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::RolePrivilege

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<role_privilege>

=cut

__PACKAGE__->table("role_privilege");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 role_id

  data_type: 'integer'
  is_nullable: 0

=head2 privilege_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "role_id",
  { data_type => "integer", is_nullable => 0 },
  "privilege_id",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-07-23 14:07:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3mBHDRA24t7LnW6IrqJxyA


# You can replace this text with custom code or comments, and it will be preserved on regeneration

__PACKAGE__->belongs_to( role => 'MyApp::Schema::Result::Role', {'foreign.id' => 'self.role_id'} );
__PACKAGE__->belongs_to( privilege => 'MyApp::Schema::Result::Privilege', {'foreign.id' => 'self.privilege_id'} );

1;
