#!perl -T

# $Id: overload.t 2 2007-08-22 20:29:23Z frequency $

use Test::More tests => 8;

use UWO::Student;

my $stu = UWO::Student->new;
isa_ok($stu, 'UWO::Student');

# We have nothing so far
is($stu, '<unknown>', 'Undefined user');

# We only have a first name
$stu->given_name('John');
is($stu, 'John', 'First name only');

# We have the full name
$stu->last_name('Doe');
is($stu, 'John Doe', 'Full name');

# We have an e-mail address too
$stu->email('jdoe@uwo.ca');
is($stu, 'John Doe <jdoe@uwo.ca>', 'Name and e-mail address');

# We lack a student number
cmp_ok($stu + 0, '==', 0, 'Empty student number');

# An arbitrary student number
$stu->number(123_456_789);
cmp_ok($stu + 0, '==', 123_456_789, 'Student number (underscore form)');

# Should work without underscores too
$stu->number(123456789);
cmp_ok($stu + 0, '==', 123456789, 'Student number');
