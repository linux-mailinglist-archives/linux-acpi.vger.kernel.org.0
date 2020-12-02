Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2E22CBD03
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 13:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgLBM3h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 07:29:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbgLBM3h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Dec 2020 07:29:37 -0500
Date:   Wed, 2 Dec 2020 12:28:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606912136;
        bh=I3OHg8mnnc5iQCobQvP21M7Ashds3CHUIF1IGGWiIuQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=xrDmkokzjmeFguNyxFErMeCaESOXcOF8MCiNvH0TlGkMWzxT10moxLOWbWZPqa3RF
         i20cZ7fDK+vMT5KMYtN3SWguV+oUm3sPOJr2J4R3EZzMTm2AkJnkGeRmNRTRoW3AG8
         kKVOwv7KO2ewv7PX5hm7QqK9PD/Wr1GmXU1Rq1+g=
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jie Yang <yang.jie@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1] ASoC: Intel: catpt: Replace open coded variant of
 resource_intersection()
Message-ID: <20201202122826.GB5560@sirena.org.uk>
References: <20201124095628.54373-1-andriy.shevchenko@linux.intel.com>
 <160683107676.35139.9521964646147921378.b4-ty@kernel.org>
 <20201201183329.GI4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <20201201183329.GI4077@smile.fi.intel.com>
X-Cookie: Sauron is alive in Argentina!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2020 at 08:33:29PM +0200, Andy Shevchenko wrote:

> As I mentioned in the comment (after --- line) the patch relies on the stuff in
> linux-pm tree. Do you have any immutable branch pulled? Otherwise Rafael
> already took it where it won't break compilation.

b4 had a bug which caused it to send thanks for every patch I'd ever
downloaded but not applied, the "no commit info" means there wasn't an
actual matching commit.  I'd been going to review it but then it got
applied anyway.

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/HiGkACgkQJNaLcl1U
h9A0Lgf/RtfnAWSqpPMQ8VebIf7JcBYx+dO+jtAR7nuQOCBgNRrimSJoRjeqPnT1
v7hruI6gaNlj3EdJJl/zxWcr6Y9Ummxr1IXo9XWGKHYT9T6jGEiZQxWI5/iJa9J6
sCK355KibYX1+ZPGdIl3svUfRQdTPO2ayo3ySSuw+O3fvWwq1F+ZZ4kKNjLKsi45
dealsPDDXvcOcn1Egtx4I++LOz+R57bgRoHDJJaXB/Ww9m/2ZRqXvLlxC9LUCPu0
tM1+dEZl3lWEGKhp61BJH1p3l3kdtxE5b3ha7HBrKHkZWcwkO6VhNUG5riphTDvF
TiL7/9LFFJA/SBH9KgS7lQKkTjvcjw==
=ywMl
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
