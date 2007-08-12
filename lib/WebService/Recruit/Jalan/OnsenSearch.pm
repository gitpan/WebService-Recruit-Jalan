package WebService::Recruit::Jalan::OnsenSearch;
use strict;
use vars qw( $VERSION );
use base qw( WebService::Recruit::Jalan::API );
$VERSION = '0.07';

sub url { 'http://jws.jalan.net/APICommon/OnsenSearch/V1/'; }
sub force_array { [qw( Onsen )]; }
sub elem_class { 'WebService::Recruit::Jalan::OnsenSearch::Element'; }
sub query_class { 'WebService::Recruit::Jalan::OnsenSearch::Query'; }

package WebService::Recruit::Jalan::OnsenSearch::Query;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw(
    key reg pref l_area s_area onsen_q start count xml_ptn
));

package WebService::Recruit::Jalan::OnsenSearch::Element;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( Results ));

package WebService::Recruit::Jalan::OnsenSearch::Element::Results;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw(
    NumberOfResults DisplayPerPage DisplayFrom APIVersion Onsen
));

package WebService::Recruit::Jalan::OnsenSearch::Element::Onsen;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw(
    OnsenName OnsenNameKana OnsenID OnsenAddress Area NatureOfOnsen
    OnsenAreaName OnsenAreaNameKana OnsenAreaID OnsenAreaURL
    OnsenAreaCaption
));

package WebService::Recruit::Jalan::OnsenSearch::Element::Area;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( Region Prefecture LargeArea SmallArea ));

=head1 NAME

WebService::Recruit::Jalan::OnsenSearch - Jalan Web Service "OnsenSearch" API

=head1 SYNOPSIS

    use WebService::Recruit::Jalan;

    my $jalan = WebService::Recruit::Jalan->new();
    $jalan->key( 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' );

    my $param = {
        s_area      =>  '141602',
    };
    my $res = $jalan->OnsenSearch( %$param );
    die "error!" if $res->is_error;

    my $list = $res->root->Onsen;
    foreach my $onsen ( @$list ) {
        print "OnsenID: ",   $onsen->OnsenID, "\n";
        print "OnsenName: ", $onsen->OnsenName, "\n";
    }

    my $root = $res->root;

=head1 DESCRIPTION

The request to this API requires one or some of query parameters below:

    my $param = {
        reg         =>  '10',
        pref        =>  '130000',
        l_area      =>  '136200',
        s_area      =>  '136202',
        onsen_q     =>  '0',
        start       =>  '1',
        count       =>  '10',
        xml_ptn     =>  '0',
    };

The response from this API is tree structured and provides methods below:

    $root->NumberOfResults
    $root->DisplayPerPage
    $root->DisplayFrom
    $root->APIVersion
    $root->Onsen
    $root->Onsen->[0]->OnsenName
    $root->Onsen->[0]->OnsenNameKana
    $root->Onsen->[0]->OnsenID
    $root->Onsen->[0]->OnsenAddress
    $root->Onsen->[0]->Area
    $root->Onsen->[0]->Area->Region
    $root->Onsen->[0]->Area->Prefecture
    $root->Onsen->[0]->Area->LargeArea
    $root->Onsen->[0]->Area->SmallArea
    $root->Onsen->[0]->NatureOfOnsen
    $root->Onsen->[0]->OnsenAreaName
    $root->Onsen->[0]->OnsenAreaNameKana
    $root->Onsen->[0]->OnsenAreaID
    $root->Onsen->[0]->OnsenAreaURL
    $root->Onsen->[0]->OnsenAreaCaption

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
