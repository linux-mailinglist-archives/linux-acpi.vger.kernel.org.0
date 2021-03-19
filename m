Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BCC34253B
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 19:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCSSsm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 14:48:42 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55300 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhCSSsc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2021 14:48:32 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B77EA1C0B7C; Fri, 19 Mar 2021 19:48:29 +0100 (CET)
Date:   Fri, 19 Mar 2021 19:48:29 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     chris.chiu@canonical.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: video: Add missing callback back for Sony VPCEH3U1E
Message-ID: <20210319184828.GA5022@amd>
References: <20210312032430.13664-1-chris.chiu@canonical.com>
 <20210313102545.GB11435@duo.ucw.cz>
 <CAJZ5v0g7pEMA-QTonuVgMVmFCcHwnTtYYCaw7mVertPfhHNt8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g7pEMA-QTonuVgMVmFCcHwnTtYYCaw7mVertPfhHNt8w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2021-03-19 17:44:32, Rafael J. Wysocki wrote:
> On Sat, Mar 13, 2021 at 11:27 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > On Fri 2021-03-12 11:24:30, chris.chiu@canonical.com wrote:
> > > From: Chris Chiu <chris.chiu@canonical.com>
> > >
> > > The .callback of the quirk for Sony VPCEH3U1E was unintetionally
> > > removed by the commit 25417185e9b5 ("ACPI: video: Add DMI quirk
> > > for GIGABYTE GB-BXBT-2807"). Add it back to make sure the quirk
> > > for Sony VPCEH3U1E works as expected.
> > >
> > > Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> > > Reported-by: Pavel Machek <pavel@ucw.cz>
> >
> > Thanks for doing this.
> >
> > Reviewed-by: Pavel Machek (CIP) <pavel@denx.de>
>=20
> Applied as 5.12-rc5 material, thanks!

Commit 25417185e9b5 made it into stable, so this one should be Cc:
stable as well. Sorry for noticing that late.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBU8fwACgkQMOfwapXb+vINqwCgn1dZOO9AzYg5rMwA3BaT+1mg
nCoAoJvvj6XYmtOZ6lg8zoLZq74Z3+ig
=NQVr
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
