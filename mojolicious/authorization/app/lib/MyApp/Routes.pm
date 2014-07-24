package MyApp::Routes;
use Mojo::Base -strict;

sub route {
    my ($self, $r) = @_;

    # invalid param
    die "Not mojolicious route class"
        unless $r || $r->isa('Mojolicious::Route');

    # Normal route to controller
    $r->get('/')->to('home#index');
    $r->any('/login')->to('home#login');

    ##########################
    ## User Authentication
    ##########################
    my $auth = $r->under( sub {
            return shift->session('uid')? 1 : 0;
    });

    # default profile    
    $auth->get('/dashboard')->over( has_priv => 'dashboard' )
        ->to('home#dashboard');

    $auth->get('/common')->over( has_priv => 'common' )
        ->to('home#common');

    $auth->get('/client-only')->over( has_priv => 'client-only' )
        ->to('home#client_only');

    $auth->get('/admin-only')->over( has_priv => 'admin-only' )
        ->to('home#admin_only');

    return $r;
}

1;
