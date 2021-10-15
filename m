Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9447042FB88
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Oct 2021 20:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbhJOTA7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Oct 2021 15:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242091AbhJOTA6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Oct 2021 15:00:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9B9361041;
        Fri, 15 Oct 2021 18:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634324331;
        bh=G82GvShkI2sS0Zha329b0vmAJ+/o/V8FAjLI2CyDuHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEcftEAp7E/3KdVqr9ES8s9gv/a7pp/vZmNc2SdZRqaV6jwAmcx5TMfUb5/zuCkFw
         QJe9FWB98sKeyIu7UDoWBOKsjlFrxivPC7Qk5Fg8oskNQ62JI8JmOaJiHYMtO4rp+Y
         1C8BwGt3rCoXZXEzLPoYYRQPcL8N6GeQ2ZbmUhfCwjFRAAhxxPwiiwuYiiKZ2zvcHC
         biQ8dmmnkAN4CCULB9N2VvtSszyN7sh0mw2PYxsKZPK7W+I8ccCrDlix5nJevD26hk
         fea53Hv4pyVoNatdrBWVumdFeQDfy1vRMIV2Kjr/V2Picb8G1MW35RRBEuB2MLgEBs
         Nni976TeDnvUw==
Date:   Fri, 15 Oct 2021 19:58:48 +0100
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
Message-ID: <YWnPaI/ZECdfYre9@sirena.org.uk>
References: <20211008162121.6628-1-hdegoede@redhat.com>
 <20211008162121.6628-6-hdegoede@redhat.com>
 <YWQU/SYTT5Vk24XH@sirena.org.uk>
 <f6f2d7e8-fdb8-ed64-0cdd-65aded9fc42c@redhat.com>
 <YWmwZJvDYjPWJdb4@sirena.org.uk>
 <d0d1dc05-4cc6-2f47-88a9-700cfc356d86@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fik2/uEMPbbf9stB"
Content-Disposition: inline
In-Reply-To: <d0d1dc05-4cc6-2f47-88a9-700cfc356d86@redhat.com>
X-Cookie: 1: No code table for op: ++post
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--Fik2/uEMPbbf9stB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 15, 2021 at 08:50:13PM +0200, Hans de Goede wrote:

> Are you happy with the platform_data for this driver as defined in
> patch 4/12 ? :

Some of the other review comments lead me to believe that you'd be
sending out a new version at some point?

> https://lore.kernel.org/platform-driver-x86/20211008162121.6628-1-hdegoede@redhat.com/T/#m745cc1191f531a57ae7998f5c8817ba9a46f0fed

I am very confused about why it's in the driver without a DMI quirk
and/or clear comments about why and saying that this is a terrible
example to copy.  I'd also expect to get compile test coverage for the
driver.

--Fik2/uEMPbbf9stB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFpz2gACgkQJNaLcl1U
h9Duwwf7BD9CuMWRm3gNfjStvs3aYG6Zil6RBWStSHHnVqi6JXOSXL/qEtD/MSTx
fYmQ9GikR+iOnZk916F+Iux8DMGV0XunUnnv0X0C7yt3fpo+GtJYpHsYdLeGYaxC
BkAvEs3C4EEGWtf3OLtcqE/PZwFaXPFvj8yk1iM/VXnHWtsottsklIQQD+eCKSVV
Q98ZH/m/NmS2sQyTYBfcfIHtUIT0n2P3XnlG3CocoXyxfAnrCoiTJKD6zUxt+kdJ
h/Rn5VFcYOZXZQd0ZFbwwFSz2+2Rq5pqmL26NKtExZxr6Wy0C4AbYLojiwLstbiI
yRE9TQbogn37aDMHN8Ip5k4G99YqZw==
=cCEU
-----END PGP SIGNATURE-----

--Fik2/uEMPbbf9stB--
