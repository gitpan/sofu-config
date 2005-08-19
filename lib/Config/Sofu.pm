package Config::Sofu;
use Data::Sofu;
use strict;
use warnings;
require Exporter;
use vars qw/$VERSION @EXPORT @ISA %CONFIG/;

$VERSION="0.1";
@ISA = qw(Exporter);
@EXPORT=qw/%CONFIG/;
%CONFIG=();

sub import {
	my $class=shift;
	my $file=shift;
	die "Usage: use Config::Sofu \"file\"" if ref $file or not -e $file;
	$Config::Sofu::file=$file;
	$Config::Sofu::Sofu=Data::Sofu->new;
	%Config::Sofu::CONFIG=$Config::Sofu::Sofu->read($file);
	$Config::Sofu::Comment=$Config::Sofu::Sofu->comment if $Data::Sofu::VERSION ge "0.23";
	Config::Sofu->export_to_level(1, '%CONFIG');
}
sub save {
	my %CONF=%Config::Sofu::CONFIG;
	%CONF={@_} if @_;
	if ($Data::Sofu::VERSION ge "0.23") {
		die (%$Config::Sofu::Comment);
		#$Config::Sofu::Sofu->write($Config::Sofu::file,\%CONF,$Config::Sofu::Comment);
	}
	else {
		#$Config::Sofu::Sofu->write($Config::Sofu::file,\%CONF);
	}
}
1;

=head1 SYNOPSIS

	use vars qw/%CONFIG/; 
	use Config::Sofu "config.sofu"; 
	if ($CONFIG{FOOBAR}) {
		...
	}
	if ($CONFIG{Bar}->[7]->{Foo} eq "Foobar") {
		...
	}
	
Save the new configuration:

	Config::Sofu::save(%NEWCONFIG)

=head1 SYNTAX

This class exports the hash %CONFIG by default which contains all the information of the file which is given to the use statement.

=head1 FUNCTIONS AND METHODS


=head2 save

Save the new configuration of to the same file again

=head1 BUGS

The comments in the sofu-file will only be saved again if Data::Sofu >= 0.2.3 is installed.

=head1 SEE ALSO

Data::Sofu,perl(1),L<http://sofu.sf.net>



=cut
