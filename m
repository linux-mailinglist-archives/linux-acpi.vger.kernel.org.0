Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78CB45AA90
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 18:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbhKWR4X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 12:56:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235026AbhKWR4X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 12:56:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A3AA60F42;
        Tue, 23 Nov 2021 17:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637689994;
        bh=yN5v/ksH+/i7Kc2NikgDUOw2ePKQ2SBTXHTlo8gWoxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nnw3WWluGs1MwQ8YensIJzFnsFs9naMNTTXEf73dRJHQ2dkyx80IURcsycHoUC1k4
         9qVkRQ7x/w+ng7cQ0/CZ7C1BWtICIkNEmQOOm8TMZiOgCuXJOpbKkGlP67NBBfIcZj
         I8gfkcdeejgAxnP2z0NCKgwmrolY1SfYEVWPRdHme50fAVSRukmheYWZi4B0U3OjwW
         52x5AtrcYwjmY1BUPuJNkU1ONLD+JpQERButoiXiBsiLNWFP9OfkNek16SurXnHUud
         V05BMiT8CUZRc2HUSADQZmjeWyKtKir1Kuw01FIa3ozECn349WDceKZV8CxeVlk4cL
         vHbT+Zcpard3w==
Date:   Tue, 23 Nov 2021 17:53:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Hui Wang <hui.wang@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Sami Loone <sami@loone.fi>, Elia Devito <eliadevito@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jack Yu <jack.yu@realtek.com>, Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org,
        patches@opensource.cirrus.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] ASoC: cs35l41: Convert tables to shared source code
Message-ID: <YZ0qgjJnoljpmc9s@sirena.org.uk>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
 <20211123163149.1530535-3-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kBarSnr2m61LE+g9"
Content-Disposition: inline
In-Reply-To: <20211123163149.1530535-3-tanureal@opensource.cirrus.com>
X-Cookie: A closed mouth gathers no foot.
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--kBarSnr2m61LE+g9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 23, 2021 at 04:31:40PM +0000, Lucas Tanure wrote:

> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -54,8 +54,8 @@ snd-soc-cs35l33-objs := cs35l33.o
>  snd-soc-cs35l34-objs := cs35l34.o
>  snd-soc-cs35l35-objs := cs35l35.o
>  snd-soc-cs35l36-objs := cs35l36.o
> -snd-soc-cs35l41-spi-objs := cs35l41-spi.o cs35l41.o cs35l41-tables.o
> -snd-soc-cs35l41-i2c-objs := cs35l41-i2c.o cs35l41.o cs35l41-tables.o
> +snd-soc-cs35l41-spi-objs := cs35l41-spi.o cs35l41.o cs35l41-lib.o
> +snd-soc-cs35l41-i2c-objs := cs35l41-i2c.o cs35l41.o cs35l41-lib.o
>  snd-soc-cs42l42-objs := cs42l42.o
>  snd-soc-cs42l51-objs := cs42l51.o
>  snd-soc-cs42l51-i2c-objs := cs42l51-i2c.o

As was already called out on the HDA part of this patch I was expecting
this to be more like how we handle sharing the PXA2xx driver code
between the ASoC and AC'97 implementations - making it a library rather
than linking the object files directly into both drivers.  I'm not sure
that the current approach would DTRT if one or both of the drivers is
built in.

--kBarSnr2m61LE+g9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGdKoEACgkQJNaLcl1U
h9Cr4gf+LNGWPCz+MX/96IXsUS+wPozdceAjKSn80yGpnRSItYewxSIzu2F97cvm
dnB0JfE7YXIR1bYMLulAWnpYyGWoJzI+uTiJJnxXdIfUSpPEMm1t7s7fZqrqhFGz
2ABLlyV0gWZcj6ZGq1X1msELcdJuFgdQUpQZcnCXA/d/dhfadc7DGlBkuKQGpWos
xardpAPBRITGzwQ6ool8+uCrCNcDAiUUMM6m9mzKXCzJ3gGb/hTjpgLymN0Twn/r
oYqINRYJGZCpMPXY3mnDZZjAluSVQ15MT7MfQZx1vjQxTEMZm6crjbTQf1O5Xnd2
WBukoE/U9Mfa1d9uYmqOjP4S9ZPgMA==
=vneV
-----END PGP SIGNATURE-----

--kBarSnr2m61LE+g9--
