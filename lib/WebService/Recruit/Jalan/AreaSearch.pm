package WebService::Recruit::Jalan::AreaSearch;
use strict;
use vars qw( $VERSION );
use base qw( WebService::Recruit::Jalan::API );
$VERSION = '0.07';

sub url { 'http://jws.jalan.net/APICommon/AreaSearch/V1/'; }
sub force_array { [qw( Region Prefecture LargeArea SmallArea )]; }

sub elem_class { 'WebService::Recruit::Jalan::AreaSearch::Element'; }
sub query_class { 'WebService::Recruit::Jalan::AreaSearch::Query'; }

sub total_entries { 1 }     # dummy (override)
sub entries_per_page { 1 }
sub current_page { 1 }

package WebService::Recruit::Jalan::AreaSearch::Query;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw(
    key reg pref l_area
));

package WebService::Recruit::Jalan::AreaSearch::Element;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( Results ));

package WebService::Recruit::Jalan::AreaSearch::Element::Results;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw(
    APIVersion Area
));

package WebService::Recruit::Jalan::AreaSearch::Element::Area;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( Region ));

package WebService::Recruit::Jalan::AreaSearch::Element::Region;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( cd name Prefecture ));

package WebService::Recruit::Jalan::AreaSearch::Element::Prefecture;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( cd name LargeArea ));

package WebService::Recruit::Jalan::AreaSearch::Element::LargeArea;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( cd name SmallArea ));

package WebService::Recruit::Jalan::AreaSearch::Element::SmallArea;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( cd name ));

=head1 NAME

WebService::Recruit::Jalan::AreaSearch - Jalan Web Service "AreaSearch" API

=head1 SYNOPSIS

    use WebService::Recruit::Jalan;

    my $jalan = WebService::Recruit::Jalan->new();
    $jalan->key( 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' );

    my $param = {
        reg     =>  '15',
    };
    my $res = $jalan->AreaSearch( %$param );
    die "error!" if $res->is_error;

    my $list = $res->root->Area->Region;
    foreach my $reg ( @$list ) {
        print $reg->cd, "\t# ",  $reg->name, "\n";
        foreach my $pref ( @{ $reg->Prefecture } ) {
            print $pref->cd, "\t  * ",  $pref->name, "\n";
            foreach my $large ( @{ $pref->LargeArea } ) {
                print $large->cd, "\t    + ",  $large->name, "\n";
                foreach my $small ( @{ $large->SmallArea } ) {
                    print $small->cd, "\t      - ",  $small->name, "\n";
                }
            }
        }
    }

    my $root = $res->root;

=head1 DESCRIPTION

The request to this API requires one or some of query parameters below:

    my $param = {
        reg         =>  '10'
        pref        =>  '130000'
        l_area      =>  '136200'
    };

The response from this API is tree structured and provides methods below:

    $root->APIVersion
    $root->Area
    $root->Area->Region
    $root->Area->Region->[0]->cd
    $root->Area->Region->[0]->name
    $root->Area->Region->[0]->Prefecture
    $root->Area->Region->[0]->Prefecture->[0]->cd
    $root->Area->Region->[0]->Prefecture->[0]->name
    $root->Area->Region->[0]->Prefecture->[0]->LargeArea
    $root->Area->Region->[0]->Prefecture->[0]->LargeArea->[0]->cd
    $root->Area->Region->[0]->Prefecture->[0]->LargeArea->[0]->name
    $root->Area->Region->[0]->Prefecture->[0]->LargeArea->[0]->SmallArea
    $root->Area->Region->[0]->Prefecture->[0]->LargeArea->[0]->SmallArea->[0]->cd
    $root->Area->Region->[0]->Prefecture->[0]->LargeArea->[0]->SmallArea->[0]->name

And paging methods are provided, see L<WebService::Recruit::Jalan/PAGING>.
This module is based on L<XML::OverHTTP>.

=head1 SEE ALSO

L<WebService::Recruit::Jalan>

=head1 AUTHOR

Yusuke Kawasaki L<http://www.kawa.net/>

This module is unofficial and released by the authour in person.

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2007 Yusuke Kawasaki. All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
1;
