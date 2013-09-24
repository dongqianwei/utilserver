package UtilServ::Config;
use parent Exporter;
use Carp;
use strict;
use vars qw[@EXPORT];
@EXPORT = qw[confset confget];

# valid config key:
# output : when set 'file', output will be download as file.

my %keyset = qw(
              output => 1;
              );

#configation store
my %conf;

sub confset {
    my ($mod, $key, $val) = @_;
    croak "key not exists" unless $keyset{$key};
    $conf{$mod}{$key} = $val;
}

sub confget {
    my ($mod, $key) = @_;
    croak "key not exists" unless $keyset{$key};
    $conf{$mod}{$key} || 0;
}

1;
