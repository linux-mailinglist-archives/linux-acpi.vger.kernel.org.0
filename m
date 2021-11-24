Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2F845C695
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Nov 2021 15:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347508AbhKXOKW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Nov 2021 09:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354592AbhKXOI1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Nov 2021 09:08:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2880611BF;
        Wed, 24 Nov 2021 13:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637760715;
        bh=QFU9huopJ1xeYjSSB6nMmQbA/vbauGkKaHZqMRU4bS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIJ/fP9hdSBqgYZhCG+OgB2C952jBEWuMu1dHcaN4OZEqbJqcqf4apX8F4LAU68UA
         jquyUrJ27zsTNsAQioCetNH3bWP/6qMB4Xllw6GExBZYJoihHO/+CPF4ADTqdFjXRv
         aXLRW7dXExZ06tGush5Jh41lWAD4Te04qgOF5ejWCVttgN9MK0a1zSO/XORibilYoj
         +zWvrn5b/uutGFA28JnoBTpeUu4UFbTJ6j/2EF6lH1BJk8LXAyF6uLMsC5x4aXQihk
         BaF457+Fp4nw8qTa76MziQVv3DrFuq5dqCqk801oC1rTX/li2hN+yYMB5NMBBQnVKE
         qmHCcr0xaJVfQ==
Date:   Wed, 24 Nov 2021 13:31:46 +0000
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
Subject: Re: [PATCH 04/11] ASoC: cs35l41: Create function for init array of
 Supplies
Message-ID: <YZ4+wu5aaku4u6qA@sirena.org.uk>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
 <20211123163149.1530535-5-tanureal@opensource.cirrus.com>
 <YZ0r2s1z15yXLVhb@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Lkt1foV1iL9BAfKp"
Content-Disposition: inline
In-Reply-To: <YZ0r2s1z15yXLVhb@sirena.org.uk>
X-Cookie: (null cookie
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--Lkt1foV1iL9BAfKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 23, 2021 at 05:58:59PM +0000, Mark Brown wrote:
> On Tue, Nov 23, 2021 at 04:31:42PM +0000, Lucas Tanure wrote:

> > +	ret = regulator_bulk_enable(CS35L41_NUM_SUPPLIES, supplies);
> > +	if (ret != 0) {
> > +		dev_err(dev, "Failed to enable core supplies: %d\n", ret);
> > +		return ret;
> > +	}

> Where's the matching disable, I didn't see anything in the HDA code?  It
> is there in cs35l41_remove() in the CODEC driver but there's nothing
> sharing that bit of code here that I noticed.

Relatedly, given that the HDA stuff will most likely only be used on
ACPI systems are you sure it needs to handle regulators at all?

--Lkt1foV1iL9BAfKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGePsEACgkQJNaLcl1U
h9AqFAf+LegJkpoeZg0eJ9EnAmsGSQK73vyaOr+rEHjY4AAFPg11h5r7lfZGByW6
VAGiGnwJFEIG5OMtGM327Q4xnT7E3PdKxx+p6isIHRvKQy1S/Sgr4zap8WiDnna5
K8i/jr4dpYmItrfOuWKxoTTlv5W7uGpY+4VPi40oP9Z5LJlxWtwTpWptw/mJPw0t
UTSn59eX+7dc9B+PJOg68yekHDmVlpNdzVpgGTtoSVGELQ7XoZlPQap0Szj1RsQF
5U2ztjSjNvsyb8LdyMpw1uy7XVuIniKJtYtC+BgV8of5kxbdqcTTizANTV9VuBAW
Znu1rJBHlrfNR+kaGEAnMEohvVUpyg==
=tasH
-----END PGP SIGNATURE-----

--Lkt1foV1iL9BAfKp--
