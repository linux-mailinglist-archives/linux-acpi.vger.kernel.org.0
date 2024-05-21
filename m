Return-Path: <linux-acpi+bounces-5931-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26EC8CB634
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 00:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C461F21B66
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 22:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66572149C66;
	Tue, 21 May 2024 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="vBGwbRRu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CBC58AC1;
	Tue, 21 May 2024 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716332333; cv=none; b=EYnE0zfSshQaOeuk/qHEoFhpVkRVM/McKUfLa/KCnfgwk3mm0N+EiVvbg/O/aToYa/0KVC04IjV6s2NaC/BiYaGR8AD4k8E9hGKVEY1l/i7w9RI3KTbtqcertIQKZH27BGASZw+5HYoq4/TGPrgtCih8els34uRduvn4UtC5LKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716332333; c=relaxed/simple;
	bh=/B63K473/HxOhEaoZ5QSdxb9axvdA6PXOTlKChP8wTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmBjWE4NKkMDFgzoso9MEhcIJstJRhx/u0bZrbnJKxLhwPM2/5phMK8v4MawwjbS9x/LFNo7ME3VE38QEj6Fp5m+P2MUzZwIjR0dSTmXYyrjFgkneJl6UodEJgWOxBUVQPhC+DIUkvUBVboWGORFQ1eBb+R7rZrxoBlhKbDt4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=vBGwbRRu; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1716332328;
	bh=m5I1hOOLWDM4EKnSwZVCL6AUhsSRzC0ZdbYcp6s33oY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vBGwbRRuKRF0BQiFf/r+f85cMaXx1vDJoO0/C/n/9sqfHuTJy6wLzuKQE8oDglY+z
	 ePqh4kdTxZbFsRemBV1RoNVIQumRJdGbE98CHUDLHiiowMHfqpqN4uH8inbOE0mO03
	 X0z6pUdTDGWBUfntSnY9RWI4TYgludTdNReIYWbLCqwGwqJqhAOymGg4x3R9kHY8Lw
	 bcv/f79IMzYbEV0Z+Zy4XZch+ugi3rmWpbAOEnIBVK5riT0msEBH8JkEzYvhuPuTEz
	 TkgNB2uU1rlLQ9vjxkAgZGpkW/m7rYPCxcSXuWCEgHmpTUIGQBocjO1y0BowFbMO8r
	 ZW9mtHgvaUJjQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VkVGt0NJ5z4wx5;
	Wed, 22 May 2024 08:58:45 +1000 (AEST)
Date: Wed, 22 May 2024 08:58:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Laura Nao
 <laura.nao@collabora.com>, mika.westerberg@linux.intel.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "kernelci.org bot"
 <bot@kernelci.org>
Subject: Re: [PATCH] gpiolib: acpi: Move ACPI device NULL check to
 acpi_can_fallback_to_crs()
Message-ID: <20240522085844.16cba3f4@canb.auug.org.au>
In-Reply-To: <Zkyo6DL7NQltLLNr@smile.fi.intel.com>
References: <20240513095610.216668-1-laura.nao@collabora.com>
	<ZkHlLLLoagsYlll7@smile.fi.intel.com>
	<b20b567f-ce96-45e8-aab7-29768f8313f5@leemhuis.info>
	<Zkyo6DL7NQltLLNr@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f4YoUvWlnSG1U.tc=fqyysd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/f4YoUvWlnSG1U.tc=fqyysd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tue, 21 May 2024 17:00:08 +0300 Andy Shevchenko <andriy.shevchenko@linux=
.intel.com> wrote:
>
> Because:
>=20
> - that's the policy of Linux Next (do not include what's not supposed to =
be
>   merged during merge window), Cc'ed to Stephen to clarify, it might be t=
hat
>   I'm mistaken

My current daily reports say "Do not add any work intended for v6.11 to
your linux-next included branches until after v6.10-rc1 has been
released".  i.e. we don't want new development work added to linux-next
during the merge window as that may just cause unnecessary conflicts or
build failures while we are trying to just get the merge window done.

I have always said (maybe not recently) that bug fixes are always
welcome.  Also, more urgent bug fixes often just bypass linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/f4YoUvWlnSG1U.tc=fqyysd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmZNJyQACgkQAVBC80lX
0Gw8nwf/YZtacic07OrQgrRr+3kjNmlsFymQdM0iKgZwpQVnU+njjrMSqsaPkR6+
XCbbMBVuWXUCgZA8/uZNikakUqd0A6/By+Mb1AdZNbBL53sD9L9q1rtyTFzbWCuG
1toNLpyk9GiYbUjLcsguHF8iRPpyFFO24CpokgZNkq5QoJ6WZbhN8H0WhInCtVGe
ml3K1WvqMS1oShOGl6A6xeciD9J1v83mnYgCLQ4wWW0eESP8VDL47zH6WwUkuahQ
qOESWjMX/Ug6xP9xwF9y6WXjCL0MLxE9IULLb+MHyanbVIVwPDbF7JtTy0Tq8gb9
C5jmjOH/PBE+mC4QH9aQPBWp0vO36A==
=YofX
-----END PGP SIGNATURE-----

--Sig_/f4YoUvWlnSG1U.tc=fqyysd--

