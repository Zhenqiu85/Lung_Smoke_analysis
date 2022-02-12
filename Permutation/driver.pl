#!/usr/bin/perl
use strict;
use warnings;
use Math::Random qw(random_uniform_integer);

=cut

# generate 2000 gene sets

my $num=84;
my $group="Yoshida";

open(F,"/gs/gsfs0/users/zhehuang/projects/Smoke_result_compile/Driver/All.txt");
my @gene;
while (my $content=<F>) {
	chomp $content;
	push @gene,$content;
}
close(F);
unshift @gene,"Gene";
#print $gene[0]."\t".$gene[19861];

open(F,"/gs/gsfs0/users/zhehuang/projects/Smoke_result_compile/Driver/exon_cds_merged_gene");
my %info;
while (my $content=<F>) {
	my @data=split(/\t/,$content);
	chomp $data[3];
	if (exists $info{$data[3]}) {
		my $temp=$info{$data[3]};
		$info{$data[3]}=$temp.$content;
	}
	else {
		$info{$data[3]}=$content;
	}
}
close(F);

for (my $i=1; $i<=2000; $i++) {
	my %hash;
	open(R,">/gs/gsfs0/users/zhehuang/projects/Smoke_result_compile/Driver/$group\/$i.txt");
	for (my $j=1; $j<=$num; $j++) {
		 my $pos=random_uniform_integer(1,1,19861);
		 if (exists $hash{$pos}) {
		 	$j--;
		 }
		 else {
		 	print R $info{$gene[$pos]};
		 }
	}
	close(R);
	
	#last;
}

=cut

# prepare gene set itself

open(F,"/gs/gsfs0/users/zhehuang/projects/Smoke_result_compile/Driver/exon_cds_merged_gene");
my %info;
while (my $content=<F>) {
	my @data=split(/\t/,$content);
	chomp $data[3];
	if (exists $info{$data[3]}) {
		my $temp=$info{$data[3]};
		$info{$data[3]}=$temp.$content;
	}
	else {
		$info{$data[3]}=$content;
	}
}
close(F);

#95
#open(F,"LungCancer.txt");
#open(R,">LungCancer.bed");
#530
#open(F,"PanCancer.txt");
#open(R,">PanCancer.bed");
#84
open(F,"/gs/gsfs0/users/zhehuang/projects/Smoke_result_compile/Driver/YoshidaCancer.txt");
open(R,">/gs/gsfs0/users/zhehuang/projects/Smoke_result_compile/Driver/YoshidaCancer.bed");
while (my $content=<F>) {
	chomp $content;
	print R $info{$content};
}
close(R);
close(F);






