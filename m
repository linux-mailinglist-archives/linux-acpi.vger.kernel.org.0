Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F11342FC4F
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Oct 2021 21:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbhJOTm1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Oct 2021 15:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242770AbhJOTm0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Oct 2021 15:42:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BD1160FE3;
        Fri, 15 Oct 2021 19:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634326819;
        bh=u+xhoM6RAhD0LTnjN3s9BCRtDR1IuGlTYumrXO1nwdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8C5JVBxLIMWE/EhEVZk9v/EkUi+zzZ30FXPqejrf7kDbbOsjf3sP5YJm10tNocV0
         6TCxOlQUndoNvblA6cVrOti8s6FkFy1A+J3uCiPQtHyzR+UrM1g3irrc9F03bHvBYm
         zQb6C3ffevL+JUgFpg3Da+Bp+hOcXwVQF20Zcsfe1A4XsNEE3BqTjfmCCVISlTYdeM
         j6zRim/CGMiYwWLNU1iB8/T2JDF/xT42evj0kbvuNq8i5b970hexYhtk0UB7QPT+Pi
         xfWINqdJ8pIcI/Pnd43+KS+dOnsFSDm49WxbHdoMZwu4nZ3VmW9ZlUTf2+f1d9wKIW
         5Qi1gaPy+BgJg==
Date:   Fri, 15 Oct 2021 20:40:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 05/12] regulator: Introduce tps68470-regulator driver
Message-ID: <YWnZIZTPiuAIazV+@sirena.org.uk>
References: <20211008162121.6628-1-hdegoede@redhat.com>
 <20211008162121.6628-6-hdegoede@redhat.com>
 <YWQU/SYTT5Vk24XH@sirena.org.uk>
 <f6f2d7e8-fdb8-ed64-0cdd-65aded9fc42c@redhat.com>
 <YWmwZJvDYjPWJdb4@sirena.org.uk>
 <d0d1dc05-4cc6-2f47-88a9-700cfc356d86@redhat.com>
 <YWnPaI/ZECdfYre9@sirena.org.uk>
 <843f939a-7e43-bc12-e9fc-582e01129b63@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iEkpgJpTB1rraeDg"
Content-Disposition: inline
In-Reply-To: <843f939a-7e43-bc12-e9fc-582e01129b63@redhat.com>
X-Cookie: 1: No code table for op: ++post
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--iEkpgJpTB1rraeDg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 15, 2021 at 09:27:50PM +0200, Hans de Goede wrote:
> On 10/15/21 8:58 PM, Mark Brown wrote:

> > I am very confused about why it's in the driver without a DMI quirk
> > and/or clear comments about why and saying that this is a terrible
> > example to copy.

> The DMI quirks live in the ACPI glue code under drivers/platform/x86,
> that code instantiates the MFD cell and sets the platform-data
> as part of the cell.

I can't see how the quirking gets propagated through into the driver and
I'd really expect that in a situation like this the platform data would
be passed through as platform data from the code doing the quirks, this
just looks wrong and it'll go badly wrong if the same part shows up in
some other machine.

--iEkpgJpTB1rraeDg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFp2SAACgkQJNaLcl1U
h9DTqgf+KzNxQBiWaX5ojnno2zQWW7oj8jHN3NWBzoRbDvnnmyqP/mpEJ7Khi8Us
ItLg59Zad1q6cvfk6l25iT0X0oijvE2ZYw1hLXxaDBOOXbZFEy38yWqvX89CD9j7
FAQhg8v5WVQSSY/9VIKGDqb0CTuMD10+AKOxNtLOfTRXTDd45Ga8cOiM/fC5w1NE
KGMPQmeydx6RMngYcsKVCKaHar5RnZ5puV1EH9zOkjSHJEc0Wu5meL8GJOtNtg5O
0r5gUBw7/j0fen+idSwK0vqpcylhlmIYCJkCFKmnWv5FXb5mHambOwcKLB3c0IAN
tyvRObzbCqrfat273nGOReKKq7iIYA==
=DILg
-----END PGP SIGNATURE-----

--iEkpgJpTB1rraeDg--
