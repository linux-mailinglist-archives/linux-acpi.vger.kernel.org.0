Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2762D45AAAE
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 18:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbhKWSCH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:02:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239508AbhKWSCH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 13:02:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D4F56052B;
        Tue, 23 Nov 2021 17:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637690338;
        bh=d9t+ZRTCK8H/Ezxf7VMaGXM5QRACAAA0uxZgA56l8E0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNZBmbF3y+P40zNaijOwN98W6E/nbrgj1dOdXuOQVuEyQhVOIuuyQGCIXq/2EEdPU
         +sG2hEI2/1fVfgZsaiBK7pTeWewPN25szGvZseMRNX/+GhlwId4gM1D2ra9aGYn3f5
         e5VfVEwxK7/DYB652JlE2kt2T5z04kCkFA8sop11UvC/yqhuBBLdCz1jfZPCHyDsWo
         KwK4g8OH/KhH2YECZEw6nB/R0rOk6ysyk5DmTGCZZOAA4YgmYd3rsIhYjJhzrNfuZ1
         F9aARDFvFDl2szGxOF0VXGHh01Q9ddsJ2SpbGFEppX+nEBOL/aNsU9c/5+/KaRuav5
         JaUtudF73aLHA==
Date:   Tue, 23 Nov 2021 17:58:50 +0000
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
Message-ID: <YZ0r2s1z15yXLVhb@sirena.org.uk>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
 <20211123163149.1530535-5-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WkK+Jw7iuU6ibZtu"
Content-Disposition: inline
In-Reply-To: <20211123163149.1530535-5-tanureal@opensource.cirrus.com>
X-Cookie: A closed mouth gathers no foot.
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--WkK+Jw7iuU6ibZtu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 23, 2021 at 04:31:42PM +0000, Lucas Tanure wrote:

> +	ret = regulator_bulk_enable(CS35L41_NUM_SUPPLIES, supplies);
> +	if (ret != 0) {
> +		dev_err(dev, "Failed to enable core supplies: %d\n", ret);
> +		return ret;
> +	}

Where's the matching disable, I didn't see anything in the HDA code?  It
is there in cs35l41_remove() in the CODEC driver but there's nothing
sharing that bit of code here that I noticed.

--WkK+Jw7iuU6ibZtu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGdK9kACgkQJNaLcl1U
h9DmbQf/WBTOwnGah2RPWstqHbB4KVwvwuQL1bd7ZNWcCo0Tm7mJQ9fZijq/ymRX
dygCYgN8kwNIQVjQ3Z8xagPhs7FHNJ+Iye3MYstcm87rXUabmvqgvLOVJ0H49Ttd
QukPv/bLwugCmcvctZOtEcGv9CnkZ/P74/m+a54Bi4Rz0mnu+bs4AjyCMT4Ql//S
K1B9/giEf7ZKuCcwUOZysoIs7xMK2LV15oQBlgC79XLZ6Q2hgxFoE4pEJZC7fAvo
OQ3akqHcXS5W7KdM9B2TC3bJjEceOguigbs/2ETyg01M2a7Hfgaf5vmUdyM6cM/y
NWZuJ6hwB/rXi6x7Sc6U3vcnduhh7Q==
=bhpN
-----END PGP SIGNATURE-----

--WkK+Jw7iuU6ibZtu--
