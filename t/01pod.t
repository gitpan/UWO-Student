#!perl -T

# $Id: 01pod.t 10 2007-10-02 02:17:34Z frequency $

use strict;
use warnings;

use Test::More;

eval 'use Test::Pod 1.14';

if ($@) {
  plan skip_all => 'Test::Pod 1.14 required to test POD';
}

all_pod_files_ok();
