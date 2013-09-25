use File::Copy::Recursive qw[dircopy fcopy];
use File::Path;
use strict;

rmtree 'publish' if -d 'publish';
mkdir 'publish';

dircopy('lib/', 'publish');
dircopy('public','publish/public');
fcopy('bin/utilsrv.pl', 'publish/utilsrv.pl');

print 'published!';
