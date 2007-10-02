#!perl

# Makefile.PL
#  Script to generate an acceptable module Makefile
#
# $Id: Makefile.PL 10 2007-10-02 02:17:34Z frequency $
#
# This helper script is hereby released into the public domain.

use strict;
use warnings;

use ExtUtils::MakeMaker ();

use File::Spec;

my @tests = glob File::Spec->catfile('t', '*.t');

ExtUtils::MakeMaker::WriteMakefile(
  NAME                => 'UWO::Student',
  AUTHOR              => 'Jonathan Yu <frequency@cpan.org>',
  LICENSE             => 'bsd',
  VERSION_FROM        => 'lib/UWO/Student.pm',
  ABSTRACT_FROM       => 'lib/UWO/Student.pm',
  PL_FILES            => {},
  PREREQ_PM => {
    # Pragmatic and special modules
    'overload'        => 0,
    'Carp'            => 1.04,

    # Other modules
    'Test::More'      => 0.62,
  },

  test                => { TESTS => join(' ', @tests) },
  dist                => {
    COMPRESS          => 'gzip -9f',
    SUFFIX            => 'gz',
  },
  clean               => { FILES => 'UWO-Student-*' },
);
