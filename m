Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22D742F894
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Oct 2021 18:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbhJOQsl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Oct 2021 12:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241554AbhJOQsh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Oct 2021 12:48:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 601FE60F93;
        Fri, 15 Oct 2021 16:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634316391;
        bh=63gEhzb3OBZlJ22n5iZa/pATwEKiwGFC2MvkMXp5E9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgFfrjbzoShGxigqX0WI+4jeAy8iA8bDPA7rtTr1DF3HXGOzFuc/JjGRD6ST+YT7L
         e83I40du5zwfBErBfYjQQw47eHoEtaE+ReyGpMneiTEdz/cpXpsmHzIa7pzhWNZ5Wf
         AYTtTGYGmWVDicGDzctFcjNqIsXHHaSxbEi9/jFyAJYr9dZVHQG5H8FhyG3rDs/il0
         hkku/5u5G2bq27yOzlluBKefvH/IWJO6MmgcWOYGYINRX62i+nP6RqrseFuMIP6c7X
         8dfQb+3Yi7n95oVbEp4vnyu1zc6snQ3TSZc1Mrv8TEomLQ6+CCY2eChZicqM6chOEV
         QsZ54pl4sQWRQ==
Date:   Fri, 15 Oct 2021 17:46:28 +0100
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
Message-ID: <YWmwZJvDYjPWJdb4@sirena.org.uk>
References: <20211008162121.6628-1-hdegoede@redhat.com>
 <20211008162121.6628-6-hdegoede@redhat.com>
 <YWQU/SYTT5Vk24XH@sirena.org.uk>
 <f6f2d7e8-fdb8-ed64-0cdd-65aded9fc42c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AZ3JQhVeNcAiC8mK"
Content-Disposition: inline
In-Reply-To: <f6f2d7e8-fdb8-ed64-0cdd-65aded9fc42c@redhat.com>
X-Cookie: 1: No code table for op: ++post
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--AZ3JQhVeNcAiC8mK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 11, 2021 at 01:43:40PM +0200, Hans de Goede wrote:

> To make this work when everything is build as a module patch 12/12
> adds the following to the PMIC-MFD-driver:

> MODULE_SOFTDEP("pre: clk-tps68470 tps68470-regulator");

> This will make modprobe load the clk and regulator drivers
> before it loads the main/MFD tps68470 driver.

I feel nervous about this being reliable with all userspaces - IIRC
there was an alternative implementation of the modules stuff in
userspace and someone could always be doing insmod.  OTOH without better
in kernel dependency management and/or more standards based firmware
interfaces I guess we're stuck with this.

--AZ3JQhVeNcAiC8mK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFpsGMACgkQJNaLcl1U
h9AS0gf4no/15R8pT+mpRnVKwmbLUmDvWBhb+5NRxrxIXfPuS+GVJBXDdEQtKhfJ
PQOcF4OZLg8ASeQHCNlcM5chnwmESK5sI5YtJmvLOofhH5Fc6VzlgW8bStqcfgmI
RSHrJj5Y3NplbGPNXjGhzxppmAJsIYo/mFdJaxZnM9sdgOX0fuQUcJFF6nXrv1a6
kZvSJqXVzzyQfOaU/o9uNE3IhCBCxXW5Lb+9sl4q99DAC7t/vZPOMbPPhfwmisKr
mnWVT7wUpr+G/da3pn6pXxYVZZ1KwGIqalYkH00vOa6BipKg1fipFPdJvbv+wfYU
p/D00YI3k7GLtVFqv7RsIzYL7Byq
=xy+y
-----END PGP SIGNATURE-----

--AZ3JQhVeNcAiC8mK--
