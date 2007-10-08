#!perl -T

# $Id: 01pod-coverage.t 10 2007-10-02 02:17:34Z frequency $

use strict;
use warnings;

use Test::More;

eval 'use Test::Pod::Coverage 1.04';

if ($@) {
  plan skip_all => 'Test::Pod::Coverage required to test POD Coverage';
}

all_pod_coverage_ok();
