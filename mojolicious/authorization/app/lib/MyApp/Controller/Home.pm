package MyApp::Controller::Home;
use Mojo::Base 'MyApp::Controller::Base';

sub login {
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
}

sub dashboard {
    my $self = shift;
}

sub common {}

sub client_only {}

sub admin_only {}



1;
