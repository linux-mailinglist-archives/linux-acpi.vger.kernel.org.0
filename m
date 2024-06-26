Return-Path: <linux-acpi+bounces-6631-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A6D91860B
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 17:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5561F21259
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD07818C350;
	Wed, 26 Jun 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiRfV30b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907B918C34A;
	Wed, 26 Jun 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416357; cv=none; b=b9wFLZPSoV78Yl7A72jjk0Z2sHDWdAU6SqJck1dTybgXW6hi0dCoYEIxnPw3izIuSixogOVuCL229N/3aCs+Qp6Ns3/XKykgIL6maWmFfY/cG0ruWlALhL7imWXeY8HZwbeyl6AfQkIGHsOBSvC8f3KAoVbnX5RqWQvVu8GAXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416357; c=relaxed/simple;
	bh=IhtfoX2xoWChAu+Pe7FH52ll/R7Au3OdYNJJdaxYtFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kg8xYPdyJCZSsokLTKiyiRJgC3dwgoTV+//QRrQl7dXF1JrqjGrgs/3QdmlASeGGT3ri/bbrTlkG+C/q3wH0vLgnE1bhulpTpop5D6ebZn+FKuITOTmUlazS+T9N1U137+a5YBKEygco95krlyNEVJBbG8G3z8/x102/Ysatmn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiRfV30b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCC5C32789;
	Wed, 26 Jun 2024 15:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719416357;
	bh=IhtfoX2xoWChAu+Pe7FH52ll/R7Au3OdYNJJdaxYtFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aiRfV30bum5kTG4yK4BM1hS8H8MOrxY3vfMduOAdKjNjmmOwAcwjnzTKHHMVJGiZd
	 OSSyMAY5XgVtDyvACP2ZpyI9eDelZimE7s3/4se8wSj9yaGRlNqEJlk8H/VvcXE6Ax
	 q1uOphO8cUPZl+I+URTXP8zLdyl6m3JiTE3I37SFHLwcGSbCr/ooxbVhWW/Q6QQzXy
	 5HPCuDCEiii+trR0Dje2IuCYx9KTq2nqjaKebQro7R9cFzeUTSGAIFuuqbdCdrD3RE
	 fwK/a+4WT7gYy2S6zrMdBL6TyAR/U/G+W+96JRPyQZZQXzbLcePsQeuhR/FfXuUyV/
	 Ht0uuIJ6Amq4w==
Date: Wed, 26 Jun 2024 16:39:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH 2/5] ACPI: sysfs: use device lifecycle for _STR result
Message-ID: <d599e864-9961-44e3-8b9b-bc41a8044319@sirena.org.uk>
References: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
 <20240613-acpi-sysfs-groups-v1-2-665e0deb052a@weissschuh.net>
 <a72495c3-c996-4be7-bc64-ba10d5400971@sirena.org.uk>
 <111f7a2c-403b-40b3-9e25-8c4a040d8dfb@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ThsiVx38b9ZxGlco"
Content-Disposition: inline
In-Reply-To: <111f7a2c-403b-40b3-9e25-8c4a040d8dfb@t-8ch.de>
X-Cookie: Results vary by individual.


--ThsiVx38b9ZxGlco
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 11:56:18PM +0200, Thomas Wei=DFschuh wrote:
> On 2024-06-25 21:57:13+0000, Mark Brown wrote:

> > <2>[   50.236703] acpi LNXTHERM:08: Resources present before probing

> This does make sense, the device is not yet bound to a driver.
> Which apparently precludes the usage of devres.

Oh, yes - I really wouldn't expect that to work at all, devres is all
about tying things to the device being bound so trying to use it outside
of that is not something I'd expect to go well.

> I'm also wondering why the _STR attribute behaved differently in the
> first place.
> Does the patch below work better?

That patch applied on top of -next appears to resolve the issue.

--ThsiVx38b9ZxGlco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ8Nh4ACgkQJNaLcl1U
h9D87wf/VyUjV4W7+iYgqIYNd/24zKKwbxyauIimxphLw7n6u+synEimAReZyfYK
HI/AFPsvBAYPcEoxXpNKI7P9fglF57aZiPZ9sVDYen2eu0TzVMzoHb9ulBVldtjD
v8ZIyVuLR+I2dML06fiCtu2ILNvj64qogHCPdYx5VwAfCifR0upX4WHVKVMHxO14
QsfvS26j4ltxXJaBCZUaLvdEDnUS5lcwdo2t/c3Nz2Ghi0i43SUoYCD5RpDVlojh
fCB0Vv5m7UFZ82nRW/rcziIZiemckDIu2mx+TLEH5frIuj5eJNQeD4XGbtb06Y2e
x8e1qU7j1Qq1ctHhaTsuJIt9frRlrw==
=Vt/1
-----END PGP SIGNATURE-----

--ThsiVx38b9ZxGlco--

