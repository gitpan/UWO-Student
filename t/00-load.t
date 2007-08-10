#!perl -T

use Test::More tests => 1;

# Check that we can load the module
sub BEGIN {
  use_ok('UWO::Student');
}

diag('Testing UWO::Student ', UWO::Student->VERSION);
diag(" Running under Perl $], $^X");
