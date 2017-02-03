#!perl
use warnings;
use strict;

=pod

=head1 EJECUCION

perl 01yhernandez.pl

=head2 DESCRIPCION
	
Este script muestra los numeros impares que existe en el rango
del 1 al 10

=head3 PRAGMA

Son directivas que se activan con la palabra reservada "use".
Influencian aspectos en tiempo de compilacion y comportamiento en tiempo de ejecucion

=cut


my @a =(1..10);

for (@a){
	if($_ % 2 != 0){
		print $_,"\n"; 
	} 

}


