#!perl -T

# $Id: 00-load.t 2 2007-08-22 20:29:23Z frequency $

use Test::More tests => 1;

# Check that we can load the module
BEGIN {
  use_ok('UWO::Student');
}

diag('Testing UWO::Student ', UWO::Student->VERSION);
diag(' Running under Perl ', $], ' [', $^X, ']');
