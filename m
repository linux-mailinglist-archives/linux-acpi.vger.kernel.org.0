Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A555A0CE
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2019 18:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfF1Q2W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Jun 2019 12:28:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51132 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfF1Q2W (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Jun 2019 12:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m//Qtq9gFmgDDqUd5HowLAI6QPmKrAl77Pvv4hXKito=; b=dGiOgcrflH/7ZIczaUI3BQ8Dx
        Cda8tGAwAfQY+pc84UQXVHXj/ctb9eNinseqZZM9hXmF9PfSw1i3tY1pjSwbXhDc7LfyAivnic9sB
        08PtAWVoPGwVmSWTYqSdM0Y09ohQ5gVwKYxN2d6UWHcV2SUNtnve2UyMpVKjRqV3ZqpTA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hgtjO-00075I-PU; Fri, 28 Jun 2019 16:28:10 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 8503544004C; Fri, 28 Jun 2019 15:30:37 +0100 (BST)
Date:   Fri, 28 Jun 2019 15:30:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        "Andrew F. Davis" <afd@ti.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, nv@vosn.de
Subject: Re: [PATCH] sound/soc/codecs/tas5720.c: add ACPI support
Message-ID: <20190628143037.GH5379@sirena.org.uk>
References: <20190628123416.16298-1-nikolaus.voss@loewensteinmedical.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TBNym+cBXeFsS4Vs"
Content-Disposition: inline
In-Reply-To: <20190628123416.16298-1-nikolaus.voss@loewensteinmedical.de>
X-Cookie: You need not be present to win.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--TBNym+cBXeFsS4Vs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 28, 2019 at 02:34:16PM +0200, Nikolaus Voss wrote:
> Add support for ACPI enumeration for tas5720 and tas5722.
> Use device_match API to unify access to driver data for DT and ACPI.
> Aggregate variant stuff into its own struct and directly reference
> it in variant data for i2c/of/acpi_device_id.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

There's a huge amount of refactoring in here as well as the enumeration
changes, please split this up into a patch series as covered in
submitting-patches.rst for review.

--TBNym+cBXeFsS4Vs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0WJIwACgkQJNaLcl1U
h9Bvewf+JKdAlitakvrWEvLfVQ1ffjq8q2owD1IJsFcSFOLRl7mlZG1Hoq03PBBZ
lpYSKn/+9tbAlpNf6WYSCaNX9zvzGX0CJoHuOkVEap6zPFkWlYTqg8AlqEuFhM3c
di65cqFmifwWxkbRgHnl05I9cJXwCnm49Jkdd3dyNMpBhVtCVVk6W8NRt87/ODpR
b1iYRsLgSODnRju4Bs7H9NRmUhcNm8u0UFuV/WYfJLQB26Gsw9OrzBtvrjOssLOj
94HOzJlteXbHSpHKfL4SUliE7E3f+eRMjqTkxyswoJOUuwx/z9aKVlkDk2MiltRG
Uj9hG/2v/ooD/eenWJWkK082wI0FYg==
=LAqe
-----END PGP SIGNATURE-----

--TBNym+cBXeFsS4Vs--
