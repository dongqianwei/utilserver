package Server;
use Dancer;
use Data::Dump 'dump';
use Module::Load::Conditional 'can_load';
use HTML::Entities;
use UtilServ::PageGen;
use strict;

sub get_mod {
    my $mod = shift;
    "UtilServ::Plugin::$mod";
}

sub try_load {
    my $module = shift;
    $module = get_mod $module;
    info "try load module: $module";
    can_load(modules => {$module=>0})
}

get '/' => sub {
    UtilServ::PageGen::sitemap;
};

get '/app/:module' => sub {
    my $module = param 'module';
    try_load $module or
    return "$module can't be loaded -- $@ --";

    my $mod = get_mod $module;
    return "$module did not inherate Plugin::Base!"
        unless $mod->isa('UtilServ::Plugin::Base');

    $mod->page;
};

post '/app/:module' => sub {
    my $data = params;
    info dump $data;
    my $mod = get_mod param 'module';
    my $result = encode_entities $mod->proc($data);
    if ($mod->modget('output') eq 'file') {
        send_file(\$result, filename => 'result.txt');
    }
    else {
        $mod->render_result($result);
    }
};
