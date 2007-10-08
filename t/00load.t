#!perl -T

# $Id: 00load.t 11 2007-10-08 13:04:50Z frequency $

use Test::More tests => 1;

# Check that we can load the module
BEGIN {
  use_ok('UWO::Student');
}

diag('Testing UWO::Student ', UWO::Student->VERSION);
diag('Running under Perl ', $], ' [', $^X, ']');
