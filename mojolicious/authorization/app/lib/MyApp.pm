package MyApp;
use Mojo::Base 'Mojolicious';

use MyApp::Routes;
use MyApp::Schema;


sub startup {
    my $self = shift;

    # database connect helper
    $self->helper(
        'schema' => sub {
            return MyApp::Schema->init_db->resultset( $_[1] ) if $_[1];
            return MyApp::Schema->init_db;
        }
    );

    $self->helper(
        'dashboard_menu' => sub {
            my $self = shift;

            # gettting all privs
            my $list =
              $self->schema('RolePrivilege')
              ->search({ role_id => { IN => $self->session('roles') || [] } } );

            # getting privs ids
            my @privs = map { $_->privilege_id } $list->all;
            
            return $self->schema('Menu')
                ->search({ privilege_id => {IN => \@privs } });
        }
    );

    $self->plugin(
        'Authorization' => {
            has_priv => sub {
                my ( $self, $privilege, $extra ) = @_;

                # privileges
                my $list =
                  $self->schema('Role')
                  ->search_related( 'role_privileges',
                    { role_id => { IN => $self->session('roles') || [] } } );

                my @list = grep {
                    $_->privilege->name
                      if $_->privilege->name eq $privilege
                } $list->all;

                return 1 if scalar(@list);

                $self->render_not_found;
                return 0;
            },
            is_role => sub {
                my ( $self, $role, $extra ) = @_;

                my @user_roles = grep {
                    $_->name eq $role 
                } $self->schema('Role')->search({ id => { IN => $self->session('roles') || [] } });
                
                return int(@user_roles)? 1 : 0; 
            },
            user_privs => sub {
                my ($self, $extradata) = @_;

                # privileges
                my $list =
                  $self->schema('Role')
                  ->search_related( 'role_privileges',
                    { role_id => { IN => $self->session('roles') || [] } } );

                my @privs = map { $_->privilege->name } $list->all;
                
                return \@privs || [];
            },
            user_role => sub {
                my ($self, $extradata) = @_;

                # privileges
                my $list =
                  $self->schema('Role')
                  ->search({ id => { IN => $self->session('roles') || [] } });

                my @roles = map { $_->name } $list->all;
                
                return \@roles || [];
            },
        }
    );

    # Router
    my $r = $self->routes;
    $r->namespaces( ['MyApp::Controller'] );
    MyApp::Routes->route( $r );

}

1;
