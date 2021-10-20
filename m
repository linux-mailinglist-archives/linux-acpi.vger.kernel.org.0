Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452E3434B28
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Oct 2021 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhJTMcx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Oct 2021 08:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJTMcx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Oct 2021 08:32:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F4366135E;
        Wed, 20 Oct 2021 12:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634733039;
        bh=JT2SkvtAggztd5vBpXOy3KiUBY0PoFlXIX09DB3XnHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnIUPEIq+hvzCl00QYwDpobI4iFUDxYE/SkDXuEed4ZxhuhfToaA8W8535LPjTRTY
         4W7zXSOZRKO7ExURf/LBK31wWDQOsDIIQammx1x/wgABht7VUahDLfta3lxOXRPzZR
         2RhU5xPdjYWSra4E0GiEO92nr76GHsp78fNqFyAGz247M8mPITA+6u64wn/7aG7r7r
         2/8HgafaK3ZzaWpVOzC/jmrVZEUpe0rpCJw6Yje7Kx8V9HLKY97UnB744PlD+7nxCY
         SDk9MZX+hq5fxOapESfk4jEQ2tqLQP+6g7o+e3EXjov0ma1NF3sgnHaNCIquEdkL3G
         lz+XCHRQJROww==
Date:   Wed, 20 Oct 2021 13:30:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Len Brown <lenb@kernel.org>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] sound: cs35l41: Allow HDA systems to use
 CS35l41 ASoC driver
Message-ID: <YXAL7Gc/wGR0Ce3g@sirena.org.uk>
References: <20211020085944.17577-1-tanureal@opensource.cirrus.com>
 <20211020085944.17577-2-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="105KrfQZCqU/K4pU"
Content-Disposition: inline
In-Reply-To: <20211020085944.17577-2-tanureal@opensource.cirrus.com>
X-Cookie: I program, therefore I am.
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--105KrfQZCqU/K4pU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 20, 2021 at 09:59:42AM +0100, Lucas Tanure wrote:

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.

> Re-use ASoC driver for supporting for Legion 7 16ACHg6
> laptop.
> HDA machine driver will find the registered dais for the
> Amp and use snd_soc_dai_ops to configure it.

It will find the registered DAIs in what way exactly?

This patch is doing a whole bunch of stuff which isn't described at all
in the changelog which makes it very hard to review, I can't tell what
it's supposed to do.

--105KrfQZCqU/K4pU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFwC+sACgkQJNaLcl1U
h9BpGgf8C7Znyvqsj/ydwkf+M2pPLh07ukHK6c4VRUmxiuxT4/WUeecjcnTvo4El
J+dqhOnejW1i0PiJ8C/j2sz9Z/W0+asGY4+UcGy9VWUMQ0mUNt46UbEJPYR573ae
1WJVSy3Gzrx0FC/U/kRFlFplxPnq1VHITlm2oviYhrlqsvHP+9Xd+lBNmZB4H4Bx
JeEc7rfpHd7uiftVfhrVVNtgKjb+kvPiB4f1NTnwr4ZkDsF9ydULy5Ytq5qvEx7Q
AQ7MgwVpvdj14Jbmg1Abz4SNNVwwte9M9nc99X+aajfW9Shg77XxjUb90qoTb3iZ
nOkeqR9aXbE2RBNQZW3HIDaPLkwkEg==
=WUeG
-----END PGP SIGNATURE-----

--105KrfQZCqU/K4pU--
