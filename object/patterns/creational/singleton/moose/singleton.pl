package Singleton;
use MooseX::Singleton;

## attributes
has name => (
    is => 'rw', isa => 'Str' 
);



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

