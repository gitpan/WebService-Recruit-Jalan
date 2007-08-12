package WebService::Recruit::Jalan::HotelSearchLite;
use strict;
use vars qw( $VERSION );
use base qw( WebService::Recruit::Jalan::API );
$VERSION = '0.07';

sub url { 'http://jws.jalan.net/APILite/HotelSearch/V1/'; }
sub force_array { [qw( Hotel AccessInformation )]; }
sub elem_class { 'WebService::Recruit::Jalan::HotelSearchLite::Element'; }
sub query_class { 'WebService::Recruit::Jalan::HotelSearchLite::Query'; }

package WebService::Recruit::Jalan::HotelSearchLite::Query;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw(
    key pref l_area s_area h_id h_type o_pool parking pub_bath onsen
    prv_bath v_bath sauna jacz mssg r_ski r_brd pet esthe p_pong limo
    late_out pict_size order start count
));

package WebService::Recruit::Jalan::HotelSearchLite::Element;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( Results ));

package WebService::Recruit::Jalan::HotelSearchLite::Element::Results;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw(
    NumberOfResults DisplayPerPage DisplayFrom APIVersion Hotel
));

package WebService::Recruit::Jalan::HotelSearchLite::Element::Hotel;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw(
    HotelID HotelName PostCode HotelAddress Area HotelType
    HotelDetailURL HotelCatchCopy HotelCaption PictureURL
    PictureCaption AccessInformation CheckInTime CheckOutTime
    X Y LastUpdate
));

package WebService::Recruit::Jalan::HotelSearchLite::Element::Area;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( Region Prefecture LargeArea SmallArea ));

package WebService::Recruit::Jalan::HotelSearchLite::Element::AccessInformation;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( name _text ));

package WebService::Recruit::Jalan::HotelSearchLite::Element::LastUpdate;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( day month year ));

=head1 NAME

WebService::Recruit::Jalan::HotelSearchLite - Jalan Web Service "HotelSearchLite" API

=head1 SYNOPSIS

    use WebService::Recruit::Jalan;

    my $jalan = WebService::Recruit::Jalan->new();
    $jalan->key( 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' );

    my $param = {
        s_area  =>  '162612',
        h_type  =>  '1',
    };
    my $res = $jalan->HotelSearchLite( %$param );
    die "error!" if $res->is_error;

    my $list = $res->root->Hotel;
    foreach my $hotel ( @$list ) {
        print "HotelID: ",   $hotel->HotelID, "\n";
        print "HotelName: ", $hotel->HotelName, "\n";
    }

    my $root = $res->root;

=head1 DESCRIPTION

The request to this API requires one or some of query parameters below:

    my $param = {
        pref        =>  '130000',
        l_area      =>  '136200',
        s_area      =>  '136202',
        h_id        =>  '324994',
        h_type      =>  '0',
        o_pool      =>  '0',
        parking     =>  '0',
        pub_bath    =>  '0',
        onsen       =>  '0',
        prv_bath    =>  '0',
        v_bath      =>  '0',
        sauna       =>  '0',
        jacz        =>  '0',
        mssg        =>  '0',
        r_ski       =>  '0',
        r_brd       =>  '0',
        pet         =>  '0',
        esthe       =>  '0',
        p_pong      =>  '0',
        limo        =>  '0',
        late_out    =>  '0',
        pict_size   =>  '3',        # pictM
        order       =>  '0',
        start       =>  '1',
        count       =>  '10',
    };

The response from this API is tree structured and provides methods below:

    $root->NumberOfResults
    $root->DisplayPerPage
    $root->DisplayFrom
    $root->APIVersion
    $root->Hotel
    $root->Hotel->[0]->HotelID
    $root->Hotel->[0]->HotelName
    $root->Hotel->[0]->PostCode
    $root->Hotel->[0]->HotelAddress
    $root->Hotel->[0]->Area
    $root->Hotel->[0]->Area->Region
    $root->Hotel->[0]->Area->Prefecture
    $root->Hotel->[0]->Area->LargeArea
    $root->Hotel->[0]->Area->SmallArea
    $root->Hotel->[0]->HotelType
    $root->Hotel->[0]->HotelDetailURL
    $root->Hotel->[0]->HotelCatchCopy
    $root->Hotel->[0]->HotelCaption
    $root->Hotel->[0]->PictureURL
    $root->Hotel->[0]->PictureCaption
    $root->Hotel->[0]->AccessInformation
    $root->Hotel->[0]->AccessInformation->[0]->name
    $root->Hotel->[0]->CheckInTime
    $root->Hotel->[0]->CheckOutTime
    $root->Hotel->[0]->X
    $root->Hotel->[0]->Y
    $root->Hotel->[0]->LastUpdate
    $root->Hotel->[0]->LastUpdate->day
    $root->Hotel->[0]->LastUpdate->month
    $root->Hotel->[0]->LastUpdate->year

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
