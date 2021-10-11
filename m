Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F8E428AF2
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 12:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbhJKKoL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 06:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235925AbhJKKoK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Oct 2021 06:44:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED12A60187;
        Mon, 11 Oct 2021 10:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633948930;
        bh=cjx+5rsYe8UvNF1b9zMrsBf02i/1bJyf0x9UEIvBXgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gWQav5hpST88/wYDpkh53hX1b4+V0AC77g6mqN4yfcQ9TTH+8ZwTBgH5rzi/pnN3x
         wSYLuiKJfUdEboJUvENckKIQM0lLvsR9oNoRIjX9KPi+P/tSPMy1tCzXrLXXSOobVJ
         QbwXpBFpzucrT72JyhRUaL3GoZYGD3ke87TB4QHVFBVMetChnkPndzy63f0UiUpbYQ
         pb8FgD97npdel3t9qA1/z4wSDmjH/CiwHXNFp6n4f2hkBuuKg/8/lgzzHQL0nUfp35
         PawwqUfJMsLYAecPFvBAEHYTS0R4zGvDbeLlrkntEtIUBD92XuMX8qiHgR2z9WR1wh
         irg2MXFeVLmGw==
Date:   Mon, 11 Oct 2021 11:42:05 +0100
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
Message-ID: <YWQU/SYTT5Vk24XH@sirena.org.uk>
References: <20211008162121.6628-1-hdegoede@redhat.com>
 <20211008162121.6628-6-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CXmdVO9SzkamGhvy"
Content-Disposition: inline
In-Reply-To: <20211008162121.6628-6-hdegoede@redhat.com>
X-Cookie: Your ignorance cramps my conversation.
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--CXmdVO9SzkamGhvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 08, 2021 at 06:21:14PM +0200, Hans de Goede wrote:

> +++ b/drivers/regulator/tps68470-regulator.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Regulator driver for TPS68470 PMIC
> + *

Please make the entire comment a C++ one so things look more
intentional.

> +
> +/*
> + * The ACPI tps68470 probe-ordering depends on the clk/gpio/regulator drivers
> + * being registered before the MFD cells are created (the MFD driver calls
> + * acpi_dev_clear_dependencies() after the cell creation).
> + * subsys_initcall() ensures this when the drivers are builtin.
> + */
> +static int __init tps68470_regulator_init(void)
> +{
> +	return platform_driver_register(&tps68470_regulator_driver);
> +}
> +subsys_initcall(tps68470_regulator_init);

If this is actually required then the driver is broken for modular use
which frankly is just generally broken.  I don't understand why this
driver would require this when other drivers don't, or what the actual
requirement is here - what does the call do and why is the ordering
important?

--CXmdVO9SzkamGhvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFkFPwACgkQJNaLcl1U
h9DYAQf/ZlwsujMRBtUtj8bnTodoar5ljYIwvbbIIPON2PaSlXELcV/AX9h7me8A
R3OBXlixWnyr94CUY3iH/jQFJKqMuIreX0T9TCwjfMgHltPFQUiTbyPA+HhsTYAn
dyxV8AF3WBEJVmrRJ3nhSkM8UFz5we/AqLeSwbhhW6Z/J/Cy/n1bhSyEJVomkT1j
cw7+RmGlwHCvVHM0qmZs0h59wL1fQhGL5BH0IgjEDFokKBEfg+zPJTeRYtf4FU0n
7RjHcJF067H+I4hOCikqmtG+FzdT+wewYIWNwFkOmkvVYLEHqg/uV/8q0oLVzxxi
QI2Rqn2VTDC8k/pQZA+vsyF5fNNgmA==
=5gYB
-----END PGP SIGNATURE-----

--CXmdVO9SzkamGhvy--
