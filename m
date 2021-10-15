Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D0742FE25
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Oct 2021 00:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbhJOWbS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Oct 2021 18:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235751AbhJOWbS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Oct 2021 18:31:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B73FE6115C;
        Fri, 15 Oct 2021 22:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634336951;
        bh=TQtRtLYNlFE/GQNWGHE6FL49bQNWg/4TcBK38kMyEcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdvqBCvilrxB5rg9TaeamtdhCRox0HpwskMXhsphnvc8PFUZGtmpsu1AMs2gF0wGA
         9YbLmc+sy5PqGzjPYGxE5N8j3btU3CYGreT7U6rr0J8kGJsi0k7C4g7XDY79WIj8SC
         X4V3+fTgQxB9FRxot1OBSbzaVd1IiLGDS13cJj0LkVWA1nzN2HqHnsfI9/uQJBGDlg
         IGPDilW56TCaxYQa/EkCkyG7N5A+jk31n9n5ovfpDLKLInpH7NgYcgvyXQI9C3p/fg
         9LZj9zgxlhoEvuSNjtRnEfXsvvXsgGg1TCleGikg4tBdzfiMNovhH4+q1XNOdgPnkL
         e0plAGH1ltXhA==
Date:   Fri, 15 Oct 2021 23:29:08 +0100
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
Message-ID: <YWoAtCdikYfMpUnD@sirena.org.uk>
References: <YWQU/SYTT5Vk24XH@sirena.org.uk>
 <f6f2d7e8-fdb8-ed64-0cdd-65aded9fc42c@redhat.com>
 <YWmwZJvDYjPWJdb4@sirena.org.uk>
 <d0d1dc05-4cc6-2f47-88a9-700cfc356d86@redhat.com>
 <YWnPaI/ZECdfYre9@sirena.org.uk>
 <843f939a-7e43-bc12-e9fc-582e01129b63@redhat.com>
 <YWnZIZTPiuAIazV+@sirena.org.uk>
 <c595b143-d7ed-e76b-7734-e03d14e0f76e@redhat.com>
 <YWndpGgBtLEAEaNj@sirena.org.uk>
 <1805d16e-87ab-c291-6a73-adabf41344ca@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F/jmgXxh9qwDNeFa"
Content-Disposition: inline
In-Reply-To: <1805d16e-87ab-c291-6a73-adabf41344ca@redhat.com>
X-Cookie: 1: No code table for op: ++post
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--F/jmgXxh9qwDNeFa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 15, 2021 at 10:14:30PM +0200, Hans de Goede wrote:
> On 10/15/21 9:59 PM, Mark Brown wrote:

> > No, it's not.  What normally happens is that whatever registers the
> > device will when registering the device supply platform data that the
> > device later picks up from the struct device during probe.  What you're
> > saying is that the idea here is that driver unconditionally declares
> > platform data and then other code scribbles over that before the driver
> > instantiates.  This is cleaner in that it keeps the platform

Actually, correction - there's no export of tps68470_init[] so I guess
that's just the data that gets used :/

> > configuration together and safer since the device can't exist before
> > it's configuration is provided.

> Right, this is the standard device-tree model. Unfortunately the
> information about which supplies are needed and the constraints
> for those supplies is missing from the ACPI description for the
> devices which we are dealing with here.

That's not just the standard device tree model, that's how systems with
board files work too.

> During that discussion you said that instead we should sinmply
> directly pass the regulator_init_data, rather then first
> encoding this in device-properties in a swnode and then
> decoding those again in the regulator core.

> And passing the regulator_init_data is exactly what we are doing
> now; and now again this is not what we should be doing ?

No, it is not what the driver doing now.  The driver will *optionally*
check for platform data, but if none is provided or if it doesn't
configure some of the regulators then the driver will provide some hard
coded regulator_init_data as a default.  These might be OK on the system
you're looking at but will also be used on any other system that happens
to instantiate the driver without platform data where there's no
guarantee that the information provided will be safe.  These defaults
that are being provided may use the same structure that gets used for
platform data but they aren't really platform data.

Yes, someone could use this on a system that does things in the standard
fashion where the platform data is getting passed in but if it's ever
run on any other system then it's going to assume this default platform
data with these constraints that have been embedded directly into the
driver without anything to ensure that they make sense on that system.

Indeed, now I go back and dig out the rest of the series it seems that
there's some drivers/platforms/x86 code added later which does in fact
do the right thing for some but not all of the regulators, it supplies
some platform data which overrides some but not all of this default
regulator_init_data using platform_data having identified the system
using DMI information (with configurations quite different to and much
more restricted than the defaults provided, exactly why defaults are an
issue).  I'm now even more confused about what the information that's
there is doing in the driver.  Either it's all unneeded even for your
system and should just be deleted, or if any of it is needed then it
should be moved to being initialised in the same place everything else
is so that it's only used on your system and not on any other system
that happens to end up running the driver.

In any case given that your platform does actually have code for
identifying it and supplying appropriate platform data the driver itself
can be fixed by just deleting the else case of

	if (pdata && pdata->reg_init_data[i])
		config.init_data = pdata->reg_init_data[i];
	else
		config.init_data = &tps68470_init[i];

and the data structure/macro it uses.  If no configuration is provided
by the platform then none should be provided to the core, this in turn
means that the regulator framework won't reconfigure the hardware if it
doesn't know it's safe to do so.

> Also note that the current solution is exactly what I suggested
> we should do during the discussion with Daniel and I even provided
> example code and you said absolutely nothing about this!

I had been under the impression that the platform data would look like
normal platform data and come along with the device registration,
providing default regulator_init_data hadn't really occurred to me.

> And please keep in mind that we *cannot* change the ACPI firmware interfaces
> and that whether we like it or not things simply work different in the ACPI
> world.

> Frankly I'm quit unhappy, angry even about how you are blocking progress
> here. You don't like APCI we get it, can we get over that now please?

ACPI is fine, we have a bunch of perfectly good ways to handle things
that need quirking on it safely - both platform_data and DMI quirks can
and do work well here.  The issue is that we should be using those
things rather than inventing new things unless those new things solve a
problem.

> So far all you seem to be doing is shooting down solutions, then first
> being quiet about suggested alternative solutions and then once the
> alternative solutions are implemented shoot them down again...

> And all that without adding anything constructive. All you have
> told us is how things should not be done (according to you).

> So fine everything we come up is wrong, please tell us how we should
> solve this instead then!

The important thing is to get rid of the hard coded defaults for the
regulator_init_data in the driver itself, if there is regulator_init_data
in the driver itself then it should be guarded with a DMI or similar
quirk.  Like I say above I think now I've gone back and dug through the
rest of the series once the default init_data is gone it's probably OK.

--F/jmgXxh9qwDNeFa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFqALMACgkQJNaLcl1U
h9B5aQgAhQ7bqrNnhCcHborjeRwONxMdsrv6cyyt5sQlX5QAkjsYkIsE6OJfdwPM
vHFJhWNXVJxfixf0+HRxF0ROwDSxjE+YOhuAnfxi61RWXx1aLkovdK9kBjVcRP3Y
+WAgoVItgQ5PZkaL5x8+EvGDlAAmqjauL2EstgBYLoIA4jO9DW0jUoBEISyTlngS
GXw+3CGX0mKpIADv8UCCjVKFZ4gXerXRroZD6tMqS1rV/YkpaLreZtHZz1iTMSOX
lkllAPXbaqmKK2XIGd3N6kniK1JgG2uBoXGf4ErkWGl5swcNjIV8QaOVrCfyyg0r
w23iI+GBFoQd2NNhwK+8601UryTwZQ==
=ujeE
-----END PGP SIGNATURE-----

--F/jmgXxh9qwDNeFa--
