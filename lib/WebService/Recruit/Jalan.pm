package WebService::Recruit::Jalan;
use strict;
use Class::Accessor::Fast;
use XML::OverHTTP;
use base qw( Class::Accessor::Fast );
use vars qw( $VERSION );
$VERSION = '0.07';

my $PARAMS = [qw( key )];
my $TPPCFG = [qw( user_agent lwp_useragent http_lite utf8_flag )];
__PACKAGE__->mk_accessors( @$PARAMS, @$TPPCFG );

sub new {
    my $package = shift;
    my $self    = {@_};
    $self->{user_agent} ||= __PACKAGE__."/$VERSION ";
    bless $self, $package;
    $self;
}

sub init_treepp_config {
    my $self = shift;
    my $api  = shift;
    my $treepp = $api->treepp();
    foreach my $key ( @$TPPCFG ) {
        $treepp->set( $key => $self->{$key} ) if exists $self->{$key};
    }
}

sub init_query_param {
    my $self = shift;
    my $api  = shift;
    foreach my $key ( @$PARAMS ) {
        $api->add_param( $key => $self->{$key} ) if exists $self->{$key};
    }
}

package WebService::Recruit::Jalan::API;
use strict;
use base qw( XML::OverHTTP );
use vars qw( $VERSION );
$VERSION = $WebService::Recruit::Jalan::VERSION;

sub notnull_param { [qw( key )]; }
sub attr_prefix { ''; }
sub text_node_key { '_text'; }
sub root_elem { 'Results'; }

sub is_error {
    my $self  = shift;
    my $tree  = $self->tree();
    my $mess;
    if ( ref $tree ) {
        my $error = $tree->{Error} or return;
        $mess = $error->{Message} or return;
    }
    else {
        my $xml = $self->xml() or return;
        return unless ( $xml =~ m{</Error>\s*$} );
        $mess = ( $xml =~ m{([^<>]*?)</Message>}s )[0];
    }
    $mess;
}
sub total_entries {
    my $self = shift;
    my $root = $self->root() or return;
    $root->{NumberOfResults} || 0;
}
sub entries_per_page {
    my $self = shift;
    my $root = $self->root() or return;
    $root->{DisplayPerPage} || 0;
}
sub current_page {
    my $self = shift;
    my $root = $self->root() or return;
    my $epp  = $self->entries_per_page() or return;
    int(($root->{DisplayFrom}-1) / $epp)+1 || 1;
}
sub page_param {
    my $self = shift;
    my $page = shift || $self->current_page();
    my $size = shift || $self->entries_per_page();
    my $hash = shift || {};
    $hash->{start} = ($page-1) * $size + 1;
    $hash->{count} = $size;
    $hash;
}

package WebService::Recruit::Jalan;                 # again
use strict;

use WebService::Recruit::Jalan::HotelSearchLite;
use WebService::Recruit::Jalan::HotelSearchAdvance;
use WebService::Recruit::Jalan::AreaSearch;
use WebService::Recruit::Jalan::OnsenSearch;
use WebService::Recruit::Jalan::StockSearch;

sub HotelSearchLite {
    my $self = shift or return;
    $self = $self->new() unless ref $self;
    my $api = WebService::Recruit::Jalan::HotelSearchLite->new();
    $self->init_treepp_config( $api );
    $self->init_query_param( $api );
    $api->add_param( @_ );
    $api->request();
    $api;
}

sub HotelSearchAdvance {
    my $self = shift or return;
    $self = $self->new() unless ref $self;
    my $api = WebService::Recruit::Jalan::HotelSearchAdvance->new();
    $self->init_treepp_config( $api );
    $self->init_query_param( $api );
    $api->add_param( @_ );
    $api->request();
    $api;
}

sub AreaSearch {
    my $self = shift or return;
    $self = $self->new() unless ref $self;
    my $api = WebService::Recruit::Jalan::AreaSearch->new();
    $self->init_treepp_config( $api );
    $self->init_query_param( $api );
    $api->add_param( @_ );
    $api->request();
    $api;
}

sub OnsenSearch {
    my $self = shift or return;
    $self = $self->new() unless ref $self;
    my $api = WebService::Recruit::Jalan::OnsenSearch->new();
    $self->init_treepp_config( $api );
    $self->init_query_param( $api );
    $api->add_param( @_ );
    $api->request();
    $api;
}

sub StockSearch {
    my $self = shift or return;
    $self = $self->new() unless ref $self;
    my $api = WebService::Recruit::Jalan::StockSearch->new();
    $self->init_treepp_config( $api );
    $self->init_query_param( $api );
    $api->add_param( @_ );
    $api->request();
    $api;
}

=head1 NAME

WebService::Recruit::Jalan - A Interface for Jalan Web Service

=head1 SYNOPSIS

    use WebService::Recruit::Jalan;

    my $jalan = WebService::Recruit::Jalan->new();
    $jalan->key( 'xxxxxxxxxxxxxx' );

    my $res = $jalan->HotelSearchAdvance( s_area => '260502' );
    my $list = $res->root->Hotel;
    foreach my $hotel ( @$list ) {
        print "HotelID: ",   $hotel->HotelID, "\n";
        print "HotelName: ", $hotel->HotelName, "\n";
    }

=head1 DESCRIPTION

This module is a interface for the Jalan Web Service,
provided by Recruit Co., Ltd., Japan.
It provides five API methods: L</HotelSearchLite>, L</HotelSearchAdvance>,
L</AreaSearch>, L</OnsenSearch> and L</StockSearch>.

=head3 HotelSearchLite

See L<WebService::Recruit::Jalan::SearchPOI> for details.

    my $res = $doko->HotelSearchLite( s_area => '162612' );

=head3 HotelSearchAdvance

See L<WebService::Recruit::Jalan::GetLandmark> for details.

    my $res = $doko->HotelSearchAdvance( s_area => '260502' );

=head3 AreaSearch

See L<WebService::Recruit::Jalan::AreaSearch> for details.

    my $res = $doko->AreaSearch( reg => 15 );

=head3 OnsenSearch

See L<WebService::Recruit::Jalan::OnsenSearch> for details.

    my $res = $doko->OnsenSearch( s_area => '141602' );

=head3 StockSearch

See L<WebService::Recruit::Jalan::StockSearch> for details.

    my $res = $doko->StockSearch( lon_jgd => 139.758, lat_jgd => 35.666 );

=head2 PAGING

Each API response also provides paging methods following:

=head3 page

C<page> method returns a L<Data::Page> instance.

    my $page = $res->page();
    print "Total: ", $page->total_entries, "\n";
    print "Page: ", $page->current_page, "\n";
    print "Last: ", $page->last_page, "\n";

=head3 pageset

C<pageset> method returns a L<Data::Pageset> instance

    my $pageset = $res->pageset( 'fixed' );
    $pageset->pages_per_set($pages_per_set);
    my $set = $pageset->pages_in_set();
    foreach my $num ( @$set ) {
        print "$num ";
    }

=head3 page_param

C<page_param> method returns a hash to specify the page for the next request.

    my %hash  = $res->page_param( $page->next_page );

=head3 page_query

C<page_query> method returns a query string to specify the page for the next request.

    my $query = $res->page_query( $page->prev_page );

=head2 TreePP CONFIG

This modules uses L<XML::TreePP> module internally.
Following methods are available to configure it.

    my $doko = WebService::Recruit::Jalan->new();
    $doko->utf8_flag( 1 );
    $doko->user_agent( 'Foo-Bar/1.0 ' );
    $doko->lwp_useragent( LWP::UserAgent->new() );
    $doko->http_lite( HTTP::Lite->new() );

=head1 SEE ALSO

http://jws.jalan.net/

=head1 AUTHOR

Yusuke Kawasaki L<http://www.kawa.net/>

This module is unofficial and released by the authour in person.

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2007 Yusuke Kawasaki. All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
1;
