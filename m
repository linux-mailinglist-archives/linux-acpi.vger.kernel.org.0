Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8908F428BB5
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 13:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbhJKLEU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 07:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235971AbhJKLET (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Oct 2021 07:04:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4591460EB4;
        Mon, 11 Oct 2021 11:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633950139;
        bh=rLvTUINnh7X5dxHDbrT7lTQpGD5oMjl+jxUxLtJ+E5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q0ge84XtrlSzpb/dV/z0PauJWEg/iKeEJ27FwrRpvtbFcs7QdNGXcCxzv4797wC3F
         gAwFr1EwDS8Ewh9vbsOjNuWzjg1+vwMXTSpPVc4/TtgxxLJ2GlTBNvuCuQLQX75res
         Wg26Q1Mx4JY0HJBzGjT4/rJFiGOqP4dZ4+c5BdG8mC65JrDhlESL3BB/ZO6kBT7Evs
         OR8meoJZco/NMWMkklSGG3tgi+crhr8XIDWa3eaUfLIcq3zchTM6w9heeUrrrNX4Dj
         QHTN9PY2Ko3ieiFausxkfjNrDy9HYoBWJzlftoG+xktoIbVow/f9A7/Or1pFSWDo69
         p9pQbANGVbLvw==
Date:   Mon, 11 Oct 2021 12:02:14 +0100
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
Subject: Re: [PATCH v2 04/13] regulator: Introduce tps68470-regulator driver
Message-ID: <YWQZtj7N+2QoZKur@sirena.org.uk>
References: <20211009160548.306550-1-hdegoede@redhat.com>
 <20211009160548.306550-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6lVS4joxd6WyDi8G"
Content-Disposition: inline
In-Reply-To: <20211009160548.306550-5-hdegoede@redhat.com>
X-Cookie: Your ignorance cramps my conversation.
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--6lVS4joxd6WyDi8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 09, 2021 at 06:05:39PM +0200, Hans de Goede wrote:

> +/*
> + * The ACPI tps68470 probe-ordering depends on the clk/gpio/regulator drivers
> + * registering before the drivers for the camera-sensors which use them bind.
> + * subsys_initcall() ensures this when the drivers are builtin.
> + */
> +static int __init tps68470_regulator_init(void)
> +{
> +	return platform_driver_register(&tps68470_regulator_driver);
> +}
> +subsys_initcall(tps68470_regulator_init);

If this actually matters it is still going to get broken when the driver
is built as a module.  We've not been doing this given probe deferral.

--6lVS4joxd6WyDi8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFkGbUACgkQJNaLcl1U
h9BLowf/QN6baaUZLF3njsuXlGPn3X9MGZR5O4H4zAegyfy2uqSvwLtZgJj6RnLQ
5vdRcy0lxfycPGUujHC44jqhb2x2CeyhS3u0zZ1/cD+ZgciSWxJL1cWRLf+CbQ5E
19rJlzJ1jocQe9jN24xvSxcsmvQU0OXhIUDmkyLQY0j9eqFTqiousuTOrblRtK3A
mdvRH2OMFXzEKOb9IVa5tc3nLPtRfmsVr6PmCnlgFVfD5mTF+XXYZiTNd+bHn1YG
wmKXQwT8e+sloWTbwj2xbFasaF4VQ101iycUQGeandv1sfxhHkel9GaIEgtQla+C
eg9CjLwcWKn0CU9KRru/yZITyPGW2g==
=WgC1
-----END PGP SIGNATURE-----

--6lVS4joxd6WyDi8G--
