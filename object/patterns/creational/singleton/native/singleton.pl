package Singleton;

our $_instance;

## attributes
sub name {
    my ($self, $value) = @_;
    $self->{_name} = $value if $value;
    return $self->{_name};
}

## methods
sub instance {
    my $class = shift;
    $_instance = bless {}, $class unless $_instance;
    return $_instance;
}



package main;
use 5.10.0;
use strict;
use warnings;

# Foo
my $obj = Singleton->instance;
$obj->name('Foo');
say "Setted: ". $obj->name;
undef $obj;

# Bar
$obj = Singleton->instance;
say "Old: ". $obj->name;
$obj->name('Bar');
say "Setted: ". $obj->name;
undef $obj;

# Baz
$obj = Singleton->instance;
say "Old: ". $obj->name;
$obj->name('Baz');
say "Setted: ". $obj->name;
undef $obj;

