#!perl
use warnings;
use strict;
use 5.014;


=pod

=head1 EJECUCION

perl 02yhernandez.pl <FILE>...

=head2 DESCRIPCION

Es obligatorio introducir una ruta de un archivo de texto valido para analizar y obtener informacion. 

=head3 FUNCIONAMIENTO

Este programa analiza archivos en busca de patrones de: IP, Email, URL, Dominio.

=head4 CREACION

Yeudiel Hernandez Torres - PBSI 11G

=cut

my @FCG;
my $file = $ARGV[0];
my $out='out.txt';
my %email=();
my %url=();
my %dominio=();
my %ip=();
my $a = $_;
my $edif=0;
my $udif=0;
my $ddif=0;
my $idif=0;
my $etotal=0;
my $utotal=0;
my $dtotal=0;
my $itotal=0;

if (not defined $file) {die "Por favor revisa la documentacion con \"perldoc regex.pl\"\n";}



open(FCG, "<" ,$file) or die ("No se puede abrir $file\n");
while(<FCG>){
	chomp;
	if($a=/[a-z\.\-]+\@([a-z\-]+\.){1,}[a-z]+/){	#correos
		if(exists $email{$&}){
			$email{$&}++;
		}else{
			$email{$&}=1;
			$edif++;
		}
		$etotal++;
	}

	if($a=/\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b/){	#ips
		if(exists $ip{$&}){
                        $ip{$&}++;
                }else{
                        $ip{$&}=1;
                        $idif++;
                }
                $itotal++;
	}
		
	if(/([a-z]+\.){1,}+\w+\//){			#dominios
		if(exists $dominio{$&}){
                        $dominio{$&}++;
                }else{
                        $dominio{$&}=1;
                        $ddif++;
                }
                $dtotal++;
        }

	if(/https?:[^\s<>"\[\]\.]+(\.[^\s<>"\[\]]+){1,}/){	#url
		if(exists $url{$&}){
                        $url{$&}++;
                }else{
                        $url{$&}=1;
                        $udif++;
                }
                $utotal++;
        }
	
}

close(FCG);

open(FH, '>', $out) or die ("ERROR '$out' $!");

print FH "Correos Encontrados --> $etotal\n";
print FH "Correos Diferentes  --> $edif\n\n";
print FH "TOTAL\t|\tEMAIL\n";

for (keys %email){
	print FH "$email{$_}\t|\t$_\n";
}

print FH "\n\nIPs Encontradas --> $itotal\n";
print FH "IPs Diferentes  --> $idif\n\n";
print FH "TOTAL\t|\tIP\n";

for (keys %ip){
        print FH "$ip{$_}\t|\t$_\n";
}

print FH "\n\nDominios Encontrados --> $dtotal\n";
print FH "Dominios Diferentes  --> $ddif\n\n";
print FH "TOTAL\t|\tDOMINIO\n";
for (keys %dominio){
        print FH "$dominio{$_}\t|\t$_\n";
}


print FH "\n\nURLs Encontradas --> $utotal\n";
print FH "URLs Diferentes  --> $udif\n\n";
print FH "TOTAL\t|\tURL\n";
for (keys %url){
        print FH "$url{$_}\t|\t$_\n";
}

close FH;

say "Correos encontrados --> $etotal";
say "Correos Diferentes --> $edif";

say "IPs encontradas --> $itotal";
say "IPs Diferentes --> $idif";

say "Dominios encontrados --> $dtotal";
say "Dominios Diferentes --> $ddif";

say "URLs encontradas --> $utotal";
say "URLs Diferentes --> $udif";
