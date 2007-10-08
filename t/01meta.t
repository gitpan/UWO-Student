#!perl -T

# $Id: 01meta.t 13 2007-10-08 13:19:55Z frequency $

use strict;
use warnings;

use Test::More;

eval 'use Test::YAML::Meta';

if ($@) {
  plan skip_all => 'Test::YAML::Meta required to test META.yml';
}

plan tests => 2;

# counts at 2 tests
meta_spec_ok('META.yml', undef, 'META.yml matches the META-spec');
