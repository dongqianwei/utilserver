package UtilServ::Plugin::Base;
use UtilServ::Config;
use Carp;
use strict;

=head

    method : proc

    plugin must implement this method

=cut

sub proc {
    my $class = ref $_[0] ? ref $_[0] : $_[0];
    die "plugin $class must implement proc method";
}

=head

    method : page
    default page which contains a textarea to send data

    you can override the ui,
    but promise all data could be accessd by key 'data'

    data will be passed to method porc

=cut

sub page {
    my ($mod) = $_[0] =~ /::([^:]*)$/;
<<PG;
<html>
<body>
<form method="post" action="/app/$mod">
<textarea rows="40" cols="140" name="data"></textarea>
<input type="submit"></input>
</form>
</body>
</html>
PG
}

=head

    method: modset, modget
    config modules

=cut

sub modset {
    croak "params num must be 3" unless @_ == 3;
    confset @_;
}

sub modget {
    croak "params num must be 3" unless @_ == 2;
    confget @_;
}

1;
