Return-Path: <linux-acpi+bounces-4577-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2476189384B
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Apr 2024 08:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A881D1F2128E
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Apr 2024 06:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6133EBA2D;
	Mon,  1 Apr 2024 06:16:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AEB137E
	for <linux-acpi@vger.kernel.org>; Mon,  1 Apr 2024 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711952202; cv=none; b=h3F/JdIINodiHXa48R68XzhQXXVFbzSy11qfIDufHtdRLGRtpUJEQQM4JV2TIOBJBy4xRW2oRRK8SmQO8CQiNr1eycmvA/5hc1FrDIYH90pzFlpoR1RIIJfbV7KX87gNBxGlVKTH3L4TOYefMv1V99GbvlkzthYz/TinOaVgiPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711952202; c=relaxed/simple;
	bh=XM4xbUWCUbSz/vmKxlB+xeAKRwv6EBlE/vhhtcnQlRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5h9OkNVMisyXyadCwQ6DKurMnfeokMb9gBiNHlRnM/Ds2BXBsG3DZXihP9mkymmIfy7ci9LlO/oM2+2AkzHHgxWz3g1O0f261DUeCfBOxjvmcLwKmloQYP9YeUwTYjiGmMGMYDQ4LAeqdBUjQfu/5bkaE8QuRrBs7M9RmnmBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rrAxx-0004mF-26; Mon, 01 Apr 2024 08:16:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rrAxs-009jzq-8z; Mon, 01 Apr 2024 08:16:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rrAxs-00Dx5E-0a;
	Mon, 01 Apr 2024 08:16:16 +0200
Date: Mon, 1 Apr 2024 08:16:10 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Tony Luck <tony.luck@intel.com>, 
	Ben Cheatham <Benjamin.Cheatham@amd.com>, Avadhut Naik <Avadhut.Naik@amd.com>, linux-acpi@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, James Morse <james.morse@arm.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: APEI: EINJ: mark remove callback as __exit
Message-ID: <k6mt6mrhygsc5d4bbfrk5h4kwrkdnansghqs75wmtx7ti7pzah@u266axoc37ny>
References: <20240329100203.540368-2-u.kleine-koenig@pengutronix.de>
 <53480b07-612f-4701-bcd5-bb677701b00e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ulklzajpnuxwbopu"
Content-Disposition: inline
In-Reply-To: <53480b07-612f-4701-bcd5-bb677701b00e@app.fastmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org


--ulklzajpnuxwbopu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 08:00:32AM +0100, Arnd Bergmann wrote:
> On Fri, Mar 29, 2024, at 11:02, Uwe Kleine-K=F6nig wrote:
> > The einj_driver driver is registered using platform_driver_probe(). In
> > this case it cannot get unbound via sysfs and it's ok to put the remove
> > callback into an exit section. To prevent the modpost warning about
> > einj_driver referencing .exit.text, mark the driver struct with
> > __refdata and explain the situation in a comment.
> >
> > This is an improvement over commit a24118a8a687 ("ACPI: APEI: EINJ: mark
> > remove callback as non-__exit") which recently addressed the same issue,
> > but picked a less optimal variant.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>=20
> I noticed another curiosity:
>=20
> >  static struct platform_device *einj_dev;
> > -static struct platform_driver einj_driver =3D {
> > -	.remove_new =3D einj_remove,
> > +/*
> > + * einj_remove() lives in .exit.text. For drivers registered via
> > + * platform_driver_probe() this is ok because they cannot get unbound =
at
> > + * runtime. So mark the driver struct with __refdata to prevent modpost
> > + * triggering a section mismatch warning.
> > + */
> > +static struct platform_driver einj_driver __refdata =3D {
> > +	.remove_new =3D __exit_p(einj_remove),
> >  	.driver =3D {
> >  		.name =3D "acpi-einj",
> >  	},
>=20
> I was wondering why this doesn't cause an "unused function"
> warning for einj_remove(), given that __exit_p() turns the
> reference into NULL.
>=20
> As it turns out, the __exit annotation marks the function as
> "__attribute__((used))", so it still gets put in the object
> file but then dropped by the linker. The __used annotation
> seems to predate the introduction of "__attribute__((unused))",
> which would seem more appropriate here, which would allow
> more dead-code elimination.
>=20
> The patch below gets rid of the __used annotation completely,
> which in turn uncovers some interesting bugs with __exit
> functions in built-in code that are never called from
> anywhere, like
>=20
> drivers/video/fbdev/asiliantfb.c:627:20: error: 'asiliantfb_exit' defined=
 but not used [-Werror=3Dunused-function]

Do you plan to follow up with the respective fixes? If not I can add it
to my list of things to clean up.

> diff --git a/include/linux/init.h b/include/linux/init.h
> index 58cef4c2e59a..d0e6354f3050 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -82,7 +82,7 @@
>  #define __exitused  __used
>  #endif
> =20
> -#define __exit          __section(".exit.text") __exitused __cold notrace
> +#define __exit          __section(".exit.text") __cold notrace

include/linux/init.h:82:1: error: '__exitused' defined but not used [-Werro=
r=3Dunused-macro]

:-) Apart from that: nice find.

>  /* Used for MEMORY_HOTPLUG */
>  #define __meminit        __section(".meminit.text") __cold notrace \
> @@ -394,7 +394,7 @@ void __init parse_early_options(char *cmdline);
>  #ifdef MODULE
>  #define __exit_p(x) x
>  #else
> -#define __exit_p(x) NULL
> +#define __exit_p(x) (0 ? (x) : NULL)

I remember wondering about __exit_p not using this idiom, but I didn't
follow that thought.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ulklzajpnuxwbopu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYKUSUACgkQj4D7WH0S
/k6sLQf8CCGAon3jjuxup9AOvmR6AyVpHFVrxfWpXzOfcR+BpfYT+yZMFVb7Sb8i
T7y3eiNH9q9S19zpKTLKk0HZTaXdgEiuTuxy7WO0VLRZP3Z0oaJwZx7J0k42kSex
5hC4vYN7gu5M1HbFYCRyoyN/CfSAKwU7Q8o+nOgW6YhtXFvR5OiSH9OCpEa8Xlky
XZQSSLGiSP9jQrhXc6+vxhLmZRSPhSoZs6V2hUji5Bvc2d19ziKXy9MHIr7QqyVK
nH/fkO7CXgCgZx0oObiml2oC2RaVswuIoWRzidPeWUSyMeRIHMz/WtxkKGWK0eFy
6Ot1wRrjmrGPfCOx4I2TN3WbenSq+A==
=takd
-----END PGP SIGNATURE-----

--ulklzajpnuxwbopu--

