Return-Path: <linux-acpi+bounces-1083-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0617DA789
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 16:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79251C20953
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4411B15AE0
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFDls51T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503653C1E
	for <linux-acpi@vger.kernel.org>; Sat, 28 Oct 2023 13:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9D1C433C8;
	Sat, 28 Oct 2023 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698499778;
	bh=8RXh2aFylTuzoVvc1UQlM5Tnfa7kR2L84Y9RykvcTeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFDls51THlOnX8IHTzgerW1wf/WkL5ccDGiCRFxEIxnOefDYWExV6v6vE43SceprT
	 vz2ZkRTLZqeN8ah18h3wn36L+HTTv0Du7qSXf4rCPxdjaZi+OREcU2sD2Cn2xy/t1M
	 eHQDlUV6+F8btTr0pQgFXIJQEq9Lc4qsQbL5cNGvaVsaxSRcIk42K8STRWWnCx/w0y
	 DpjAIpUo2hExtMZ5UUAbJ88xcyCjeKD6VlaF6/NNyzxAsCGBNqqim9M3Cb5FImuvvr
	 hmVjUy481aRETdi4xsT1Ks7XEuip2QxIrrZuvt82lgDDGnqZlJXv5wCw/awjLHUcNp
	 f/Xc55RySQ0WQ==
Date: Sat, 28 Oct 2023 15:29:34 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Wilczynski, Michal" <michal.wilczynski@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: i801: Use new helper acpi_use_parent_companion
Message-ID: <ZT0MviEHw702E2fG@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Jean Delvare <jdelvare@suse.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Wilczynski, Michal" <michal.wilczynski@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
References: <90bd1071-317e-4dfe-b94b-9bcee15d66c5@gmail.com>
 <6e935761-5b36-411a-ac82-cbc394bba7b6@gmail.com>
 <206f0f25-8a83-4e53-89fd-cbe025e5798d@gmail.com>
 <66418e44-6862-4555-9280-2633ffb34d23@intel.com>
 <CAJZ5v0hfSZCgoW1mq=jeqjMBtsr=6JJaG8OWfUkAW80KF509Nw@mail.gmail.com>
 <e86fb57b-afc6-478b-9a9d-543b87bc8d3d@gmail.com>
 <20231024150917.79736389@endymion.delvare>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rbW9D1EQYzCInJLn"
Content-Disposition: inline
In-Reply-To: <20231024150917.79736389@endymion.delvare>


--rbW9D1EQYzCInJLn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > >> I think this case is a bit too trivial for a helper, it's one line b=
efore, and
> > >> one line after, so it doesn't really save much. =20
>=20
> I must say I share Michal's skepticism.

Because Rafael likes it, I will pick it up.

> > > If this pattern is repeated in multiple places, the helper makes sens=
e IMO.
> >=20
> > I didn't check each usage in detail, but this should be the places wher=
e the new
> > helper can be used.
> > Another advantage IMO is that the helper, being a function instead of a=
 macro,
> > is type-safe.
>=20
> If type safety is a concern then I'd rather turn ACPI_COMPANION_SET to
> an inline function (which would make more sense than a macro anyway
> IMHO, as it has an intended side effect).

I guess this can still be done seperately?


--rbW9D1EQYzCInJLn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmU9DLoACgkQFA3kzBSg
KbYLSw//aDHPIhFN2A1ShKh+UNGEHL1X7IQelssgW8wVosgJM080LegzsAT9vTV4
KG6krX2uo0oRHzV38LnN6sjNDUsJZWTO+822lO1QMyN1pK4q8fb3Z2+lIKDCada2
FTLVdVKL8vEep7G4iL22n2KDGsRng3l65J6UB34yBXXAsHB+J7d4p0EOrR99Yq6r
GrTACc3yfpUo9V1tdnbmnaIeS0A35DnN2eufR5vc2wnChhoGYt8cjBrwsswgWDBQ
S4t7zaRY1PDvEQ4RadUWoCql0CNpCLrqXvFC+sv39BmGaVd5e2ixwE7wibHHDMok
hMBKYJvNI7YO2U1Ttz4ELCnKiBgr3SaE89qhQLyPVh18MMPV9Qcc4UCg8ZyjMKBA
648GR+RnYAeLuHSE6bEbL6QU/PkKCW9HFGklHTotfB8LyeIBKKjo3NsWQxjsE9G5
EbOZN6LsUXuhFovuoAtReXsfPSJYsHkqBhgzO8wHBVW0vJJulDxdJYjS8OG8RuO7
MXv8PvFQrgzMZRjhMjOziVr0a5cbIxFZW4AL5eiPMafFVqH9C/Gipro6fqe9hnJQ
1o0thMM4Ch2kcKTtwPh0I5nzWnq8hkV5SxH2NP0kFDsdFLX8ZKzijw+nV0OwFrdl
NMBCbS3/fbUhZxsF2tkCsbn5K5f+O5Czwwt2sWZUupoctuzLqyA=
=M2U9
-----END PGP SIGNATURE-----

--rbW9D1EQYzCInJLn--

