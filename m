Return-Path: <linux-acpi+bounces-1084-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF307DA78A
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 16:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7810F28155B
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 14:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270B515AE0
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/PbmTkl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BE23C1E
	for <linux-acpi@vger.kernel.org>; Sat, 28 Oct 2023 13:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207E8C433C9;
	Sat, 28 Oct 2023 13:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698499830;
	bh=pcALMgoNudSRFlg3PZieRpjFDqdQ28oJgKcE+lzVpXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/PbmTkltpQgn5nbOrPLE2pr44baoNy/riT+1jPRlJNbdwpbium8Gdh+lhwXqlmN9
	 PM6d5hp7mRofSeWu+SWvPexM57QqNklLpXEocV5ISOlR3msTCKP139fP0yq75wGri4
	 +RCCPKRvTzNwIN+eYbLnZu0c3tmHVSF2G20t8GfabkFVTQdUItg5wu/auQ6Rm9iLpS
	 Qqicuy77q5IpVvxt8wfoxUjyE1hgpBrPJCLrTsm2BNg0+sk6kw4b6XluPX2jsVuDOc
	 tXQrodGK0KxWwUxnQsBn8ub1wo7XAa/wOwHRIM/wLygAYiVFMn3AiohxpDD7i1oSaB
	 GZpmu4c9way5w==
Date: Sat, 28 Oct 2023 15:30:26 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Andi Shyti <andi.shyti@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI: Add helper acpi_use_parent_companion
Message-ID: <ZT0M8opwbPxTV3zo@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	linux-acpi@vger.kernel.org
References: <90bd1071-317e-4dfe-b94b-9bcee15d66c5@gmail.com>
 <6e935761-5b36-411a-ac82-cbc394bba7b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="muWSw0Tqy8JCNnD3"
Content-Disposition: inline
In-Reply-To: <6e935761-5b36-411a-ac82-cbc394bba7b6@gmail.com>


--muWSw0Tqy8JCNnD3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 15, 2023 at 11:34:25PM +0200, Heiner Kallweit wrote:
> In several drivers devices use the ACPI companion of the parent.
> Add a helper for this use case to avoid code duplication.
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to for-next, thanks!


--muWSw0Tqy8JCNnD3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmU9DPIACgkQFA3kzBSg
Kbbfaw//R23F18DRMoi7RSNhP+hFe3C3AT6pKFsze12si5LEps2batAjqDfShYy+
rQP224tXZPro4W02CS7lGnemwzpfGz7yoJSC2fbGueh8/8a7qroLxoQ/y4voovGO
5ceP/Ar1Fx3Sg6FLVXZCSVzvj5whlW49z457b9joGmAy/UzgEr6EVJvhRa/nS1c8
0Tpq93th9eSVpTE0i6JCXRzYthHy9u6CXU2pKgwCys5eSwNHAJkjXOG8T65ogkBD
SrtPfG2FrHNspvKE8SdMhsHgHjj4neaxAAr+WVwGUibTKcsoFETJ6gmopSJOcfoW
zic1TYMMTyIv33DmJAba8ss81zgLAQamFMev6M/x6BsvagVR5y7UL9rmdhuam2fg
8Iu/+EBe/p0ktP9auFVJxciwptRvUMu+dBUPrTiBAfWgzerf9FeNb8isIFUWyUS0
79JfrwK1Tk9lSS0HY98P5l3GTiBdo7FMlHd3XbelSqQP8b6eqmgBntAA3wl7gxQs
/2LluZZdPDGsbjhNmd/aUoFAkLiTbgBm1hrMAeHbuUpGCnl4r0eNHTig3dV82lZd
u6/zF7ktzaeYb/HWZSAbE1dHAfYtg38qV2IjmkhHjq1A3EXfA35/q+oDuoQbDSpm
gvhsy8IMfLrEEjj2qgh2KMM9wLflcobkfc917pFUrKk4vGSrl1I=
=eE0d
-----END PGP SIGNATURE-----

--muWSw0Tqy8JCNnD3--

