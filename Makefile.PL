use strict;
use warnings;

use ExtUtils::MakeMaker ();

use File::Spec;

my @tests = glob File::Spec->catfile('t', '*.t');

ExtUtils::MakeMaker::WriteMakefile(
  NAME                => 'UWO::Student',
  AUTHOR              => 'Jonathan Yu <frequency@cpan.org>',
  VERSION_FROM        => 'lib/UWO/Student.pm',
  ABSTRACT_FROM       => 'lib/UWO/Student.pm',
  PL_FILES            => {},
  PREREQ_PM => {
    'Carp'            => 0,
    'overload'        => 0,
    'Test::More'      => 0,
  },

  test                => { TESTS => join(' ', @tests) },
  dist                => {
    COMPRESS          => 'gzip -9f',
    SUFFIX            => 'gz',
  },
  clean               => { FILES => 'UWO-Student-*' },
);
