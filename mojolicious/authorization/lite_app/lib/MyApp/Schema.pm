use utf8;
package MyApp::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-07-23 14:07:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UokHCEHYotQXbhOiHYN0MQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub init_db {
    return __PACKAGE__->connect(
        'dbi:SQLite:dbname=database.db', undef, undef
    );
}

1;
