#!/usr/bin/env perl
use Mojolicious::Lite;

BEGIN { unshift @INC, 'lib/' }

use MyApp::Schema;

# database connect helper
helper 'schema' => sub {
    return MyApp::Schema->init_db->resultset( $_[1] ) if $_[1];
    return MyApp::Schema->init_db;
};

helper 'has_privileges' => sub {
    my ($self, $privilege) = @_;

    # privileges 
    my $list = $self->schema('Role')
        ->search_related('role_privileges', { role_id => { IN => $self->session('roles') } });

    my @list = grep { 
        $_->privilege->name if $_->privilege->name eq $privilege 
    } $list->all;

    return 1 if scalar(@list);

    $self->render_not_found;
    return 0;
};

helper 'user_privileges' => sub {
    my ($self, $privilege) = @_;

    # privileges 
    my $list = $self->schema('Role')
        ->search_related('role_privileges', { role_id => { IN => $self->session('roles') } });

    my @list = map { $_->privilege_id } $list->all;
    return \@list || [];
};

any '/login' => sub {
    my $self = shift;

    my $user = $self->param('user') || undef;
    my $pass = $self->param('pass') || undef;

    my $model = $self->schema('User')
        ->find({email => $user, password => $pass});

    # found
    if($model){
        my @roles = map { $_->id } $model->roles;

        # setting session keys
        $self->session(
            uid => $model->id,
            roles => \@roles 
        );

        return $self->redirect_to('/dashboard');
    }
    else {
        return $self->render(
            message => 'User or pass wrong'
        )
    }

    return $self->render( message => '' );
} => 'login';

get '/' => sub {
    my $self = shift;

    # privileges 
    my $list = $self->schema('Role')
        ->search_related('role_privileges', { role_id => { IN => [1, 2] } });

    my @list = map { $_->privilege->name } $list->all;

    return $self->render( 
        text => $self->app->dumper( \@list  ) 
    );
} => 'index';


under sub {
    my $self = shift;
    return 1 if $self->session('uid');
};

get '/dashboard' => sub {
    my $self = shift;
    return unless $self->has_privileges('dashboard');

    warn "page: dashboard \n";
} => 'dashboard';

get '/common' => sub {
    my $self = shift;
    return unless $self->has_privileges('common');
    
    warn "page: common \n";
    return $self->render( text => 'Common Page of Love' );
};

get '/admin-only' => sub {
    my $self = shift;
    return unless $self->has_privileges('admin-only');

    warn "page admin \n";
} => 'admin_only';

get '/client-only' => sub {
    my $self = shift;
    return unless $self->has_privileges('client-only');

    warn "page client \n";
} => 'admin_only';


app->start;

__DATA__

@@ login.html.ep
%= form_for '', method => 'post' => begin
    <p>Email<br><input type="text" name="user"></p>
    <p>Pass<br><input type="password" name="pass"></p>
    <p><button type="submit">Login</button></p>
% end
%= eval{ $message } || ''

@@ dashboard.html.ep
Hello Dash
<ul>
% for my $row (schema('Role')->search_related('role_privileges', { role_id => { IN => session('roles') } }) ) {
    <li><a href="#"></a><%= $row->privilege->name %></li>
% }    
</ul>

@@ admin_only.html.ep
Hello Admin Only


