#!perl -T

# $Id: pod-coverage.t 5 2007-08-22 21:05:21Z frequency $

use strict;
use warnings;

use Test::More;

eval 'use Test::Pod::Coverage 1.04';

if ($@) {
  plan skip_all => 'Test::Pod::Coverage required to test POD Coverage';
}

all_pod_coverage_ok();
