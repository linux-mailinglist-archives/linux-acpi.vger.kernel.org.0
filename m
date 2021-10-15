Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34C742FCAB
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Oct 2021 21:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbhJOUBm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Oct 2021 16:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233148AbhJOUBm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Oct 2021 16:01:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0238E61164;
        Fri, 15 Oct 2021 19:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634327975;
        bh=aDK8iZJAuvta5cySIJo1074ogrFA3hWL5lNWPdBB9go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dU7GudpA/i2qy5bF57zhQl06SCvKgJ1Lm5n0Vvilqexr6j2ZtfAMdyLb5Okwzi+wZ
         Zx/fIwh1OXjcJdneChwzzWfD5VUBiPoCPdwmNdpkTWALHCsttw69nntjHocgXDEYKZ
         Jty5atq741oSa+f0vdRCewqf9cDRPl1G3gIsQEVOQguKJIB7ql9J21hp0vcVhHm/40
         rfM7xF9SxWenUD/2VcTVvLEVivIjapf10wBsEu69eQpN/rP669lTi9LUsR2VnpOD9p
         wRrLDDQFTgwMow3rrmkLvQUFiBPwjqi4uTFpAfW+uNVFUv68bK753SYQDQ4CQmuOSn
         a2h0nDoC0/aTg==
Date:   Fri, 15 Oct 2021 20:59:32 +0100
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
Message-ID: <YWndpGgBtLEAEaNj@sirena.org.uk>
References: <20211008162121.6628-1-hdegoede@redhat.com>
 <20211008162121.6628-6-hdegoede@redhat.com>
 <YWQU/SYTT5Vk24XH@sirena.org.uk>
 <f6f2d7e8-fdb8-ed64-0cdd-65aded9fc42c@redhat.com>
 <YWmwZJvDYjPWJdb4@sirena.org.uk>
 <d0d1dc05-4cc6-2f47-88a9-700cfc356d86@redhat.com>
 <YWnPaI/ZECdfYre9@sirena.org.uk>
 <843f939a-7e43-bc12-e9fc-582e01129b63@redhat.com>
 <YWnZIZTPiuAIazV+@sirena.org.uk>
 <c595b143-d7ed-e76b-7734-e03d14e0f76e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hwxuglK+oW+JgNbU"
Content-Disposition: inline
In-Reply-To: <c595b143-d7ed-e76b-7734-e03d14e0f76e@redhat.com>
X-Cookie: 1: No code table for op: ++post
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--hwxuglK+oW+JgNbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 15, 2021 at 09:48:24PM +0200, Hans de Goede wrote:
> On 10/15/21 9:40 PM, Mark Brown wrote:

> > I can't see how the quirking gets propagated through into the driver and
> > I'd really expect that in a situation like this the platform data would
> > be passed through as platform data from the code doing the quirks,

> That is exactly what is happening here. The platform_data in this
> case is just an array of regulator_init_data pointers (one per
> regulator in the PMIC):

No, it's not.  What normally happens is that whatever registers the
device will when registering the device supply platform data that the
device later picks up from the struct device during probe.  What you're
saying is that the idea here is that driver unconditionally declares
platform data and then other code scribbles over that before the driver
instantiates.  This is cleaner in that it keeps the platform
configuration together and safer since the device can't exist before
it's configuration is provided.

> So we have the code doing the quirks determining the regulator_init_data
> and passing this through platform_data, which AFAICT is exactly what
> you want?

No.  There should be no sign of the platform data getting allocated or
initialised in the driver consuming the platform data.  It should purely
be reading the data it gets passed by the platform initialisation code.

Please make the use of platform data look like normal platform data use
rather than going and inventing some new scheme.

--hwxuglK+oW+JgNbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFp3aQACgkQJNaLcl1U
h9CMmQf9GXF+Ae5ZPsG+sX+gtPjIfCGeoaqaaFCL/JUl6WBgADy6d5JupE7xRn4k
WbUPvFobIVxVafRgCdM8pKY5W6I3BQN5LMy+8fQwsyDBgjd6Cvc/cZC5gxANQkKg
eEvLuXEOx8ZLSfEzIuqw1DZOX7Ka4jkH1KKJt6xbru7PCARlYIFDXbuSq0u86uXf
JEQs5gqrTPmf1Az0X+b/nBQteQNJ4hy0V38LWkwb2iY1VgVZeBhR+grulQXpr1Jk
lA1rTi//WYeohXMn7R4OjGK9JHruL8iiTCrsUw34XpVuin1Qlz47HMvtm/z3ZeXW
/bIdhKDbnuMeV6tIDt35Nl8dvF2+cQ==
=UmWu
-----END PGP SIGNATURE-----

--hwxuglK+oW+JgNbU--
