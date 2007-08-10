#!perl -T

use Test::More tests => 33;

use UWO::Student;

# Check all core methods are defined
my @methods = (
  'new',

  # One-variable accessor/mutator methods
  'email',
  'number',
  'faculty',

  # Name information
  'name',
  'given_name',
  'last_name',

  # Full user stringification
  'as_string',
);

foreach my $meth (@methods) {
  ok(UWO::Student->can($meth), 'Method "' . $meth . '" exists.');
}

# Test the constructor initialization
my $stu = UWO::Student->new({
  given_name  => 'Jane',
  last_name   => 'Doe',
  faculty     => 'Faculty of Education',
  email       => 'jdoe@uwo.ca',
  number      => 127231623,
});
isa_ok($stu, 'UWO::Student');

is($stu->name, 'Jane Doe', 'Friendly name correctness');
is($stu->given_name, 'Jane', 'Given name correctness');
is($stu->last_name, 'Doe', 'Surname correctness');
is($stu->faculty, 'Faculty of Education', 'Faculty name correctness');
cmp_ok($stu->number, '==', 127_231_623, 'Student number correctness');
is($stu->email, 'jdoe@uwo.ca', 'E-mail address correctness');
is($stu->as_string, 'Jane Doe <jdoe@uwo.ca>', 'Stringification correctness');

# Check each variable's mutator and accessor methods
# Also test the stringification at every step
$stu = UWO::Student->new;

is($stu->name, '', 'Friendly name empty');
is($stu->as_string, '<unknown>', 'Stringification is <unknown>');

is($stu->given_name, '', 'Given name empty');
$stu->given_name('John');
is($stu->given_name, 'John', 'Given name is "John"');

is($stu->name, 'John', 'Friendly name is "John"');
is($stu->as_string, 'John', 'Stringification is "John"');

is($stu->last_name, '', 'Surname empty');
$stu->last_name('Doe');
is($stu->last_name, 'Doe', 'Surname is "John"');

is($stu->name, 'John Doe', 'Friendly name is "John Doe"');
is($stu->as_string, 'John Doe', 'Stringification is "John Doe"');

is($stu->faculty, '', 'Faculty is empty');
$stu->faculty('Faculty of Arts and Humanities');
is($stu->faculty, 'Faculty of Arts and Humanities', 'Faculty is defined');

is($stu->email, '', 'E-mail address is empty');
$stu->email('jdoe@uwo.ca');
is($stu->email, 'jdoe@uwo.ca', 'Mail address is defined');
is($stu->as_string, 'John Doe <jdoe@uwo.ca>', 'Stringification is "John Doe ' .
  '<jdoe@uwo.ca>"');

cmp_ok($stu->number, '==', 0, 'Student number unknown');
$stu->number(987_654_321);
cmp_ok($stu->number, '==', 987_654_321, 'Student number set');
