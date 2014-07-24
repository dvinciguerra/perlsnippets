use utf8;
package MyApp::Schema::Result::Privilege;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::Privilege

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<privilege>

=cut

__PACKAGE__->table("privilege");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 title

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "title",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-07-23 14:07:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uFOgC9hDmSIsbB5sye1UBA


# You can replace this text with custom code or comments, and it will be preserved on regeneration


__PACKAGE__->has_many( role_privileges => 'MyApp::Schema::Result::RolePrivilege', {'foreign.privilege_id' => 'self.id'} );
__PACKAGE__->many_to_many( roles => 'role_privileges', 'role');

__PACKAGE__->has_one( menu_item => 'MyApp::Schema::Result::Menu', {'foreign.privilege_id' => 'self.id'} );

1;
