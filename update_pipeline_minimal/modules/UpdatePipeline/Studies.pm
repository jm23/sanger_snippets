=head1 NAME

Studies.pm   - Take in a filename and extract a list of study ids

=head1 SYNOPSIS
use UpdatePipeline::Studies;
my @study_ids = UpdatePipeline::Studies->new(filename => $studyfile);

=cut
package UpdatePipeline::Studies;
use Moose;

has 'filename'    => ( is => 'rw', required => 1 );
has 'study_ids'   => ( is => 'rw', isa => 'ArrayRef[Int]', lazy_build => 1 );

sub _build_study_ids
{
  my ($self) = @_;
  my @studies;
  
  if ( -s $self->filename ) {
      open( my $STU, $self->filename ) or die "Can't open $self->filename: $!\n";
      while (<$STU>) {
          if ($_) {    #Ignore empty lines
              chomp;
              push( @studies, $_ );
          }
      }
      close $STU;
  }
  return \@studies;
}

__PACKAGE__->meta->make_immutable;

no Moose;

1;
