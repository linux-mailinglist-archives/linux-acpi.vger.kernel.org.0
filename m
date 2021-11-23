Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49DC45A9D2
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 18:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbhKWRTF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 12:19:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhKWRTF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 12:19:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EF0660F6F;
        Tue, 23 Nov 2021 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637687756;
        bh=E+dBwomnzyWKIhT2whg5UaMBKOluRqPTO6X6XW8z7mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQ0v6PbhOwWl3NzftqVi/qVreHqLCe2Upzbc8LBBCLaqvAkfHvWaeaVYcG86soJDv
         waw5UnGNjUSVqWsFKSQ4RgKVHNW1GPPpGbP2HHTpP5iDxt1QrGWgz066mZIoyV7Ygd
         yuTl1w/2oU0xFoqDSQD4gnbf59mZyzSz0JT68ieCwb6T8hR0OM/u+Of9Upt8WfgMcW
         LpC7MduSgPBiujgcd51rS4INUZgwPj0w4VG1exRe1u7juh9v3ciVenmZH7qPV9VooU
         fLWRB1p/gJqMuZ6E4G0stRXL7+uevtMly5WlKSz+dAQRMmPPwMK5DFXJdHAX4aE8tB
         DKOhO8PbkFq6A==
Date:   Tue, 23 Nov 2021 17:15:48 +0000
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
Subject: Re: [PATCH 10/11] hda: cs35l41: Add support for CS35L41 in HDA
 systems
Message-ID: <YZ0hxCcP5h1eU63A@sirena.org.uk>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
 <20211123163149.1530535-11-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KmAEv/XYU5I1OTsL"
Content-Disposition: inline
In-Reply-To: <20211123163149.1530535-11-tanureal@opensource.cirrus.com>
X-Cookie: A closed mouth gathers no foot.
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--KmAEv/XYU5I1OTsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 23, 2021 at 04:31:48PM +0000, Lucas Tanure wrote:

>  S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/cirrus,cs*
> +F:	sound/pci/hda/cs35l41*
>  F:	sound/soc/codecs/cs*

Perhaps just match anything starting with cs rather than just this part
number rather than needing to churn in future?

BTW I notice that the CC list for this series is *huge* and it's hard to
see why some of the people on CC are included - please think carefully
about who you're sending things to and why.  People get a lot of mail
but there's no need to add to the flood, it makes it more likely that
things that are important will end up getting missed.

--KmAEv/XYU5I1OTsL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGdIcMACgkQJNaLcl1U
h9D3OAf/Z1nxuLACsgmmsSOKL+iZyyHgNx1SqNSpwS2Absxs1WIEk8peLn5AM24+
9Tj7Yv5qhscn5ogvyquAVxMTbhs/VI4eqsy9z37/cfiHZozMQPz2lxobwxIztyqy
yLf2YLnHIlenI9gqvj3Ixi7wCm9U7agT/UOhwNWd9IRQDBUSTgjl53owul0Rt0Fv
uS8EI9cvmZEIyH8vcpA5gWnICVEbq/cBzPkoOvvWwkI4qd2JeAK8s1jO/0Q3vzs9
X8qgHigt1fLG4768Q4InEvkB8WWBBQ214xT+r4lenjcSqY9KfQwYBxYImuWXZSUZ
p4EnMrqi1jXMhnPbP46pP/ruPueQ5Q==
=6Fhl
-----END PGP SIGNATURE-----

--KmAEv/XYU5I1OTsL--
