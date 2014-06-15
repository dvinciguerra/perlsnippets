#!/usr/bin/env perl
use Mojolicious::Lite;

get '/' => sub {
    my $self = shift;

    # make "fake" authentication
    $self->session( uid => 1 ) if $self->param('login');

} => 'index';

get '/logout' => sub {
    my $self = shift;
    $self->session(expires => 1);
    return $self->redirect_to('/');
};

# you can use under here too

get '/image/:filename' => sub {
    my $self = shift;

    # getting filename
    my $format   = $self->stash('format')   || '';
    my $filename = $self->param('filename') || '';

    #return $self->render( text => $self->session('uid') || 'none' );
    warn "/home/dvinciguerra/Desktop/image-route/public/${filename}.${format}";

    # dummy authentication checking
    if($self->session('uid')){

        # check file exists
        if (-e "/home/dvinciguerra/Desktop/image-route/public/${filename}.${format}") {
            
            # output file data
            my $file = Mojo::Asset::File->new(
                path => "/home/dvinciguerra/Desktop/image-route/public/${filename}.${format}"
            );

            return $self->render( data => $file->slurp );
        }
    }
    else {
        # output file data (unauthenticated)
        my $file = Mojo::Asset::File->new(
            path => "/home/dvinciguerra/Desktop/image-route/public/default.jpg"
        );

        return $self->render( data => $file->slurp, format => 'jpeg' );
    }
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome';
Welcome to the Mojolicious real-time web framework!

<p>
    %= link_to url_for->query(login => 1)->to_abs => begin
        Fake Login
    % end
</p>
<p>
    %= link_to '/logout' => begin
        Logout
    % end
</p>
<p>
    %= link_to '/image/avatar.jpg' => begin
        Goto Image
    % end
</p>


@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
