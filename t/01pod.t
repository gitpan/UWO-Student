#!perl -T

# $Id: pod.t 5 2007-08-22 21:05:21Z frequency $

use strict;
use warnings;

use Test::More;

eval 'use Test::Pod 1.14';

if ($@) {
  plan skip_all => 'Test::Pod 1.14 required to test POD';
}

all_pod_files_ok();
