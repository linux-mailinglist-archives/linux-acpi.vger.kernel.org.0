Return-Path: <linux-acpi+bounces-6611-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5299172DA
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2024 22:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A7A1C2205C
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2024 20:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9DA17DE25;
	Tue, 25 Jun 2024 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFQV/FuT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE8917DE03;
	Tue, 25 Jun 2024 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349039; cv=none; b=P5eQBEaKhv1WPfzrG2Jt1I4rD66o1le9nYidehMJaDitkSWeo4M3azCwCw+Y6AgcyPQ3F6gTigqScy5055Qx8Iow1OCxnWgm5N7f+ayli1UN8XqDNK8YK7P3bj/FXIepONxrC7k/gDp1Hru0ATFeUgeKB81gJsR3rMgAWnQN5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349039; c=relaxed/simple;
	bh=5fsfbVK4qabZThs1tFbt1qSYC+jPp4L1mF+zVd5qC28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0iZCuBUjf5mw6UcPZb6kPOoDc5uhZtaD9DJ/Ao6bJgsu552/R6HehWXrQZwJwH7e/S91QjsrMbQPmpK4XPUb4UIfE/i0OZFWvaTtlgk7h3JG+Ogve/jbtVLx2lRaeLeAWLD2dqLb40l1bto1wM3TtOoDOTFAoIT1zM/GiDK0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFQV/FuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B6BC4AF09;
	Tue, 25 Jun 2024 20:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719349038;
	bh=5fsfbVK4qabZThs1tFbt1qSYC+jPp4L1mF+zVd5qC28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFQV/FuTZ+EBahZNfw/61L/XIyC+jlYZ1w9Lf9YxZLpqtpQeZCgf75AMFRKKnf7HH
	 ekPA/jAtfAL/6JxXu6KtpiII+n/8+iMYsjpH/TSx2kTwrqyYebwupWGZxXpfoJLqto
	 4/xfGa7BckvAFxBR0pWMgwH3v7RTqTpUNy5LBZ29E+DsOZdS+S4T32jBLoQk7XgS9s
	 dwo5gHBCMHqCvJkK0mGFrmC/cjK0fQPZfvIONC/oeOVSmFN+XI82pR/OZzFDT5BzqS
	 zSOTG9MpaeVTlugymnDumFkuEFJ6glZZ5ptgAtYyDlCga/4XW+5EeloP3NH3PPHw7H
	 SMownox1vwCDw==
Date: Tue, 25 Jun 2024 21:57:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH 2/5] ACPI: sysfs: use device lifecycle for _STR result
Message-ID: <a72495c3-c996-4be7-bc64-ba10d5400971@sirena.org.uk>
References: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
 <20240613-acpi-sysfs-groups-v1-2-665e0deb052a@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WbEsPB7lvZ69YniQ"
Content-Disposition: inline
In-Reply-To: <20240613-acpi-sysfs-groups-v1-2-665e0deb052a@weissschuh.net>
X-Cookie: You do not have mail.


--WbEsPB7lvZ69YniQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:15:33PM +0200, Thomas Wei=DFschuh wrote:
> The string assigned to dev->pnp.str effectively shares the lifetime of
> the device. Use devm_-APIs to avoid a manual cleanup path.
>=20
> This will be useful when the attributes themselves will be managed by
> the device core.

This is in -next since 20240624 and appears to be causing issues on
Cavium Thunder X2 in the Arm lab - with arm64 defconfig we see a bunch
of log messages like:

<6>[   50.120962] ACPI: button: Power Button [PWRB]
<6>[   50.120962] ACPI: button: Power Button [PWRB]
<2>[   50.138595] acpi LNXTHERM:00: Resources present before probing
<2>[   50.138595] acpi LNXTHERM:00: Resources present before probing
<2>[   50.150873] acpi LNXTHERM:01: Resources present before probing
<2>[   50.150873] acpi LNXTHERM:01: Resources present before probing
<2>[   50.163134] acpi LNXTHERM:02: Resources present before probing
<2>[   50.163134] acpi LNXTHERM:02: Resources present before probing
<2>[   50.175393] acpi LNXTHERM:03: Resources present before probing
<2>[   50.175393] acpi LNXTHERM:03: Resources present before probing
<2>[   50.187653] acpi LNXTHERM:04: Resources present before probing
<2>[   50.187653] acpi LNXTHERM:04: Resources present before probing
<2>[   50.199913] acpi LNXTHERM:05: Resources present before probing
<2>[   50.199913] acpi LNXTHERM:05: Resources present before probing
<2>[   50.212171] acpi LNXTHERM:06: Resources present before probing
<2>[   50.212171] acpi LNXTHERM:06: Resources present before probing
<2>[   50.224433] acpi LNXTHERM:07: Resources present before probing
<2>[   50.224433] acpi LNXTHERM:07: Resources present before probing
<2>[   50.236703] acpi LNXTHERM:08: Resources present before probing

(some other bug seems to be doubling all the log lines.)  We also see
PCI getting upset:

<6>[   50.238119] pcieport 0000:00:03.0: Refused to change power state from=
 D0 to D3hot

and the ethernet driver gets confused:

[ 71.592299] mlx5_core 0000:0b:00.1: Port module event: module 1, Cable unp=
lugged

while the cable is most definitely connected, we're netbooting.  A
bisect pointed at this commit, full bisect log below:

git bisect start
# status: waiting for both good and bad commits
# bad: [62c97045b8f720c2eac807a5f38e26c9ed512371] Add linux-next specific f=
iles for 20240624
git bisect bad 62c97045b8f720c2eac807a5f38e26c9ed512371
# status: waiting for good commit(s), bad commit known
# good: [f2661062f16b2de5d7b6a5c42a9a5c96326b8454] Linux 6.10-rc5
git bisect good f2661062f16b2de5d7b6a5c42a9a5c96326b8454
# bad: [dff8aaf6c690e2a3ff1ece04a78d494e7111b97f] Merge branch 'master' of =
git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect bad dff8aaf6c690e2a3ff1ece04a78d494e7111b97f
# good: [0dcf65f1a6999ce2efcce2d956c43698ad5cb910] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
git bisect good 0dcf65f1a6999ce2efcce2d956c43698ad5cb910
# bad: [1da968e3bbd7ea713af0a23ff6b708772d024691] Merge branch 'cpufreq/arm=
/linux-next' of git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
git bisect bad 1da968e3bbd7ea713af0a23ff6b708772d024691
# good: [998d61dc008b677c845a0c7ef69dcb1d2b3d5546] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
git bisect good 998d61dc008b677c845a0c7ef69dcb1d2b3d5546
# good: [5dc494b479a6e7c4a4425bb353c25b219e07c894] Merge branch 'hwmon-next=
' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
git bisect good 5dc494b479a6e7c4a4425bb353c25b219e07c894
# good: [156922faabcef2979cb2ddc2fbaa659b5ea37f54] media: atomisp: Switch t=
o new Intel CPU model defines
git bisect good 156922faabcef2979cb2ddc2fbaa659b5ea37f54
# good: [2b582118f1f42928129922c94a174f0cc42b38fe] Merge branch 'thermal-in=
tel' into linux-next
git bisect good 2b582118f1f42928129922c94a174f0cc42b38fe
# good: [d499aee48012b899f5bc814fef9021520411cab7] Merge branch 'docs-mw' i=
nto docs-next
git bisect good d499aee48012b899f5bc814fef9021520411cab7
# bad: [1c524c86afa8555e8add0c83c9d58e147cdf8f23] Merge branch 'pm-cpufreq'=
 into linux-next
git bisect bad 1c524c86afa8555e8add0c83c9d58e147cdf8f23
# good: [70d80903e265dc81e2bf390e5b301a32b2344ff4] Merge branch 'thermal' i=
nto linux-next
git bisect good 70d80903e265dc81e2bf390e5b301a32b2344ff4
# bad: [fe66d86311693574aca1b9624f92e273c13d1b3b] ACPI: sysfs: remove retur=
n value of acpi_device_setup_files()
git bisect bad fe66d86311693574aca1b9624f92e273c13d1b3b
# bad: [30fb30aa9ab68e0f638ae775de6284c41e8910b2] ACPI: sysfs: use device l=
ifecycle for _STR result
git bisect bad 30fb30aa9ab68e0f638ae775de6284c41e8910b2
# good: [3fd84db96b212a321ad381bf0341f45f952285b7] ACPI: sysfs: convert utf=
-16 from _STR to utf-8 only once
git bisect good 3fd84db96b212a321ad381bf0341f45f952285b7
# first bad commit: [30fb30aa9ab68e0f638ae775de6284c41e8910b2] ACPI: sysfs:=
 use device lifecycle for _STR result

--WbEsPB7lvZ69YniQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ7LykACgkQJNaLcl1U
h9AAWwf+J53s+mWML2j3kILWA8reLz+h0bbwnEnn65jvyeMVn6lsjd0xgOP0icHp
eXvJPSAPQ2ZL+5Uv/mU5tGHRdtOAFcCyqlphifrF/6fImXpCqV7gGDbbUfl+0nH2
87HlhM/wGPvwU3j/TBobNwwtM6iQCeo4No/Sjoh5x9sbAFiWoCnVOY0HLQlvtP8Y
9GxmkCU84ARvkEUJqrJve1y9siw67asBAcQ3l16Ly+/025Bf24pcclWyuC0l1EKv
txucLwcxpDu2Cjl9JB5ht5dean68mcJ8AsHVJLiUx+xmF/5NCQHMp0P41Ra/olZg
IE5eGSVhlIDC8Kh0ScuI8tbzFJshvw==
=Crok
-----END PGP SIGNATURE-----

--WbEsPB7lvZ69YniQ--

