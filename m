Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B61217482
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 18:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgGGQ4G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jul 2020 12:56:06 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:39990 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgGGQ4G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jul 2020 12:56:06 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6075C1C0C0A; Tue,  7 Jul 2020 18:56:03 +0200 (CEST)
Date:   Tue, 7 Jul 2020 18:56:02 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and
 callback for firmware activation
Message-ID: <20200707165602.GB1947@amd>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> @@ -234,6 +234,7 @@ static const char * const pm_tests[__TEST_AFTER_LAST]=
 =3D {
>  	[TEST_PLATFORM] =3D "platform",
>  	[TEST_DEVICES] =3D "devices",
>  	[TEST_FREEZER] =3D "freezer",
> +	[TEST_MEM_QUIET] =3D "mem-quiet",
>  };
>

This adds field to sysfs interface, right? I guess we need
documentation for that....

Best regards,
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8EqSIACgkQMOfwapXb+vLR9gCfa6KeYH8VY1zioulRsZBNW+Kg
s1wAnjRjjBnRWMzhG9K4RAp7LgAB86Hl
=mxU5
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
