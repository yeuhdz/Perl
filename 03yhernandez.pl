#!/usr/bin/perl
use warnings;
#use strict;
use HTML::Template; ##importa codigo 


=pod

=head1 EJECUCION

	perl 03yhernandez.pl

=head2	DESCRIPCION

Este programa se ejecuta sin recibir parametros. El archivo a leer debe de encontrarse en el mismo directorio que este script con
el nombre "datos.txt". Al igual que el archivo template.tmpl con los cuales genera un nuevo archivo HTML que muestra la informacion recabada.

=head3 	CREADO POR:

Yeudiel Hernandez Torres PBSI 11g

=cut




open FILE,">prueba.html" or die "Error";
print FILE &show();
close FILE;
sub show{
		my $output;
		my $template = HTML::Template->new(filename => './template.tmpl');
		my $info=&info();
		my @loop_data=();
		while(@{$info->[0]}){
				my %row_data;
				$row_data{user}=shift @{$info->[0]};
				$row_data{pass}=shift @{$info->[1]};
				$row_data{uid}=shift @{$info->[2]};
				$row_data{gid}=shift @{$info->[3]};
				$row_data{gecos}=shift @{$info->[4]};
				$row_data{home}=shift @{$info->[5]};
				$row_data{shell}=shift @{$info->[6]};
				push(@loop_data,\%row_data);
	
		}
		$template->param(hash2 => \@loop_data);
		$output.=$template->output(); #guarda toda la salida que genera el tamplate
		#print $output;
		return $output;
}
sub info{
	my $list=&list();
	my @user;
	my @pass;
	my @uid;
	my @gid;
	my @gecos;
	my @home;
	my @shell;

	foreach my $user(sort keys %$list)		##### porque usar %$ ????
	{
		push(@user,$list->{$user}->{user}); 
                push(@pass,$list->{$user}->{pass}); 
                push(@gid,$list->{$user}->{gid}); 
                push(@uid,$list->{$user}->{uid});
                push(@gecos,$list->{$user}->{desc});
                push(@home,$list->{$user}->{home});
                push(@shell,$list->{$user}->{shell});
	}

	my @info=(\@user,\@pass,\@uid,\@gid,\@gecos,\@home,\@shell);
	return \@info;
}


sub list{
	my %hash2;
	my $filename="datos.txt";

	open ARC,"<", $filename;
	my @file=(<ARC>);
	for (@file){
	        my %hash;
	        if(m{(.*):(.*):(.*):(.*):(.*):(.*):(.*)}){
	                $hash{"user"}=$1;
	                $hash{"pass"}=$2;
	                $hash{"uid"}=$3;
	                $hash{"gid"}=$4;
	                $hash{"desc"}=$5;
	                $hash{"home"}=$6;
	                $hash{"shell"}=$7;
	        }
			$hash2{$hash{"user"}}=\%hash;
	}
		close ARC;
		return \%hash2;
		
}
