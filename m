Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CDA45A9E1
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 18:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhKWRYA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 12:24:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:42962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233829AbhKWRX6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 12:23:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ABAD60F51;
        Tue, 23 Nov 2021 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637688050;
        bh=/G+mVBj47X83QR9mIcyKQRD0Fz7890CtgMMwf9Gixyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H7RZpT6GkJZcb8+lI1ZHaaEHtAOSQHGfnF9mmMU3ZQFpCKLONZiSlwwcywW+gbDec
         L+qTXG8aNyDlQHDLpsQsH/7lfJ4G62WaFOb4nEVFG4t2+Gxp3ZIn9SRB4lWcQbTtUS
         tswFuXi23ri2opUa9mCaLdlh+Du4UP2dtoMQYjivyE3/762DP0IwCMYmKEJP5I++oi
         BRbkbFEpH5PQrEAm7MBiHLBvoI4eNjLbaibwoPICkXEDwewi/PJ3L4l7c0WrJ08+hC
         ej9I1hPMxjjWWIkFC44PvG4hJ/utbjh7hHTTolJPFmugcMUoerCT3ekYu1C21VlLir
         W5RDlA7y0WqDA==
Date:   Tue, 23 Nov 2021 17:20:41 +0000
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
Subject: Re: [PATCH 03/11] ASoC: cs35l41: Move regmap config struct to shared
 code
Message-ID: <YZ0i6TbgIW9qNUQt@sirena.org.uk>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
 <20211123163149.1530535-4-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/JJvFVvi2fOow9X8"
Content-Disposition: inline
In-Reply-To: <20211123163149.1530535-4-tanureal@opensource.cirrus.com>
X-Cookie: A closed mouth gathers no foot.
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--/JJvFVvi2fOow9X8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 23, 2021 at 04:31:41PM +0000, Lucas Tanure wrote:
> Move regmap configs to external include so CS35L41 HDA
> driver can re-use it.
>=20
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---
>  include/sound/cs35l41.h        |  6 +++++-
>  sound/soc/codecs/cs35l41-i2c.c | 15 ---------------
>  sound/soc/codecs/cs35l41-lib.c | 34 ++++++++++++++++++++++++++++++++--
>  sound/soc/codecs/cs35l41-spi.c | 16 ----------------
>  sound/soc/codecs/cs35l41.h     |  6 ------

It looks like they actually end up in a .c file rather than an include
which is what I'd expect (and I don't see anything fishy like including
=2Ec files).

> -const struct reg_default cs35l41_reg[CS35L41_MAX_CACHE_REG] =3D {
> +const struct reg_default cs35l41_reg[] =3D {

This isn't quite a straight move - it's worth calling that out in the
changelog.

--/JJvFVvi2fOow9X8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGdIugACgkQJNaLcl1U
h9D0jAf/T6kAe6qc0e/9no1UElASij34INfN+tMs32FkKXP8wT0TKaG+Hi+pXHZX
SieRilPX1ESToPEt4HgGH/S3lSZHVr2FRQjkKnfgOAPY+7YG0FwpfVewXuHKRH59
aRlok441ye3fj9pPYJSlIz0JHw2bo42jf2g7864fpQ+KLe1Tu+ghfAHzNHiKqJOw
5CBXqurSLagUH7Xql/6vbOdXuSLf/+lb19eJqy7mPjWoeElxQU1Z6bLoODrjuLSG
DP8wNwcmYLfpIOpD+laTl6Go3U7EEVDzsIQzJnVl6eOZrKkWaiKigujrbF7J0F/w
hkWA6xUDUArYhsr4nb0qsxrplmjSjw==
=Ok88
-----END PGP SIGNATURE-----

--/JJvFVvi2fOow9X8--
