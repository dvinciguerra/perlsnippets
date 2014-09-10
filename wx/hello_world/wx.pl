#!/usr/bin/env perl 
use strict;
use warnings;

use FindBin;

use Wx;
use Wx::Perl::SplashFast ("$FindBin::Bin/splash.png",3000);
# timeout in milliseconds

sleep(3);

my $app = Wx::SimpleApp->new;
my $frame = Wx::Frame->new( undef, -1, 'Hello, world!' );
 
$frame->Show;
$app->MainLoop;
