package WebService::Recruit::Jalan::HotelSearchAdvance;
use strict;
use vars qw( $VERSION );
use base qw( WebService::Recruit::Jalan::API );
$VERSION = '0.07';

sub url { 'http://jws.jalan.net/APIAdvance/HotelSearch/V1/'; }
sub force_array { [qw(
    Hotel PictureURL PictureCaption AccessInformation
    Plan RoomType PlanPictureURL PlanPictureCaption
)]; }
sub elem_class { 'WebService::Recruit::Jalan::HotelSearchAdvance::Element'; }
sub query_class { 'WebService::Recruit::Jalan::HotelSearchAdvance::Query'; }

package WebService::Recruit::Jalan::HotelSearchAdvance::Query;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw(
    key reg pref l_area s_area h_id o_area_id o_id x y range h_name
    h_type o_pool parking pub_bath onsen prv_bath v_bath sauna jacz
    mssg r_ski r_brd pet esthe p_pong limo room_b room_d prv_b prv_d
    early_in late_out no_smk net r_room high p_ok sp_room bath_to
    o_bath pour cloudy i_pool fitness gym p_field bbq hall 5_station
    5_beach 5_slope c_card c_jcb c_visa c_master c_amex c_uc c_dc
    c_nicos c_diners c_saison c_ufj cvs no_meal b_only d_only 2_meals
    sng_room twn_room dbl_room tri_room 4bed_room jpn_room j_w_room
    child_price c_bed_meal c_no_bed_meal c_meal_only c_bed_only
    pict_size picts order start count xml_ptn
));

package WebService::Recruit::Jalan::HotelSearchAdvance::Element;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( Results ));

package WebService::Recruit::Jalan::HotelSearchAdvance::Element::Results;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw(
    NumberOfResults DisplayPerPage DisplayFrom APIVersion Hotel
));

package WebService::Recruit::Jalan::HotelSearchAdvance::Element::Hotel;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw(
    HotelID HotelName PostCode HotelAddress Area HotelType
    HotelDetailURL HotelCatchCopy HotelCaption PictureURL
    PictureCaption AccessInformation CheckInTime CheckOutTime
    X Y SampleRateFrom LastUpdate OnsenName HotelNameKana
    CreditCard NumberOfRatings Rating Plan
));

package WebService::Recruit::Jalan::HotelSearchAdvance::Element::Area;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( Region Prefecture LargeArea SmallArea ));

package WebService::Recruit::Jalan::HotelSearchAdvance::Element::AccessInformation;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( name _text ));

package WebService::Recruit::Jalan::HotelSearchAdvance::Element::LastUpdate;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( day month year ));

package WebService::Recruit::Jalan::HotelSearchAdvance::Element::CreditCard;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw(
    AMEX DC DINNERS ETC JCB MASTER MILLION  NICOS SAISON UC UFJ VISA _text
));

package WebService::Recruit::Jalan::HotelSearchAdvance::Element::Plan;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw(
    PlanName RoomType RoomName PlanCheckIn PlanCheckOut PlanPictureURL
    PlanPictureCaption Meal PlanSampleRateFrom
));

=head1 NAME

WebService::Recruit::Jalan::HotelSearchAdvance - Jalan Web Service "HotelSearchAdvance" API

=head1 SYNOPSIS

    use WebService::Recruit::Jalan;

    my $jalan = WebService::Recruit::Jalan->new();
    $jalan->key( 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' );

    my $param = {
        s_area      =>  '162612',
        xml_ptn     =>  '2',
    };
    my $res = $jalan->HotelSearchAdvance( %$param );
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
        reg         =>  '10',
        pref        =>  '130000',
        l_area      =>  '136200',
        s_area      =>  '136202',
        h_id        =>  '324994',
        o_area_id   =>  '50024',
        o_id        =>  '0042',
        x           =>  '503037529',
        y           =>  '128366212',
        range       =>  '10',
        h_name      =>  'Hotel Name',
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
        room_b      =>  '0',
        room_d      =>  '0',
        prv_b       =>  '0',
        prv_d       =>  '0',
        early_in    =>  '0',
        late_out    =>  '0',
        no_smk      =>  '0',
        net         =>  '0',
        r_room      =>  '0',
        high        =>  '0',
        p_ok        =>  '0',
        sp_room     =>  '0',
        bath_to     =>  '0',
        o_bath      =>  '0',
        pour        =>  '0',
        cloudy      =>  '0',
        i_pool      =>  '0',
        fitness     =>  '0',
        gym         =>  '0',
        p_field     =>  '0',
        bbq         =>  '0',
        hall        =>  '0',
        5_station   =>  '0',
        5_beach     =>  '0',
        5_slope     =>  '0',
        c_card      =>  '0',
        c_jcb       =>  '0',
        c_visa      =>  '0',
        c_master    =>  '0',
        c_amex      =>  '0',
        c_uc        =>  '0',
        c_dc        =>  '0',
        c_nicos     =>  '0',
        c_diners    =>  '0',
        c_saison    =>  '0',
        c_ufj       =>  '0',
        cvs         =>  '0',
        no_meal     =>  '0',
        b_only      =>  '0',
        d_only      =>  '0',
        2_meals     =>  '0',
        sng_room    =>  '0',
        twn_room    =>  '0',
        dbl_room    =>  '0',
        tri_room    =>  '0',
        4bed_room   =>  '0',
        jpn_room    =>  '0',
        j_w_room    =>  '0',
        child_price =>  '0',
        c_bed_meal  =>  '0',
        c_no_bed_meal => '0',
        c_meal_only =>  '0',
        c_bed_only  =>  '0',
        pict_size   =>  '3',    # pictM
        picts       =>  '5',
        order       =>  '0',
        start       =>  '1',
        count       =>  '10',
        xml_ptn     =>  '2',
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
    $root->Hotel->[0]->PictureURL->[0]
    $root->Hotel->[0]->PictureCaption->[0]
    $root->Hotel->[0]->AccessInformation
    $root->Hotel->[0]->AccessInformation->[0]->name
    $root->Hotel->[0]->CheckInTime
    $root->Hotel->[0]->CheckOutTime
    $root->Hotel->[0]->X
    $root->Hotel->[0]->Y
    $root->Hotel->[0]->SampleRateFrom
    $root->Hotel->[0]->LastUpdate
    $root->Hotel->[0]->LastUpdate->day
    $root->Hotel->[0]->LastUpdate->month
    $root->Hotel->[0]->LastUpdate->year
    $root->Hotel->[0]->OnsenName
    $root->Hotel->[0]->HotelNameKana
    $root->Hotel->[0]->CreditCard
    $root->Hotel->[0]->CreditCard->AMEX
    $root->Hotel->[0]->CreditCard->DC
    $root->Hotel->[0]->CreditCard->DINNERS
    $root->Hotel->[0]->CreditCard->ETC
    $root->Hotel->[0]->CreditCard->JCB
    $root->Hotel->[0]->CreditCard->MASTER
    $root->Hotel->[0]->CreditCard->MILLION
    $root->Hotel->[0]->CreditCard->NICOS
    $root->Hotel->[0]->CreditCard->SAISON
    $root->Hotel->[0]->CreditCard->UC
    $root->Hotel->[0]->CreditCard->UFJ
    $root->Hotel->[0]->CreditCard->VISA
    $root->Hotel->[0]->NumberOfRatings
    $root->Hotel->[0]->Rating
    $root->Hotel->[0]->Plan
    $root->Hotel->[0]->Plan->[0]->PlanName
    $root->Hotel->[0]->Plan->[0]->RoomType->[0]
    $root->Hotel->[0]->Plan->[0]->RoomName
    $root->Hotel->[0]->Plan->[0]->PlanCheckIn
    $root->Hotel->[0]->Plan->[0]->PlanCheckOut
    $root->Hotel->[0]->Plan->[0]->PlanPictureURL
    $root->Hotel->[0]->Plan->[0]->PlanPictureCaption
    $root->Hotel->[0]->Plan->[0]->Meal
    $root->Hotel->[0]->Plan->[0]->PlanSampleRateFrom

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
